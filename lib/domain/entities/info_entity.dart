import 'dart:convert';

class InfoEntity {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  InfoEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory InfoEntity.fromMap(Map<String, dynamic> map) {
    return InfoEntity(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }
  String toJson() => json.encode(toMap());
  factory InfoEntity.fromJson(String source) => InfoEntity.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
