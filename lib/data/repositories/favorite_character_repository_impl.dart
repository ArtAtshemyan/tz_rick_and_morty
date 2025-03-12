import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rick_and_morty/domain/entities/character_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/constants/app_urls.dart';
import '/common/constants/shared_preferences_keys.dart';
import '/config/network/dio_client.dart';
import '/config/network/dio_config.dart';
import '/config/network/failure.dart';
import '/domain/repositories/favorite_character_repository.dart';

class FavoriteCharacterRepositoryImpl implements FavoriteCharacterRepository {
  final SharedPreferences localDataSource;
  final DioClient remoteDataSource;

  FavoriteCharacterRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  List<int> getSavedCharacters() {
    final charactersList = localDataSource.getStringList(
          SharedPreferencesKeys.favoriteCharacters,
        ) ??
        [];
    return charactersList.map((e) => int.parse(e)).toList();
  }

  @override
  void removeCharacter(int id) async {
    final charactersList = localDataSource.getStringList(
          SharedPreferencesKeys.favoriteCharacters,
        ) ??
        [];
    charactersList.remove(id.toString());
    storeCharacters(charactersList);
  }

  @override
  void saveCharacter(int id) async {
    final charactersList = localDataSource.getStringList(
          SharedPreferencesKeys.favoriteCharacters,
        ) ??
        [];
    !charactersList.contains(id.toString())
        ? charactersList.add(id.toString())
        : charactersList;
    storeCharacters(charactersList);
  }

  @override
  void storeCharacters(List<String> characters) async {
    await localDataSource.setStringList(
      SharedPreferencesKeys.favoriteCharacters,
      characters,
    );
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> fetchCharactersByIds(
      List<int> ids) async {
    try {
      final remoteCharacter =
          await remoteDataSource.get('${AppUrls.characterEndpoint}/$ids');
      final List<dynamic> data = remoteCharacter.data;
      final result = data.map((e) => CharacterEntity.fromJson(e)).toList();
      return Right(result);
    } on DioException catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
