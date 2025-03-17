import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/extension/context_extension.dart';
import '/common/theme/app_colors.dart';
import '/domain/entities/character_entity.dart';
import '/presentation/manager/cubit/favorite_character_cubit/favorite_character_cubit.dart';
import '/presentation/widgets/character_card.dart';

class FavoriteCharacterPage extends StatefulWidget {
  const FavoriteCharacterPage({super.key});

  @override
  State<FavoriteCharacterPage> createState() => _FavoriteCharacterPageState();
}

class _FavoriteCharacterPageState extends State<FavoriteCharacterPage> {
  List<CharacterEntity> character = [];
  List<int> favoriteIds = [];

  @override
  void initState() {
    context.read<FavoriteCharacterCubit>().loadFavoriteCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCharacterCubit, FavoriteCharacterState>(
      builder: (context, state) {
        if (state is FavoriteCharactersLoading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FavoriteCharactersLoaded) {
          character = state.characters;
          favoriteIds = state.favoriteIds;
        } else if (state is FavoriteCharactersError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16.0,
              children: [
                Icon(
                  Icons.error_outline_outlined,
                  size: 100.0,
                  color: AppColors.red,
                ),
                Text(
                  state.failure.message,
                  style: context.titleLarge,
                ),
              ],
            ),
          );
        }
        if (character.isEmpty) {
          return Center(
            child: Text(
              'There are currently no saved heroes.',
              style: context.titleLarge,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CharacterCard(
                  key: ValueKey(character[index].id),
                  character: character[index],
                  isFavorite: favoriteIds.contains(character[index].id),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: character.length,
            ),
          );
        }
      },
    );
  }
}
