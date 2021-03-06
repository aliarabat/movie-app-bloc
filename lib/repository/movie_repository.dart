import 'package:pop_movies/model/movie.dart';
import 'package:pop_movies/model/movie_detail.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies({int limit, int page, String genre});
  Future<List<Movie>> getSuggestedMovies({int movie_id});

  Future<List<Movie>> searchMoviesByKeyword({int limit, String keyword}) {}

  Future<MovieDetail> getMovieDetail({int movieId}) {}
}
