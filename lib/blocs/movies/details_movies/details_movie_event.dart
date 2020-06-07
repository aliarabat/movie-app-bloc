import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDetailMovies extends DetailMoviesEvent {
  final int movieId;
  FetchDetailMovies({
    this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}