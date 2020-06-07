import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/model/movie.dart';

abstract class SuggestedMoviesState extends Equatable {
  const SuggestedMoviesState();

  @override
  List<Object> get props => [];
}

class SuggestedMoviesFailure extends SuggestedMoviesState {}

class SuggestedMoviesLoadInProgress extends SuggestedMoviesState {}

class SuggestedMoviesLoadSuccess extends SuggestedMoviesState {
  final List<Movie> suggestedMovies;
  const SuggestedMoviesLoadSuccess({this.suggestedMovies});
  SuggestedMoviesLoadSuccess copyWith({List<Movie> suggestedMovies}) {
    return SuggestedMoviesLoadSuccess(
        suggestedMovies: suggestedMovies ?? this.suggestedMovies);
  }

  @override
  List<Object> get props => [suggestedMovies];
}
