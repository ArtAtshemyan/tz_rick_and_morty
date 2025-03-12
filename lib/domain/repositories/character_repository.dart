import 'package:dartz/dartz.dart';
import '/domain/entities/character_entity.dart';

import '/config/network/failure.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> fetchCharacters(int page);
}
