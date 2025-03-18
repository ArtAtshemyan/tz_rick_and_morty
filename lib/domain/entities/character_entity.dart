import 'package:hive/hive.dart';

part 'character_entity.g.dart';

@HiveType(typeId: 0)
class CharacterEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final Location location;
  @HiveField(7)
  final Origin origin;
  @HiveField(8)
  final List<String> episode;
  @HiveField(9)
  final bool isFavorite;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin,
    required this.episode,
    required this.isFavorite,
  });

  CharacterEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        species = json['species'],
        gender = json['gender'],
        image = json['image'],
        location = Location.fromJson(json['location']),
        origin = Origin.fromJson(json['origin']),
        episode = List<String>.from(json['episode']),
        isFavorite = json['isFavorite'] ?? false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'gender': gender,
        'image': image,
        'location': location.toJson(),
        'origin': origin.toJson(),
        'episode': episode,
        'isFavorite': isFavorite,
      };

  CharacterEntity copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? gender,
    String? image,
    Location? location,
    Origin? origin,
    List<String>? episode,
    bool? isFavorite,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      location: location ?? this.location,
      origin: origin ?? this.origin,
      episode: episode ?? List.from(this.episode),
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@HiveType(typeId: 1)
class Location {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  Location({required this.name, required this.url});

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}

@HiveType(typeId: 2)
class Origin {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  Origin({required this.name, required this.url});

  Origin.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
