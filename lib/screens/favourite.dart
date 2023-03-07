import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_2023/description.dart';
import 'package:moviesapp_2023/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moviesapp_2023/key.dart';

import '../moviemodel.dart';

// late Box box;

// ignore: camel_case_types
class fvlist extends StatefulWidget {
  @override
  State<fvlist> createState() => _fvlistState();
}

class _fvlistState extends State<fvlist> {
  int cardborder = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: const BoxDecoration(
            // color: Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: ValueListenableBuilder<Box<Add>>(
            valueListenable: Hive.box<Add>("addmovie").listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Favourite Movies',
                            style: kbigsmall,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: box.values.length,
                          itemBuilder: ((context, index) {
                            Add movie = box.getAt(index)!;

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // Recipedetail(movie: movie)
                                        Description(
                                            movie.title == null
                                                ? "loading"
                                                : movie.title!,
                                            movie.overview!,
                                            movie.backdrop!,
                                            movie.poster!,
                                            movie.rating!,
                                            movie.releasedate == null
                                                ? "Not aired"
                                                : movie.releasedate!,
                                            int.parse(movie.id!))),
                              ),
                              child: movieCard(
                                movie: movie,
                                index: index,
                              ),
                            );
                          })))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class movieCard extends StatefulWidget {
  Add movie;
  int index;
  // final RecipeModel recipeModel;

  movieCard({required this.movie, required this.index});

  @override
  State<movieCard> createState() => _movieCardState();
}

class _movieCardState extends State<movieCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 90,
                    width: 70,
                    child: Image.network(
                      widget.movie.poster!,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        // color: Colors.red,
                        child: Text(
                          widget.movie.title != null
                              ? widget.movie.title!
                              : "loading",
                          style: kbigsmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kc1.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: Text(
                            widget.movie.rating != null
                                ? widget.movie.rating! + "  ⭐️"
                                : "loading",
                            style: knormalsmall,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kc1.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: Text(
                            widget.movie.releasedate != null
                                ? "Releasing " + widget.movie.releasedate!
                                : "loading",
                            style: knormal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: "Delete",
                          content: "Remove this movie from favourite?",
                          positiveBtnText: "Yes",
                          negativeBtnText: "No it's good",
                          positiveBtnPressed: () {
                            widget.movie.delete();
                            Navigator.of(context).pop();
                          },
                        );
                      });
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: kc1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, content, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;

  CustomDialog({
    required this.title,
    required this.content,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SlideInUp(
            duration: Duration(milliseconds: 100),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  // Bottom rectangular box
                  // margin:
                  //     EdgeInsets.only(top: 40), // to push the box half way below circle
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.only(
                      top: 20, left: 20, right: 20), // spacing inside the box
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: kc1,
                        // Top Circle with icon
                        maxRadius: 20.0,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      // Text(
                      //   title,
                      //   style: kbiglight,
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      Text(
                        content,
                        style: knormallight,
                        textAlign: TextAlign.center,
                      ),
                      ButtonBar(
                        buttonMinWidth: 100,
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            child: Text(negativeBtnText, style: knormal),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(
                              positiveBtnText,
                              style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            onPressed: positiveBtnPressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // CircleAvatar(
          //   // Top Circle with icon
          //   maxRadius: 40.0,
          //   child: Icon(Icons.delete),
          // ),
        ],
      ),
    );
  }
}
