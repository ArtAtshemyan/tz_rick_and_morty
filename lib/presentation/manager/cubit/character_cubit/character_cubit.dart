import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/domain/entities/character_entity.dart';
import '/domain/repositories/character_repository.dart';
import '/domain/repositories/favorite_character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository _characterRepository;
  final FavoriteCharacterRepository _favoriteCharacterRepository;

  CharacterCubit(this._characterRepository, this._favoriteCharacterRepository)
      : super(CharacterInitial());

  int page = 1;

  Future<void> loadCharacters() async {
    if (state is CharactersLoading) return;

    final currentState = state;

    var oldCharacter = <CharacterEntity>[];
    if (currentState is CharactersLoaded) {
      oldCharacter = currentState.characters;
    }
    final favoriteIds = _favoriteCharacterRepository.getSavedCharacters();

    emit(CharactersLoading(
      oldCharacterList: oldCharacter,
      isFirstFetch: page == 1,
      favoriteIds: favoriteIds,
    ));
    try {
      final characters = await _characterRepository.fetchCharacters(page);
      page++;
      characters.fold((error) => emit(CharactersError(error.toString())),
          (character) {
        final newCharacter = (state as CharactersLoading).oldCharacterList;
        newCharacter.addAll(character);
        emit(CharactersLoaded(
          characters: newCharacter,
          favoriteIds: favoriteIds,
        ));
      });
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
