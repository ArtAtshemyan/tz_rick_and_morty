import 'package:dartz/dartz.dart';
import '/domain/entities/character_entity.dart';

import '/config/network/failure.dart';

abstract class FavoriteCharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> fetchCharactersByIds(
      List<int> ids);
  void storeCharacters(List<String> characters);
  void saveCharacter(int id);
  void removeCharacter(int id);
  List<int> getSavedCharacters();
}
