import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/blocs/movies/details_movies/details_movies_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movies_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/search_movies/search_movies_bloc.dart';
import 'package:flutter_infinite_list/pages/movies_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/repository/movie_repository_impl.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                ListMoviesBloc(movieRepository: MovieRepositoryImpl())),
        BlocProvider(
          create: (BuildContext context) =>
              DetailMoviesBloc(movieRepository: MovieRepositoryImpl()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              SearchMoviesBloc(movieRepository: MovieRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'OldStandardTT',
          primaryColor: Colors.deepOrange[800],
          cursorColor: Colors.deepOrange[800],
        ),
        debugShowCheckedModeBanner: false,
        home: MoviesHome(),
      ),
    );
  }
}
