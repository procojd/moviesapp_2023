import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapp_2023/key.dart';
import 'package:moviesapp_2023/screens/explore.dart';
import 'package:moviesapp_2023/screens/popularmovies.dart';
import 'package:moviesapp_2023/screens/trendingmovies.dart';
import 'package:moviesapp_2023/utils/style.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:movie_app_flutter/utils/text.dart';
// import 'package:movie_app_flutter/widgets/toprated.dart';
// import 'package:movie_app_flutter/widgets/trending.dart';
// import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
          brightness: Brightness.dark, primaryColor: Colors.redAccent[400]),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = key;
  final String readaccesstoken = rat;
  List trendingmovies = [];
  List topratedmovies = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();

    // print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var textController;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Moviesapp', style: kbigsmall),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('So are you getting bored?', style: klarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimSearchBar(
                width: MediaQuery.of(context).size.width * 1,
                textController: textController,
                onSuffixTap: null,
                onSubmitted: (p0) {},
                color: Color.fromARGB(255, 226, 226, 226),
                textFieldColor: Color.fromARGB(255, 231, 231, 231),
                searchIconColor: kc1,
                textFieldIconColor: kc1,
                helpText: "Lords of the ring",
                style: kbiglight,
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //       Color.fromARGB(255, 252, 211, 208),
                  //       Colors.white
                  //     ]),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      // SizedBox(height: 20),
                      TabBar(
                        tabs: [
                          const Tab(
                            text: "Explore",
                            icon: Icon(CupertinoIcons.bolt_horizontal_fill),
                            iconMargin: EdgeInsets.all(0),
                          ),
                          const Tab(
                            text: "Watchlist",
                            icon: Icon(CupertinoIcons.list_bullet_indent),
                            iconMargin: EdgeInsets.all(0),
                          ),
                          const Tab(
                            text: "Favourites",
                            icon: Icon(CupertinoIcons.suit_heart_fill),
                            iconMargin: EdgeInsets.all(0),
                          ),
                        ],
                        labelStyle: knormal,
                        labelColor: Colors.white,
                        unselectedLabelColor: kc1,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kc1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 0),
                      ),

                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            explore(topratedmovies, trendingmovies),
                            explore(topratedmovies, trendingmovies),
                            explore(topratedmovies, trendingmovies)
                            // yrlist(),
                            // // yourRecipe(),

                            // explore2(),
                            // Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]

                  // children: [
                  //   TrendingMovies(trendingmovies),
                  //   TopRatedMovies(topratedmovies)
                  // ],
                  ),
        ));
  }
}
