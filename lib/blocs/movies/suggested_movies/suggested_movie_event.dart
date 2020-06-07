import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SuggestedMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSuggestedMovies extends SuggestedMoviesEvent {
  final int movie_id;

  GetSuggestedMovies(this.movie_id);
  @override
  List<Object> get props => [movie_id];
}
