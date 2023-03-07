import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesapp_2023/screens/popularmovies.dart';
import 'package:moviesapp_2023/screens/trendingmovies.dart';

class explore extends StatelessWidget {
  List trendingmovies = [];
  List topratedmovies = [];
  explore(this.topratedmovies, this.trendingmovies);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          TrendingMovies(trendingmovies),
          TopRatedMovies(topratedmovies)
        ],
      ),
    );
  }
}
