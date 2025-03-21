import 'package:dartz/dartz.dart';

import '/common/constants/hive_keys.dart';
import '/config/hive/hive_service.dart';
import '/config/network/failure.dart';
import '/domain/entities/character_entity.dart';

abstract class FavoriteCharLocalDataSource {
  Future<Either<Failure, List<CharacterEntity>>>
      fetchFavoriteCharactersFromLocalDB();
  Future<void> saveCharacterInFavoriteLocalDB(CharacterEntity character);
  Future<void> deleteCharacterInFavoriteLocalDB(int index);
}

class FavoriteCharLocalDataSourceImpl implements FavoriteCharLocalDataSource {
  final HiveService<CharacterEntity> hiveService;

  FavoriteCharLocalDataSourceImpl({required this.hiveService});

  @override
  Future<Either<Failure, List<CharacterEntity>>>
      fetchFavoriteCharactersFromLocalDB() async {
    try {
      // Получаем все персонажи из коробки "favoriteCharacters"
      final favoriteCharacters =
          hiveService.getAllItems(HiveKeys.favoriteCharacters);
      return Right(favoriteCharacters);
    } catch (e) {
      return Left(
        Failure(
          500,
          'Ошибка при получении избранных персонажей из локального хранилища',
        ),
      );
    }
  }

  @override
  Future<void> saveCharacterInFavoriteLocalDB(CharacterEntity character) async {
    try {
      // Добавляем персонажа в коробку "favoriteCharacters"
      await hiveService.addItem(HiveKeys.favoriteCharacters, character);
    } catch (e) {
      throw Exception('Ошибка при сохранении персонажа в избранном');
    }
  }

  @override
  Future<void> deleteCharacterInFavoriteLocalDB(int index) async {
    try {
      // Удаляем персонажа по индексу из коробки "favoriteCharacters"
      await hiveService.deleteItem(HiveKeys.favoriteCharacters, index);
    } catch (e) {
      throw Exception('Ошибка при удалении персонажа из избранного');
    }
  }
}
