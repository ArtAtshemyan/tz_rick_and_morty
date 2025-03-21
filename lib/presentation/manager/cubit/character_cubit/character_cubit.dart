import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/config/network/failure.dart';
import '/domain/entities/character_entity.dart';
import '/domain/repositories/character_repository.dart';
import '/domain/repositories/favorite_character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository _characterRepository;
  final FavoriteCharacterRepository _favoriteCharacterRepository;

  CharacterCubit(
    this._characterRepository,
    this._favoriteCharacterRepository,
  ) : super(CharacterInitial());

  int page = 1;

  Future<void> loadCharacters({bool? isNoneNewPage}) async {
    if (state is CharactersLoading) return;

    final currentState = state;

    var oldCharacter = <CharacterEntity>[];
    if (currentState is CharactersLoaded) {
      oldCharacter = currentState.characters;
    }

    final favoriteResult =
        await _favoriteCharacterRepository.fetchFavoritesCharacter();
    var favoriteIds = [];
    favoriteResult.fold((failure) => emit(CharactersError(failure)),
        (characters) {
      favoriteIds = characters.map((e) => e.id).toList();
    });

    emit(
      CharactersLoading(
        oldCharacterList: oldCharacter,
        isFirstFetch: page == 1,
        favoriteIds: favoriteIds as List<int>,
      ),
    );

    try {
      if (isNoneNewPage != null && isNoneNewPage == true && page > 1) {
        page = page - 1;
      }
      final characters = await _characterRepository.fetchCharacters(page);
      if (page < 42) {
        page++;
      }
      characters.fold(
        (error) => emit(
          CharactersError(error),
        ),
        (characterList) {
          final newCharacter = (state as CharactersLoading).oldCharacterList;
          for (var character in characterList) {
            if (!newCharacter.contains(character)) {
              newCharacter.add(character);
            }
          }
          emit(
            CharactersLoaded(
              characters: newCharacter,
              favoriteIds: favoriteIds as List<int>,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        CharactersError(Failure(500, 'Not Fixed Error')),
      );
    }
  }
}
