import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String medium_cover_image;
  final String background_image;
  final String small_cover_image;
  final String description_full;
  Movie({
    this.id,
    this.title,
    this.medium_cover_image,
    this.background_image,
    this.small_cover_image,
    this.description_full,
  });

  Movie copyWith({
    int id,
    String title,
    String medium_cover_image,
    String background_image,
    String small_cover_image,
    String description_full,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      medium_cover_image: medium_cover_image ?? this.medium_cover_image,
      background_image: background_image ?? this.background_image,
      small_cover_image: small_cover_image ?? this.small_cover_image,
      description_full: description_full ?? this.description_full,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'medium_cover_image': medium_cover_image,
      'background_image': background_image,
      'small_cover_image': small_cover_image,
      'description_full': description_full,
    };
  }

  static Movie fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Movie(
      id: map['id'],
      title: map['title'],
      medium_cover_image: map['medium_cover_image'],
      background_image: map['background_image'],
      small_cover_image: map['small_cover_image'],
      description_full: map['description_full'],
    );
  }

  String toJson() => json.encode(toMap());

  static Movie fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, medium_cover_image: $medium_cover_image, background_image: $background_image, small_cover_image: $small_cover_image, description_full: $description_full)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Movie &&
      o.id == id &&
      o.title == title &&
      o.medium_cover_image == medium_cover_image &&
      o.background_image == background_image &&
      o.small_cover_image == small_cover_image &&
      o.description_full == description_full;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      medium_cover_image.hashCode ^
      background_image.hashCode ^
      small_cover_image.hashCode ^
      description_full.hashCode;
  }
}
