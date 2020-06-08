import 'package:equatable/equatable.dart';
import 'package:pop_movies/model/movie.dart';

abstract class ListMoviesState extends Equatable {
  final List<Movie> movies;
  final String currentGenre;
  final bool hasReachedMax;
  const ListMoviesState({this.currentGenre, this.movies, this.hasReachedMax});

  @override
  List<Object> get props => [];
}

class MoviesInitial extends ListMoviesState {}

class MoviesLoadInProgress extends ListMoviesState {
  const MoviesLoadInProgress({String genre}) : super(currentGenre: genre);
}

class MoviesFailure extends ListMoviesState {}

class MoviesLoadSuccess extends ListMoviesState {
  const MoviesLoadSuccess(
      {List<Movie> movies, bool hasReachedMax, String genre})
      : super(
            movies: movies, hasReachedMax: hasReachedMax, currentGenre: genre);
  MoviesLoadSuccess copyWith({
    List<Movie> movies,
    bool hasReachedMax,
    String genre,
  }) {
    return MoviesLoadSuccess(
        movies: movies ?? this.movies,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        genre: genre ?? this.currentGenre);
  }

  @override
  List<Object> get props => [movies, hasReachedMax];
}
