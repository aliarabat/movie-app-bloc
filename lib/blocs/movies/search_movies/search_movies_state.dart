import 'package:equatable/equatable.dart';
import 'package:pop_movies/model/movie.dart';

abstract class SearchMoviesState extends Equatable {
  final List<Movie> movies;

  const SearchMoviesState({this.movies});

  @override
  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoadInProgress extends SearchMoviesState {}

class SearchMoviesFailure extends SearchMoviesState {}

class SearchMoviesLoadSuccess extends SearchMoviesState {
  const SearchMoviesLoadSuccess({List<Movie> movies}) : super(movies: movies);

  @override
  List<Object> get props => [];
}
