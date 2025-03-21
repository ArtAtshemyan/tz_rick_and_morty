import 'package:dartz/dartz.dart';

import '/config/network/failure.dart';
import '/domain/entities/character_entity.dart';

abstract class FavoriteCharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> fetchFavoritesCharacter();
  void saveCharacter(CharacterEntity character);
  void removeCharacter(int index);
}
