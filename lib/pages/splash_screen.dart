import 'package:flutter/material.dart';
import 'package:pop_movies/pages/movies_home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static const size = 100.0;

  static const kIcons = <Icon>[
    Icon(
      Icons.all_inclusive,
      size: size,
    ),
    Icon(
      Icons.verified_user,
      size: size,
    ),
    Icon(
      Icons.burst_mode,
      size: size,
    ),
    Icon(
      Icons.info,
      size: size,
    ),
  ];

  @override
  void initState() {
    super.initState();
    this._tabController = TabController(length: kIcons.length, vsync: this)
      ..addListener(_listener);
  }

  bool isSkipped = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kIcons.length,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: IconTheme(
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: TabBarView(
                        children: kIcons,
                        controller: _tabController,
                      ),
                    ),
                  ),
                  TabPageSelector(
                    controller: _tabController,
                  ),
                  if (isSkipped)
                    RaisedButton.icon(
                      label:
                          Text('Next', style: TextStyle(color: Colors.white)),
                      icon: Icon(Icons.arrow_forward, color: Colors.white,),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(MoviesHome.route(context));
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._tabController.dispose();
    super.dispose();
  }

  void _listener() {
    this.setState(() {
      _tabController.index == (kIcons.length - 1)
          ? this.isSkipped = true
          : this.isSkipped = false;
    });
  }
}
