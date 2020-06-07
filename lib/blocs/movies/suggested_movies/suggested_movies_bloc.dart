import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/suggested_movies/suggested_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/suggested_movies/suggested_movies_state.dart';
import 'package:flutter_infinite_list/repository/movie_repository.dart';

class SuggestedMoviesBloc
    extends Bloc<SuggestedMoviesEvent, SuggestedMoviesState> {
  final MovieRepository movieRepository;

  SuggestedMoviesBloc({this.movieRepository});
  @override
  SuggestedMoviesState get initialState => SuggestedMoviesLoadInProgress();

  @override
  Stream<SuggestedMoviesState> mapEventToState(
      SuggestedMoviesEvent event) async* {
    if (event is GetSuggestedMovies) {
      yield* _mapSuggestedMoviesToState(event.movie_id);
    }
  }

  Stream<SuggestedMoviesState> _mapSuggestedMoviesToState(int movie_id) async* {
    yield SuggestedMoviesLoadInProgress();
    try {
      final suggestedMovies =
          await movieRepository.getSuggestedMovies(movie_id: movie_id);
      yield SuggestedMoviesLoadSuccess(suggestedMovies: suggestedMovies);
    } catch (_) {
      yield SuggestedMoviesFailure();
    }
  }
}
