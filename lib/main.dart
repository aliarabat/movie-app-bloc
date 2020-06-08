import 'package:flutter/material.dart';
import 'package:pop_movies/blocs/movies/details_movies/details_movies_bloc.dart';
import 'package:pop_movies/blocs/movies/list_movies/list_movies_bloc.dart';
import 'package:pop_movies/blocs/movies/search_movies/search_movies_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_movies/pages/splash_screen.dart';
import 'package:pop_movies/repository/movie_repository_impl.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepositoryImpl(),
      child: Builder(builder: (context) {
        final movieRepository =
            RepositoryProvider.of<MovieRepositoryImpl>(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) =>
                    ListMoviesBloc(movieRepository: movieRepository)),
            BlocProvider(
              create: (BuildContext context) =>
                  DetailMoviesBloc(movieRepository: movieRepository),
            ),
            BlocProvider(
              create: (BuildContext context) =>
                  SearchMoviesBloc(movieRepository: movieRepository),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'OldStandardTT',
              primaryColor: Colors.deepOrange[800],
              cursorColor: Colors.deepOrange[800],
              accentColor: Colors.deepOrange[800],
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.deepOrange[800],
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      }),
    );
  }
}
