import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moviesapp_2023/key.dart';

import '../description.dart';
import '../main.dart';
import '../moviemodel.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  TopRatedMovies(this.toprated);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Rated Movies',
            style: kbiglight,
          ),
          SizedBox(height: 10),
          Container(
              height: 300,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Description(
                                      toprated[index]['title'],
                                      toprated[index]['overview'],
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          toprated[index]['backdrop_path'],
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          toprated[index]['poster_path'],
                                      toprated[index]['vote_average']
                                          .toString(),
                                      toprated[index]['release_date'],
                                      toprated[index]['id'])));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                toprated[index]['poster_path']),
                                        fit: BoxFit.cover),
                                  ),
                                  height: 200,
                                ),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    child: Text(
                                      toprated[index]['title'] != null
                                          ? toprated[index]['title']
                                          : 'Loading',
                                      style: knormal,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 120,
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
        title: toprated[index]['title'],
        overview: toprated[index]['overview'],
        // ignore: prefer_interpolation_to_compose_strings
        backdrop: 'https://image.tmdb.org/t/p/w500' +
            toprated[index]['backdrop_path'],
        // ignore: prefer_interpolation_to_compose_strings
        poster:
            'https://image.tmdb.org/t/p/w500' + toprated[index]['poster_path'],
        rating: toprated[index]['vote_average'].toString(),
        releasedate: toprated[index]['release_date'],
        id: toprated[index]['id'].toString()));
  }

  void addmovie1(int index) {
    box1.add(Add(
        title: toprated[index]['title'],
        overview: toprated[index]['overview'],
        // ignore: prefer_interpolation_to_compose_strings
        backdrop: 'https://image.tmdb.org/t/p/w500' +
            toprated[index]['backdrop_path'],
        // ignore: prefer_interpolation_to_compose_strings
        poster:
            'https://image.tmdb.org/t/p/w500' + toprated[index]['poster_path'],
        rating: toprated[index]['vote_average'].toString(),
        releasedate: toprated[index]['release_date'],
        id: toprated[index]['id'].toString()));
  }
}
