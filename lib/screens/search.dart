import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviesapp_2023/description.dart';
import 'package:moviesapp_2023/key.dart';
import 'package:moviesapp_2023/screens/favourite.dart';
import 'package:moviesapp_2023/screens/popularmovies.dart';

import 'trending.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final searchController = TextEditingController();
  String movieName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<Trending> fetchMovies() async {
    final String keyVar = key;
    var url = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$keyVar&language=en-US&query=$movieName&include_adult=false");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Trending.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the trening Movies');
    }
  }

  // this widget shows not found image
  Widget _notFoundWidget() {
    return Center(
        // child: Image.asset('assets/images/not_found.png'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kc1.withOpacity(1),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Movie name',
                        hintStyle: knormallight,
                        focusColor: kc1,
                        labelStyle: knormallight),
                    controller: searchController,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                  // color: Colors.pink[200],
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (searchController.text != '') {
                      setState(() {
                        movieName = searchController.text;
                        fetchMovies();
                      });
                    } else {
                      setState(() {
                        movieName = '';
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: kc1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'search',
                        style: knormallight,
                      ),
                    ),
                  )),
            ),
            movieName == ''
                ? Expanded(
                    child: _notFoundWidget(),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: fetchMovies(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return _notFoundWidget();
                        } else {
                          final List movieData = snapshot.data.movies;
                          movieData.removeWhere(
                              (item) => item['poster_path'] == null);
                          if (movieData == []) {
                            return _notFoundWidget();
                          } else {
                            return HorizontalCards(movieData);
                          }
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class HorizontalCards extends StatelessWidget {
  final List movieData;
  HorizontalCards(this.movieData);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final String posterPath = movieData[index]['poster_path'];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Description(
                        movieData[index]['title'],
                        movieData[index]['overview'],
                        // ignore: prefer_interpolation_to_compose_strings
                        'https://image.tmdb.org/t/p/w500' +
                            movieData[index]['backdrop_path'],
                        // ignore: prefer_interpolation_to_compose_strings
                        'https://image.tmdb.org/t/p/w500' +
                            movieData[index]['poster_path'],
                        movieData[index]['vote_average'].toString(),
                        movieData[index]['release_date'],
                        movieData[index]['id']);
                  },
                ),
              );
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
                                    movieData[index]['poster_path']),
                            fit: BoxFit.cover),
                      ),
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        movieData[index]['title'] != null
                            ? movieData[index]['title']
                            : 'Loading',
                        style: knormal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          // 'http://image.tmdb.org/t/p/w780/$posterPath'
        },
      ),
    );
  }
}
