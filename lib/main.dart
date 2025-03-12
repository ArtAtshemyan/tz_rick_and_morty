import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/app_manager.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;

  /// DI(iOC locator, Service locator, Dependency Injection)
  await injectionInit();
  runApp(
    const AppManager(),
  );
}
