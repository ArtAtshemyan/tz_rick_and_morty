import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/entities/character_entity.dart';
import '/presentation/manager/cubit/character_cubit/character_cubit.dart';
import '/presentation/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final scrollController = ScrollController();

  List<int> favoriteIds = [];
  List<CharacterEntity> character = [];
  bool isLoading = false;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<CharacterCubit>().loadCharacters();
        }
      }
    });
  }

  @override
  void initState() {
    setupScrollController(context);
    context.read<CharacterCubit>().loadCharacters();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    favoriteIds = [];
    character = [];
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharactersLoading && state.isFirstFetch) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is CharactersLoading) {
        character = state.oldCharacterList;
        favoriteIds = state.favoriteIds;
        isLoading = true;
      } else if (state is CharactersLoaded) {
        character = state.characters;
        favoriteIds = state.favoriteIds;
      } else if (state is CharactersError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < character.length) {
              bool isFavorite = favoriteIds.contains(character[index].id);
              return CharacterCard(
                character: character[index],
                isFavorite: isFavorite,
              );
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: character.length + (isLoading ? 1 : 0),
        ),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
