part of 'character_cubit.dart';

sealed class CharacterState extends Equatable {
  const CharacterState();
}

final class CharacterInitial extends CharacterState {
  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharacterState {
  final List<CharacterEntity> oldCharacterList;
  final List<int> favoriteIds;
  final bool isFirstFetch;

  const CharactersLoading({
    required this.oldCharacterList,
    required this.isFirstFetch,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [oldCharacterList, favoriteIds];
}

class CharactersLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final List<int> favoriteIds;

  const CharactersLoaded({
    required this.characters,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [
        characters,
      ];
}

class CharactersError extends CharacterState {
  final Failure failure;
  const CharactersError(this.failure);
  @override
  List<Object?> get props => [failure];
}
