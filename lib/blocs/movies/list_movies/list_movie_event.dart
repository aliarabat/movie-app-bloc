import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_infinite_list/blocs/movies/suggested_movies/suggested_movies_bloc.dart';

@immutable
abstract class ListMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMovies extends ListMoviesEvent {
  final String genre;
  FetchMovies({
    this.genre,
  });

  @override
  List<Object> get props => [genre];
}

class FetchSuggestedMovies extends ListMoviesEvent {
  final SuggestedMoviesBloc suggestedMoviesBloc;
  final int movie_id;

  FetchSuggestedMovies(this.movie_id, this.suggestedMoviesBloc);
  @override
  List<Object> get props => [movie_id, suggestedMoviesBloc];
}