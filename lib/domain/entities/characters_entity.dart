import 'package:rick_and_morty/domain/entities/info_entity.dart';

import 'character_entity.dart';

class CharactersEntity {
  InfoEntity info;
  final List<CharacterEntity> characters;

  CharactersEntity({required this.info, required this.characters});

  factory CharactersEntity.fromJson(Map<String, dynamic> json) {
    final info = InfoEntity.fromMap(json['info']);
    final characters = (json['results'] as List)
        .map((characterJson) => CharacterEntity.fromJson(characterJson))
        .toList();

    return CharactersEntity(info: info, characters: characters);
  }
}
