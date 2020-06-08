import 'dart:convert';

import 'package:pop_movies/Constants/movies_urls.dart';
import 'package:pop_movies/model/movie.dart';
import 'package:pop_movies/model/movie_detail.dart';
import 'package:pop_movies/repository/movie_repository.dart';
import 'package:http/http.dart' as http;

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<Movie>> getMovies({int limit, int page, String genre}) {
    return http
        .get('${MoviesUrls.list_movies}page=$page&limit=$limit&genre=$genre')
        .then((response) {
      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        return (rawData['data']['movies'] as List<dynamic>)
            .map((m) => Movie.fromMap(m as dynamic))
            .toList();
      }
      return null;
    }).catchError((error) {
      throw Exception('Failed to load movies');
    });
  }

  @override
  Future<List<Movie>> getSuggestedMovies({int movie_id}) {
    return http.get('${MoviesUrls.suggested_movies}$movie_id').then((response) {
      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        print(rawData);
        return (rawData['data']['movies'] as List<dynamic>)
            .map((m) => Movie.fromMap(m as dynamic))
            .toList();
      }
      return null;
    }).catchError((error) {
      throw Exception('Failed to load movies');
    });
  }

  @override
  Future<List<Movie>> searchMoviesByKeyword({int limit = 10, String keyword}) {
    return http
        .get('${MoviesUrls.list_movies}&limit=$limit&query_term=$keyword')
        .then((response) {
      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        return (rawData['data']['movies'] as List<dynamic>)
            .map((m) => Movie.fromMap(m as dynamic))
            .toList();
      }
      return null;
    }).catchError((error) {
      throw Exception('Failed to load movies');
    });
  }

  @override
  Future<MovieDetail> getMovieDetail({int movieId}) {
     return http
        .get('${MoviesUrls.detail_movies}&movie_id=$movieId&with_cast=true')
        .then((response) {
      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        return MovieDetail.fromMap(rawData['data']['movie']);
      }
      return null;
    }).catchError((error) {
      throw Exception('Failed to load movies');
    });
  }
}
