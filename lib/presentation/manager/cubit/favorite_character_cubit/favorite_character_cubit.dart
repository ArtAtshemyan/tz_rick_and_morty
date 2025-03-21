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
      final characters =
          await _favoriteCharacterRepository.fetchFavoritesCharacter();

      characters.fold(
        (error) =>
            emit(FavoriteCharactersError(ErrorHandler.handle(error).failure)),
        (characterList) {
          emit(FavoriteCharactersLoaded(
            characters: characterList,
          ));
        },
      );
    } catch (error) {
      final errorText = ErrorHandler.handle(error).failure;
      emit(FavoriteCharactersError(errorText));
    }
  }

  Future<void> deleteFavoriteCharacters(int index) async {
    try {
      _favoriteCharacterRepository.removeCharacter(index);
      final favoriteIds =
          await _favoriteCharacterRepository.fetchFavoritesCharacter();

      if (state is FavoriteCharactersLoaded) {
        favoriteIds.fold(
          (error) =>
              emit(FavoriteCharactersError(ErrorHandler.handle(error).failure)),
          (characterList) {
            emit(FavoriteCharactersLoaded(
              characters: characterList,
            ));
          },
        );
      } else {
        await loadFavoriteCharacters();
      }
    } catch (error) {
      final errorText = ErrorHandler.handle(error).failure;
      emit(FavoriteCharactersError(errorText));
    }
  }

  Future<void> saveFavoriteCharacters(CharacterEntity character) async {
    try {
      _favoriteCharacterRepository.saveCharacter(character);
      final favoriteIds =
          await _favoriteCharacterRepository.fetchFavoritesCharacter();

      if (state is FavoriteCharactersLoaded) {
        favoriteIds.fold(
          (error) =>
              emit(FavoriteCharactersError(ErrorHandler.handle(error).failure)),
          (characterList) {
            emit(FavoriteCharactersLoaded(
              characters: characterList,
            ));
          },
        );
      } else {
        await loadFavoriteCharacters();
      }
    } catch (error) {
      final errorText = ErrorHandler.handle(error).failure;
      emit(FavoriteCharactersError(errorText));
    }
  }
}
