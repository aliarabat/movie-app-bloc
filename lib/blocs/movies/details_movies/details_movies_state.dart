import 'package:equatable/equatable.dart';
import 'package:pop_movies/model/movie_detail.dart';

abstract class DetailMoviesState extends Equatable {
  final MovieDetail movieDetail;
  const DetailMoviesState({this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

class MoviesDetailInitial extends DetailMoviesState {}

class MoviesDetailLoadInProgress extends DetailMoviesState {}

class MoviesDetailFailure extends DetailMoviesState {}

class MoviesDetailLoadSuccess extends DetailMoviesState {
  const MoviesDetailLoadSuccess({MovieDetail movieDetail})
      : super(movieDetail: movieDetail);
}
