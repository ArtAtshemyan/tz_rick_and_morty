import 'package:dartz/dartz.dart';

import '/common/constants/hive_keys.dart';
import '/config/hive/hive_service.dart';
import '/config/network/failure.dart';
import '/domain/entities/character_entity.dart';

abstract class CharacterLocalDataSource {
  Future<Either<Failure, List<CharacterEntity>>> fetchCharactersFromLocalDB();
  Future<void> charactersToCatchInLocalDB(List<CharacterEntity> characters);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final HiveService<CharacterEntity> hiveService;

  CharacterLocalDataSourceImpl({required this.hiveService});

  @override
  Future<Either<Failure, List<CharacterEntity>>>
      fetchCharactersFromLocalDB() async {
    try {
      // Получаем всех персонажей из коробки "characters"
      final characters = hiveService.getAllItems(HiveKeys.characters);
      return Right(characters);
    } catch (e) {
      return Left(
        Failure(
          500,
          'Ошибка при получении персонажей из локального хранилища',
        ),
      );
    }
  }

  @override
  Future<void> charactersToCatchInLocalDB(
      List<CharacterEntity> characters) async {
    try {
      final existingCharacters = hiveService.getAllItems(HiveKeys.characters);

      for (var character in characters) {
        // Проверяем, есть ли уже такой персонаж (по ID)
        bool alreadyExists =
            existingCharacters.any((c) => c.id == character.id);

        if (!alreadyExists) {
          await hiveService.addItem(HiveKeys.characters, character);
        }
      }
    } catch (e) {
      throw Exception('Ошибка при сохранении персонажей в локальное хранилище');
    }
  }
}
