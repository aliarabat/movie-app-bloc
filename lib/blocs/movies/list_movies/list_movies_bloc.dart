import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movies_state.dart';
import 'package:flutter_infinite_list/blocs/movies/suggested_movies/suggested_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/suggested_movies/suggested_movies_bloc.dart';
import 'package:flutter_infinite_list/repository/movie_repository.dart';

class ListMoviesBloc extends Bloc<ListMoviesEvent, ListMoviesState> {
  final MovieRepository movieRepository;
  // final SuggestedMoviesBloc suggestedMoviesBloc;
  ListMoviesBloc({
    this.movieRepository,
    // this.suggestedMoviesBloc,
  });
  @override
  ListMoviesState get initialState => MoviesLoadInProgress();

  @override
  Stream<ListMoviesState> mapEventToState(ListMoviesEvent event) async* {
    final currentState = state;
    if (event is FetchMovies && !_hahReachedMax(currentState)) {
      yield* _mapListMoviesToState(currentState, event.genre);
    }
    // else if (event is FetchSuggestedMovies) {
    //   event.suggestedMoviesBloc.add(GetSuggestedMovies(event.movie_id));
    // }
  }

  bool _hahReachedMax(ListMoviesState currentState) {
    return currentState is MoviesLoadSuccess && currentState.hasReachedMax;
  }

  Stream<ListMoviesState> _mapListMoviesToState(
      ListMoviesState currentState, final String genre) async* {
    try {
      if ((currentState.movies == null && currentState.movies?.length == 0) ||
          currentState.currentGenre != genre) {
        yield MoviesLoadInProgress(genre: genre);
        final movies = await movieRepository.getMovies(
            page: 1, limit: 12, genre: genre.toLowerCase());
        yield MoviesLoadSuccess(
            movies: movies, hasReachedMax: false, genre: genre);
        return;
      }
      if (currentState is MoviesLoadSuccess) {
        final movies = await movieRepository.getMovies(
            page: (currentState.movies.length ~/ 12) + 1,
            limit: 12,
            genre: currentState.currentGenre.toLowerCase());
        yield movies.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : currentState.copyWith(movies: currentState.movies + movies);
      }
    } catch (_) {
      yield MoviesFailure();
    }
  }
}
