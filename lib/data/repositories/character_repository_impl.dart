import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/constants/app_urls.dart';
import '/common/constants/shared_preferences_keys.dart';
import '/config/connection/network_connection.dart';
import '/config/network/dio_client.dart';
import '/config/network/dio_config.dart';
import '/config/network/failure.dart';
import '/domain/entities/character_entity.dart';
import '/domain/entities/characters_entity.dart';
import '/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final DioClient remoteDataSource;
  final SharedPreferences localDataSource;
  final NetworkConnection networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>> fetchCharacters(
      int page) async {
    if (await networkInfo.isConnected) {
      try {
        final pageCount = page > 42 ? 42 : page;
        final remoteCharacter = await remoteDataSource
            .get('${AppUrls.characterEndpoint}?page=$pageCount');
        final result = CharactersEntity.fromJson(remoteCharacter.data);
        _characterToCache(result.characters, SharedPreferencesKeys.characters);
        return Right(result.characters);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try {
        final localCharacter =
            await _getLastCharacterFromCache(SharedPreferencesKeys.characters);
        return Right(localCharacter);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }

  Future<List<CharacterEntity>> _getLastCharacterFromCache(String key) {
    final jsonCharactersList = localDataSource.getStringList(key);
    if (jsonCharactersList!.isNotEmpty) {
      return Future.value(
        jsonCharactersList
            .map(
              (character) => CharacterEntity.fromJson(
                json.decode(character),
              ),
            )
            .toList(),
      );
    } else {
      final error = Failure(500, 'There are currently no saved heroes.');
      throw error.message;
    }
  }

  Future<List<String>> _characterToCache(
      List<CharacterEntity> characters, String key) {
    final List<String> jsonCharactersList =
        characters.map((character) => json.encode(character.toJson())).toList();

    localDataSource.setStringList(key, jsonCharactersList);
    return Future.value(jsonCharactersList);
  }
}
