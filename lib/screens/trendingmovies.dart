import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moviesapp_2023/key.dart';
import 'package:moviesapp_2023/moviemodel.dart';

import 'package:moviesapp_2023/utils/style.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../description.dart';
import '../main.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  TrendingMovies(this.trending);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending movies',
            style: kbiglight,
          ),
          const SizedBox(height: 10),
          Container(
              height: 310,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                      trending[index]['title'],
                                      trending[index]['overview'],
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['backdrop_path'],
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path'],
                                      trending[index]['vote_average']
                                          .toString(),
                                      trending[index]['release_date'],
                                      trending[index]['id'])));
                        },
                        child: Container(
                          // color: Colors.red,
                          width: 220,
                          // height: 300,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trending[index]['poster_path']),
                                        fit: BoxFit.cover),
                                  ),
                                  height: 250,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    trending[index]['title'] != null
                                        ? trending[index]['title']
                                        : 'Loading',
                                    style: knormal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        right: 15,
                        child: SpeedDial(
                          animatedIcon: AnimatedIcons.menu_arrow,
                          foregroundColor: kc1,
                          buttonSize: Size(
                            40,
                            40,
                          ),
                          overlayColor: Colors.transparent,
                          overlayOpacity: 0.0,
                          // label: Text(
                          //   'Order',
                          //   style: kbig,
                          // ),
                          backgroundColor: Colors.white,
                          childPadding: EdgeInsets.all(5),

                          children: [
                            SpeedDialChild(
                              child: const Icon(
                                CupertinoIcons.heart_solid,
                                color: kc2,
                              ),
                              // label: 'favourite',
                              labelStyle: kbig,

                              backgroundColor: Colors.white,
                              onTap: () {
                                /* Do someting */
                                addmovie(index);
                              },
                            ),
                            SpeedDialChild(
                              child: const Icon(
                                CupertinoIcons.list_bullet_indent,
                                color: kc2,
                              ),
                              // label: 'watched',
                              labelStyle: kbig,

                              backgroundColor: Colors.white,
                              onTap: () {
                                addmovie1(index);
                                /* Do someting */
                              },
                            ),
                          ],
                        ),
                      )
                    ]);
                  }))
        ],
      ),
    );
  }

  void addmovie(int index) {
    box.add(Add(
        title: trending[index]['title'],
        overview: trending[index]['overview'],
        // ignore: prefer_interpolation_to_compose_strings
        backdrop: 'https://image.tmdb.org/t/p/w500' +
            trending[index]['backdrop_path'],
        // ignore: prefer_interpolation_to_compose_strings
        poster:
            'https://image.tmdb.org/t/p/w500' + trending[index]['poster_path'],
        rating: trending[index]['vote_average'].toString(),
        releasedate: trending[index]['release_date'],
        id: trending[index]['id'].toString()));
  }

  void addmovie1(int index) {
    box1.add(Add(
        title: trending[index]['title'],
        overview: trending[index]['overview'],
        // ignore: prefer_interpolation_to_compose_strings
        backdrop: 'https://image.tmdb.org/t/p/w500' +
            trending[index]['backdrop_path'],
        // ignore: prefer_interpolation_to_compose_strings
        poster:
            'https://image.tmdb.org/t/p/w500' + trending[index]['poster_path'],
        rating: trending[index]['vote_average'].toString(),
        releasedate: trending[index]['release_date'],
        id: trending[index]['id'].toString()));
  }
}
