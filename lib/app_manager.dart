import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/manager/cubit/character_cubit/character_cubit.dart';
import 'common/route/route.dart';
import 'common/theme/theme_manager.dart';
import 'locator_service.dart';
import 'presentation/manager/cubit/favorite_character_cubit/favorite_character_cubit.dart';

class AppManager extends StatelessWidget {
  const AppManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemesCubit(
            sl(),
          ),
        ),
        BlocProvider(
          create: (context) => sl<CharacterCubit>()
            ..loadCharacters(
              isNoneNewPage: true,
            ),
        ),
        BlocProvider(
          create: (context) => sl<FavoriteCharacterCubit>(),
        ),
      ],
      child: BlocBuilder<ThemesCubit, ThemeData>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Rick and Morty',
            debugShowCheckedModeBanner: false,
            theme: themeState,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.navRoute,
          );
        },
      ),
    );
  }
}
