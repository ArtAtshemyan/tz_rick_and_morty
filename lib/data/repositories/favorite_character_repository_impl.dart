import 'package:dartz/dartz.dart';

import '/config/network/dio_config.dart';
import '/config/network/failure.dart';
import '/data/source/local/favorite_char_local_data_source.dart';
import '/domain/entities/character_entity.dart';
import '/domain/repositories/favorite_character_repository.dart';

class FavoriteCharacterRepositoryImpl implements FavoriteCharacterRepository {
  final FavoriteCharLocalDataSource localDataSource;

  FavoriteCharacterRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>>
      fetchFavoritesCharacter() async {
    try {
      // Получаем список избранных персонажей из локальной БД
      final result = await localDataSource.fetchFavoriteCharactersFromLocalDB();

      return result.fold(
        (failure) => Left(failure),
        (characters) => Right(characters),
      );
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<void> removeCharacter(int index) async {
    try {
      // Удаляем персонажа по индексу из локальной БД
      await localDataSource.deleteCharacterInFavoriteLocalDB(
        index,
      );
    } catch (error) {
      throw Exception(
        'Ошибка при удалении персонажа из избранного',
      );
    }
  }

  @override
  Future<void> saveCharacter(CharacterEntity character) async {
    try {
      // Сохраняем персонажа в избранное в локальной БД
      await localDataSource.saveCharacterInFavoriteLocalDB(character);
    } catch (error) {
      throw Exception(
        'Ошибка при сохранении персонажа в избранном',
      );
    }
  }
}
