import 'package:dartz/dartz.dart';

import '/common/constants/app_urls.dart';
import '/config/connection/network_connection.dart';
import '/config/network/dio_client.dart';
import '/config/network/dio_config.dart';
import '/config/network/failure.dart';
import '/data/source/local/character_local_data_source.dart';
import '/domain/entities/character_entity.dart';
import '/domain/entities/characters_entity.dart';
import '/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final DioClient remoteDataSource;
  final CharacterLocalDataSource localDataSource;
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
        final remoteCharacter = await remoteDataSource
            .get('${AppUrls.characterEndpoint}?page=$page');
        final result = CharactersEntity.fromJson(remoteCharacter.data);

        if (page == 1 || page == 2) {
          // Сохраняем в локальную БД для кэширования
          await localDataSource.charactersToCatchInLocalDB(result.characters);
        }

        // Возвращаем успешный результат с персонажами
        return Right(result.characters);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      try {
        // Получаем данные из локальной БД, если нет интернета
        final localCharacterResponse =
            await localDataSource.fetchCharactersFromLocalDB();

        // Используем fold, чтобы обработать оба варианта (ошибка или успех)
        return localCharacterResponse.fold(
          (failure) => Left(failure),
          (localCharacters) => Right(localCharacters),
        );
      } catch (error) {
        // В случае ошибки при работе с локальной БД
        return Left(
          DataSource.connectionError.getFailure(),
        );
      }
    }
  }
}
