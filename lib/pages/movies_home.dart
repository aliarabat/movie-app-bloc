import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/Constants/movies_constants.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movies_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movies_state.dart';
import 'package:flutter_infinite_list/model/movie.dart';
import 'package:flutter_infinite_list/pages/movies_details.dart';
import 'package:flutter_infinite_list/pages/search_delegate_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviesHome extends StatefulWidget {
  MoviesHome({Key key}) : super(key: key);

  @override
  _MoviesHomeState createState() => _MoviesHomeState();
}

class _MoviesHomeState extends State<MoviesHome> {
  ScrollController _scrollController;
  ListMoviesBloc moviesBloc;
  String selectedGenre;
  @override
  void initState() {
    super.initState();
    this.selectedGenre = MoviesConstants.genres[0];
    this.moviesBloc = BlocProvider.of<ListMoviesBloc>(context)
      ..add(FetchMovies(genre: selectedGenre));
    this._scrollController = ScrollController()..addListener(_listener);
  }

  Drawer startDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrangeAccent[100],
                    Colors.deepOrangeAccent[700]
                  ],
                ),
              ),
              child: FlutterLogo(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            dense: false,
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Movie app with flutter',
                applicationVersion: 'v1.0.1',
                applicationIcon: FlutterLogo(),
                children: [
                  Row(
                    children: <Widget>[
                      Text('Developed by : ',
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.w900)),
                      Text('ARABAT Ali', textScaleFactor: 1)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Contacts : ',
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.w900)),
                      Text('arabat50@gmail.com', textScaleFactor: 1),
                    ],
                  ),
                ],
                useRootNavigator: true,
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  _mail() async {
    const email = 'mailto:arabat50@gmail.com';
    if (await canLaunch(email)) {
      await launch(email);
    } else {
      print('throw exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ListMoviesBloc, ListMoviesState>(
          builder: (context, state) {
            return Text(state.currentGenre != null
                ? state.currentGenre
                : 'Home movies');
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch<Movie>(
                        context: context,
                        delegate: SearchDelegatePage(
                            searchFieldLabel: 'Search for movies'))
                    .then((value) {
                  if (value != null) {
                    Navigator.of(context).push(
                        MoviesDetail.route(context: context, movie: value));
                  }
                });
              }),
          PopupMenuButton<String>(
            itemBuilder: (context) => MoviesConstants.genres
                .map(
                  (g) => PopupMenuItem<String>(
                    child: Text(g),
                    value: g,
                    enabled: true,
                  ),
                )
                .toList(),
            onSelected: (value) {
              moviesBloc.add(FetchMovies(genre: value));
              this.selectedGenre = value;
            },
          ),
        ],
      ),
      drawer: startDrawer(),
      body: SafeArea(
        child: BlocBuilder<ListMoviesBloc, ListMoviesState>(
          builder: (context, state) {
            if (state is MoviesLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MoviesFailure) {
              return Center(
                child: Text('Cannot fetch data'),
              );
            }

            if (state is MoviesLoadSuccess) {
              if (state.movies == null || state.movies.isEmpty) {
                return Center(
                  child: Text('No movies found now'),
                );
              }
              return _buildMoviesList(state);
            }
            return Center(child: Text('An error occured'));
          },
        ),
      ),
    );
  }

  Widget _buildMoviesList(MoviesLoadSuccess state) {
    return state.movies.isNotEmpty
        ? GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              return _buildGridTile(state.movies[index]);
            },
            itemCount: state.movies.length,
          )
        : Center(
            child: Text('No movies found'),
          );
  }

  _listener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      moviesBloc.add(FetchMovies(genre: selectedGenre));
    }
  }

  Widget _buildGridTile(Movie movie) {
    return Hero(
      tag: movie.id,
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: NetworkImage(
                movie.medium_cover_image,
              ),
              fit: BoxFit.cover,
            ),
            color: Theme.of(context).primaryColor.withOpacity(.4),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MoviesDetail.route(movie: movie));
              },
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        footer: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.8),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              movie.title.length <= 14
                  ? movie.title
                  : '${movie.title.substring(0, 13)}...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }
}
