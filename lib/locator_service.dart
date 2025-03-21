import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/theme/theme_manager.dart';
import '/config/connection/network_connection.dart';
import '/config/hive/hive_service.dart';
import '/config/network/dio_client.dart';
import '/data/repositories/character_repository_impl.dart';
import '/data/repositories/favorite_character_repository_impl.dart';
import '/domain/entities/character_entity.dart';
import '/domain/repositories/character_repository.dart';
import '/domain/repositories/favorite_character_repository.dart';
import '/presentation/manager/cubit/favorite_character_cubit/favorite_character_cubit.dart';
import 'data/source/local/character_local_data_source.dart';
import 'data/source/local/favorite_char_local_data_source.dart';
import 'presentation/manager/cubit/character_cubit/character_cubit.dart';

final sl = GetIt.instance;

Future<void> injectionInit() async {
  ///  BLoC / Cubit
  sl.registerFactory(
    () => ThemesCubit(
      sl(),
    ),
  );
  sl.registerFactory(
    () => CharacterCubit(
      sl(),
      sl(),
    ),
  );

  sl.registerFactory(
    () => FavoriteCharacterCubit(
      sl(),
    ),
  );

  /// Repository
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<FavoriteCharacterRepository>(
    () => FavoriteCharacterRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  /// Source
  sl.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(
      hiveService: sl(),
    ),
  );

  sl.registerLazySingleton<FavoriteCharLocalDataSource>(
    () => FavoriteCharLocalDataSourceImpl(
      hiveService: sl(),
    ),
  );

  /// Services
  sl.registerLazySingleton<HiveService<CharacterEntity>>(
    () => HiveService<CharacterEntity>(),
  );
  sl.registerLazySingleton<HiveService<Location>>(
    () => HiveService<Location>(),
  );
  sl.registerLazySingleton<HiveService<OriginAdapter>>(
    () => HiveService<OriginAdapter>(),
  );

  /// Core
  sl.registerLazySingleton<NetworkConnection>(
    () => NetworkConnectionImp(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
