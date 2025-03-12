class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location location;
  final Origin origin;
  final List<String> episode;
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

class Location {
  final String name;
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

class Origin {
  final String name;
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
