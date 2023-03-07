import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:moviesapp_2023/key.dart';

import 'actors.dart';

Future<Cast> fetchCasts(movieId) async {
  const String keyVar = key;
  var url = Uri.parse(
      "https://api.themoviedb.org/3/movie/$movieId/casts?api_key=$keyVar");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Cast.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the trening Movies');
  }
}

class Actors extends StatefulWidget {
  final int movieId;
  Actors(this.movieId);
  @override
  _ActorsState createState() => _ActorsState(movieId);
}

class _ActorsState extends State<Actors> {
  int movieId;
  _ActorsState(this.movieId);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCasts(this.movieId),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'loading',
              style: kbiglight,
            ),
          );
        } else {
          final List castData = snapshot.data.cast;
          castData.removeWhere((item) => item['profile_path'] == null);
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.purple,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.purple
                  ],
                  stops: [
                    0.0,
                    0.09,
                    0.91,
                    1.0
                  ], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: castData.length,
                itemBuilder: (context, index) {
                  final String actorImage = castData[index]['profile_path'];
                  final String actorName = castData[index]['name'];
                  final String cname = castData[index]['charactor'];
                  return Container(
                    // color: Colors.red,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'http://image.tmdb.org/t/p/w780/$actorImage')))),
                        Text(
                          actorName,
                          style: knormalsmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
