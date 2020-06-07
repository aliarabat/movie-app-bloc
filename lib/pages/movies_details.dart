import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/details_movies/details_movie_event.dart';
import 'package:flutter_infinite_list/blocs/movies/details_movies/details_movies_bloc.dart';
import 'package:flutter_infinite_list/blocs/movies/details_movies/details_movies_state.dart';
import 'package:flutter_infinite_list/blocs/movies/list_movies/list_movies_bloc.dart';
import 'package:flutter_infinite_list/model/cast.dart';
import 'package:flutter_infinite_list/model/movie.dart';
import 'package:flutter_infinite_list/model/movie_detail.dart';

class MoviesDetail extends StatefulWidget {
  final Movie movie;

  const MoviesDetail({
    Key key,
    this.movie,
  }) : super(key: key);

  static Route<dynamic> route({Movie movie, BuildContext context}) =>
      MaterialPageRoute(
        builder: (context) => MoviesDetail(
          movie: movie,
        ),
      );

  @override
  _MoviesDetailState createState() => _MoviesDetailState();
}

class _MoviesDetailState extends State<MoviesDetail> {
  DetailMoviesBloc detailMoviesBloc;
  // SuggestedMoviesBloc suggestedMoviesBloc;
  final TextStyle labelStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    detailMoviesBloc = BlocProvider.of<DetailMoviesBloc>(context)
      ..add(FetchDetailMovies(movieId: widget.movie.id));
    // suggestedMoviesBloc = BlocProvider.of<SuggestedMoviesBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // moviesBloc.add(FetchSuggestedMovies(widget.movie.id, suggestedMoviesBloc));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: size.height * .4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.movie.background_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(widget.movie.title),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              _buildIntro(movie: widget.movie, size: size),
              BlocBuilder<DetailMoviesBloc, DetailMoviesState>(
                  builder: (_, state) {
                if (state is MoviesDetailLoadInProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: <Widget>[
                    _buildDivider(),
                    _buildChips(
                        title: 'Genres', data: state.movieDetail?.genres),
                    _buildDivider(),
                    _buildRowSection(
                        state.movieDetail?.year,
                        state.movieDetail?.rating,
                        state.movieDetail?.like_count),
                    _buildDivider(),
                    _buildChips(
                        title: 'Categories',
                        data: state.movieDetail?.torrents != null
                            ? state.movieDetail.torrents
                                .map((t) => t.quality)
                                .toList()
                            : null),
                    _buildDivider(),
                    _buildCast(size, state.movieDetail?.cast),
                  ],
                );
              }),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildIntro({final Movie movie, final Size size}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
              tag: movie.id,
              child: Image.network(
                movie.medium_cover_image,
                width: size.width * .35,
              )),
          SizedBox(width: size.width * .025),
          Container(
            width: size.width * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description',
                  style: labelStyle,
                  textScaleFactor: 1.5,
                ),
                Text(
                  movie.description_full,
                  style: TextStyle(color: Colors.black),
                  textScaleFactor: 1,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.deepOrange[700],
      thickness: .5,
    );
  }

  Widget _buildChips({String title, List<String> data}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: labelStyle, textScaleFactor: 1.5),
          Container(
            width: double.infinity,
            height: 30,
            child: data != null
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: data
                        .map((label) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Chip(
                                label: Text(
                                  label,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ))
                        .toList(),
                  )
                : Center(child: Text('No ${title.toLowerCase()} found')),
          ),
        ],
      ),
    );
  }

  Widget _buildRowSection(int year, double rating, int likeCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildStatsItem(iconData: Icons.calendar_today, label: '$year'),
        _buildStatsItem(iconData: Icons.star, label: '$rating'),
        _buildStatsItem(iconData: Icons.thumb_up, label: '$likeCount')
      ],
    );
  }

  Widget _buildStatsItem({IconData iconData, String label}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40.0)),
            padding: EdgeInsets.all(15.0),
            child: Icon(iconData, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            label != null ? label : 0,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCast(final Size size, List<Cast> casts) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Cast', style: labelStyle, textScaleFactor: 1.5),
          casts != null
              ? SizedBox(
                  width: size.width,
                  height: 106,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(2.0),
                    children: casts
                        .map(
                          (cast) => Container(
                            padding: EdgeInsets.all(3.0),
                            width: 85,
                            // height: 100,
                            child: GridTile(
                              child: cast.url_small_image != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  cast.url_small_image),
                                              fit: BoxFit.fill),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.2)),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.2)),
                                      child: Center(
                                        child: Text(
                                          cast.name
                                              .split(' ')
                                              .map((i) =>
                                                  '${i[0].toUpperCase()} ')
                                              .join(),
                                          textScaleFactor: 1.2,
                                        ),
                                      ),
                                    ),
                              footer: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.8)),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  cast.name,
                                  textScaleFactor: .7,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : Center(
                  child: Text('No cast found'),
                ),
        ],
      ),
    );
  }
}
