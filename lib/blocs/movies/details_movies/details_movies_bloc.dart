import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_movies/blocs/movies/details_movies/details_movie_event.dart';
import 'package:pop_movies/blocs/movies/details_movies/details_movies_state.dart';
import 'package:pop_movies/repository/movie_repository.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final MovieRepository movieRepository;
  DetailMoviesBloc({
    this.movieRepository,
  });
  @override
  DetailMoviesState get initialState => MoviesDetailLoadInProgress();

  @override
  Stream<DetailMoviesState> mapEventToState(DetailMoviesEvent event) async* {
    yield MoviesDetailLoadInProgress();
    if (event is FetchDetailMovies) {
      try {
        final movieDetail =
            await movieRepository.getMovieDetail(movieId: event.movieId);
        yield MoviesDetailLoadSuccess(movieDetail: movieDetail);
      } catch (e) {
        yield MoviesDetailFailure();
      }
    }
  }
}
