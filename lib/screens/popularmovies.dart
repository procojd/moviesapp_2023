import 'package:flutter/material.dart';
import 'package:moviesapp_2023/key.dart';

import '../description.dart';

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
                    return InkWell(
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
                                      toprated[index]['id']
                                    )));
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                    );
                  }))
        ],
      ),
    );
  }
}
