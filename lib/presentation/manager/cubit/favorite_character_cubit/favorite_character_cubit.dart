import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entities/character_entity.dart';

import '/config/network/dio_config.dart';
import '/config/network/failure.dart';
import '/domain/repositories/favorite_character_repository.dart';

part 'favorite_character_state.dart';

class FavoriteCharacterCubit extends Cubit<FavoriteCharacterState> {
  final FavoriteCharacterRepository _favoriteCharacterRepository;

  FavoriteCharacterCubit(
    this._favoriteCharacterRepository,
  ) : super(FavoriteCharacterInitial());

  Future<void> loadFavoriteCharacters() async {
    emit(FavoriteCharactersLoading());
    try {
      final favoriteIds = _favoriteCharacterRepository.getSavedCharacters();
      final characters =
          await _favoriteCharacterRepository.fetchCharactersByIds(favoriteIds);
      characters.fold(
        (error) =>
            emit(FavoriteCharactersError(ErrorHandler.handle(error).failure)),
        (characterList) {
          emit(FavoriteCharactersLoaded(
            characters: characterList,
            favoriteIds: favoriteIds.isNotEmpty ? favoriteIds : [],
          ));
        },
      );
    } catch (error) {
      final errorText = ErrorHandler.handle(error).failure;
      emit(FavoriteCharactersError(errorText));
    }
  }

  Future<void> deleteFavoriteCharacters(int id) async {
    _favoriteCharacterRepository.removeCharacter(id);
    final favoriteIds = _favoriteCharacterRepository.getSavedCharacters();

    if (state is FavoriteCharactersLoaded) {
      final currentState = state as FavoriteCharactersLoaded;
      final filteredCharacters = currentState.characters
          .where((char) => favoriteIds.contains(char.id))
          .toList();
      emit(FavoriteCharactersLoaded(
        characters: filteredCharacters,
        favoriteIds: favoriteIds,
      ));
    } else {
      await loadFavoriteCharacters();
    }
  }

  Future<void> saveFavoriteCharacters(int id) async {
    _favoriteCharacterRepository.saveCharacter(id);
    final favoriteIds = _favoriteCharacterRepository.getSavedCharacters();

    if (state is FavoriteCharactersLoaded) {
      final currentState = state as FavoriteCharactersLoaded;
      final filteredCharacters = currentState.characters
          .where((char) => favoriteIds.contains(char.id))
          .toList();
      emit(FavoriteCharactersLoaded(
        characters: filteredCharacters,
        favoriteIds: favoriteIds,
      ));
    } else {
      await loadFavoriteCharacters();
    }
  }
}
