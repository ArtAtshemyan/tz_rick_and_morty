import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '/app_manager.dart';
import '/common/constants/hive_keys.dart';
import '/config/hive/hive_service.dart';
import '/domain/entities/character_entity.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;

  /// Инициализация зависимостей (DI, локатор сервисов, внедрение зависимостей)
  await injectionInit();

  // Получаем путь к директории приложения
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  // Инициализируем Hive с указанием пути
  await Hive.initFlutter(appDocumentDirectory.path);

  /// Регистрация адаптера для сущности персонажа в Hive
  Hive.registerAdapter(CharacterEntityAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(OriginAdapter());

  /// Инициализация Hive-сервиса для работы с данными персонажей
  await sl<HiveService<CharacterEntity>>().init(HiveKeys.characters);

  /// Инициализация Hive-сервиса для работы с избранными персонажами
  await sl<HiveService<CharacterEntity>>().init(HiveKeys.favoriteCharacters);

  runApp(
    const AppManager(),
  );
}
