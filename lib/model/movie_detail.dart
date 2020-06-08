import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:pop_movies/model/cast.dart';
import 'package:pop_movies/model/torrent.dart';

class MovieDetail {
  final int id;
  final String url;
  final String imdb_code;
  final String title;
  final String medium_cover_image;
  final String small_cover_image;
  final String background_image_original;
  final String background_image;
  final String large_cover_image;
  final double rating;
  final int like_count;
  final int year;
  final List<String> genres;
  final List<Torrent> torrents;
  final List<Cast> cast;
  MovieDetail({
    this.id,
    this.url,
    this.imdb_code,
    this.title,
    this.medium_cover_image,
    this.small_cover_image,
    this.background_image_original,
    this.background_image,
    this.large_cover_image,
    this.rating,
    this.like_count,
    this.year,
    this.genres,
    this.torrents,
    this.cast,
  });

  MovieDetail copyWith({
    int id,
    String url,
    String imdb_code,
    String title,
    String medium_cover_image,
    String small_cover_image,
    String background_image_original,
    String background_image,
    String large_cover_image,
    double rating,
    int like_count,
    int year,
    List<String> genres,
    List<Torrent> torrents,
    List<Cast> cast,
  }) {
    return MovieDetail(
      id: id ?? this.id,
      url: url ?? this.url,
      imdb_code: imdb_code ?? this.imdb_code,
      title: title ?? this.title,
      medium_cover_image: medium_cover_image ?? this.medium_cover_image,
      small_cover_image: small_cover_image ?? this.small_cover_image,
      background_image_original:
          background_image_original ?? this.background_image_original,
      background_image: background_image ?? this.background_image,
      large_cover_image: large_cover_image ?? this.large_cover_image,
      rating: rating ?? this.rating,
      like_count: like_count ?? this.like_count,
      year: year ?? this.year,
      genres: genres ?? this.genres,
      torrents: torrents ?? this.torrents,
      cast: cast ?? this.cast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'imdb_code': imdb_code,
      'title': title,
      'medium_cover_image': medium_cover_image,
      'small_cover_image': small_cover_image,
      'background_image_original': background_image_original,
      'background_image': background_image,
      'large_cover_image': large_cover_image,
      'rating': rating,
      'like_count': like_count,
      'year': year,
      'genres': genres,
      'torrents': torrents?.map((x) => x?.toMap())?.toList(),
      'cast': cast?.map((x) => x?.toMap())?.toList(),
    };
  }

  static MovieDetail fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MovieDetail(
      id: map['id'],
      url: map['url'],
      imdb_code: map['imdb_code'],
      title: map['title'],
      medium_cover_image: map['medium_cover_image'],
      small_cover_image: map['small_cover_image'],
      background_image_original: map['background_image_original'],
      background_image: map['background_image'],
      large_cover_image: map['large_cover_image'],
      rating: map['rating'],
      like_count: map['like_count'],
      year: map['year'],
      genres: List<String>.from(map['genres']),
      torrents:
          List<Torrent>.from(map['torrents']?.map((x) => Torrent.fromMap(x))),
      cast: List<Cast>.from(map['cast']?.map((x) => Cast.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static MovieDetail fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieDetail(id: $id, url: $url, imdb_code: $imdb_code, title: $title, medium_cover_image: $medium_cover_image, small_cover_image: $small_cover_image, background_image_original: $background_image_original, background_image: $background_image, large_cover_image: $large_cover_image, rating: $rating, like_count: $like_count, year: $year, genres: $genres, torrents: $torrents, cast: $cast)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieDetail &&
        o.id == id &&
        o.url == url &&
        o.imdb_code == imdb_code &&
        o.title == title &&
        o.medium_cover_image == medium_cover_image &&
        o.small_cover_image == small_cover_image &&
        o.background_image_original == background_image_original &&
        o.background_image == background_image &&
        o.large_cover_image == large_cover_image &&
        o.rating == rating &&
        o.like_count == like_count &&
        o.year == year &&
        listEquals(o.genres, genres) &&
        listEquals(o.torrents, torrents) &&
        listEquals(o.cast, cast);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        imdb_code.hashCode ^
        title.hashCode ^
        medium_cover_image.hashCode ^
        small_cover_image.hashCode ^
        background_image_original.hashCode ^
        background_image.hashCode ^
        large_cover_image.hashCode ^
        rating.hashCode ^
        like_count.hashCode ^
        year.hashCode ^
        genres.hashCode ^
        torrents.hashCode ^
        cast.hashCode;
  }
}
