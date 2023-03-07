import 'package:flutter/material.dart';
import 'package:moviesapp_2023/key.dart';
import 'package:moviesapp_2023/utils/style.dart';

import '../description.dart';

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
                    return InkWell(
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
                                    trending[index]['vote_average'].toString(),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
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
                    );
                  }))
        ],
      ),
    );
  }
}
