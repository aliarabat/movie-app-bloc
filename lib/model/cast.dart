import 'dart:convert';

class Cast {
  final String name;
  final String character_name;
  final String url_small_image;
  final String imdb_code;
  Cast({
    this.name,
    this.character_name,
    this.url_small_image,
    this.imdb_code,
  });

  Cast copyWith({
    String name,
    String character_name,
    String url_small_image,
    String imdb_code,
  }) {
    return Cast(
      name: name ?? this.name,
      character_name: character_name ?? this.character_name,
      url_small_image: url_small_image ?? this.url_small_image,
      imdb_code: imdb_code ?? this.imdb_code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'character_name': character_name,
      'url_small_image': url_small_image,
      'imdb_code': imdb_code,
    };
  }

  static Cast fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cast(
      name: map['name'],
      character_name: map['character_name'],
      url_small_image: map['url_small_image'],
      imdb_code: map['imdb_code'],
    );
  }

  String toJson() => json.encode(toMap());

  static Cast fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cast(name: $name, character_name: $character_name, url_small_image: $url_small_image, imdb_code: $imdb_code)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cast &&
        o.name == name &&
        o.character_name == character_name &&
        o.url_small_image == url_small_image &&
        o.imdb_code == imdb_code;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        character_name.hashCode ^
        url_small_image.hashCode ^
        imdb_code.hashCode;
  }
}
