import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/search_movies/search_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/search_movies/search_movies_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/search_movies/search_movies_state.dart';
import 'package:flutter_infinite_list/model/movie.dart';

class SearchDelegatePage extends SearchDelegate<Movie> {
  final String searchFieldLabel;

  SearchMoviesBloc searchMoviesBloc;
  Movie currentMovie;

  SearchDelegatePage({this.searchFieldLabel})
      : super(searchFieldLabel: searchFieldLabel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          this.query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (searchMoviesBloc == null) {
      searchMoviesBloc = BlocProvider.of<SearchMoviesBloc>(context);
    }
    searchMoviesBloc.add(FetchMoviesData(query));
    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
      if (state is SearchMoviesLoadInProgress) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is SearchMoviesFailure) {
        return Center(child: Text('Couldn\'t fetch movies'));
      }

      if (state.movies?.length == 0 || state.movies == null) {
        return Center(child: Text('No movies found'));
      }

      return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(state.movies[index].small_cover_image),
              ),
              title: Text(state.movies[index].title),
              onTap: () {
                close(context, state.movies[index]);
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: state.movies.length);
    });
    ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Icon(
        Icons.search,
        size: 100,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
