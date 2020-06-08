import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_movies/blocs/movies/search_movies/search_movie_event.dart';
import 'package:pop_movies/blocs/movies/search_movies/search_movies_state.dart';
import 'package:pop_movies/repository/movie_repository.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final MovieRepository movieRepository;
  // final SuggestedMoviesBloc suggestedMoviesBloc;
  SearchMoviesBloc({
    this.movieRepository,
    // this.suggestedMoviesBloc,
  });
  @override
  SearchMoviesState get initialState => SearchMoviesInitial();

  @override
  Stream<SearchMoviesState> mapEventToState(SearchMoviesEvent event) async* {
    final currentState = state;
    if (event is FetchMoviesData) {
      yield* _mapListMoviesToState(currentState, event.keyword);
    }
  }

  Stream<SearchMoviesState> _mapListMoviesToState(
      SearchMoviesState currentState, final String keyword) async* {
    yield SearchMoviesLoadInProgress();
    try {
      final movies =
          await movieRepository.searchMoviesByKeyword(keyword: keyword);
      yield SearchMoviesLoadSuccess(movies: movies);
    } catch (_) {
      yield SearchMoviesFailure();
    }
  }
}
