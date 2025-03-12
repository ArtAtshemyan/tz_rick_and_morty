part of 'favorite_character_cubit.dart';

sealed class FavoriteCharacterState extends Equatable {
  const FavoriteCharacterState();
}

final class FavoriteCharacterInitial extends FavoriteCharacterState {
  @override
  List<Object> get props => [];
}

class FavoriteCharactersLoading extends FavoriteCharacterState {
  @override
  List<Object?> get props => [];
}

class FavoriteCharactersLoaded extends FavoriteCharacterState {
  final List<CharacterEntity> characters;
  final List<int> favoriteIds;

  const FavoriteCharactersLoaded({
    required this.characters,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [characters, favoriteIds];
}

class FavoriteCharactersError extends FavoriteCharacterState {
  final Failure failure;
  const FavoriteCharactersError(this.failure);
  @override
  List<Object?> get props => [failure];
}
