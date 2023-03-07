// ignore_for_file: unused_import

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_2023/key.dart';
import 'package:moviesapp_2023/screens/cast.dart';
import 'package:moviesapp_2023/utils/style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;
  final int movieid;

  const Description(this.name, this.description, this.bannerurl, this.posterurl,
      this.vote, this.launch_on, this.movieid);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 233, 233),
        body: SlidingUpPanel(
          backdropEnabled: true,
          color: Colors.transparent,
          minHeight: (size.height / 1.8),
          maxHeight: (size.height / 1.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                        // color: Color.fromARGB(255, 24, 24, 24),
                        height: MediaQuery.of(context).size.height * 0.7,

                        width: MediaQuery.of(context).size.width * 1.0,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fitWidth,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(1),
                                    BlendMode.dstATop),
                                image: NetworkImage(posterurl))),
                        // child: Image.asset(
                        //   posterurl,
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                    )),
                Positioned(
                  top: 50,
                  left: 20,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          panel: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(107, 255, 244, 244),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              name != null ? name : "loading",
                              style: kbig,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 22, 22, 22),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: mvd1(vote, CupertinoIcons.star_fill),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: mvd(launch_on),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // Expanded(
                        //   child: Container(
                        //       // color: Colors.amber,

                        //       ),
                        // )
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Storyline",
                              style: kbigsmall,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Center(
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(120, 22, 22, 22),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.4,
                            child: Text(description, style: knormal),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Cast",
                              style: kbigsmall,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Center(
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(120, 22, 22, 22),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Actors(movieid)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Container mvd(String name) {
    // mvd(this.name);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Text(
          'Date : $name',
          style: knormallight,
        ),
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 83, 83, 83).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Container mvd1(String name, IconData icon) {
    // mvd(this.name);
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 83, 83, 83).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color.fromARGB(255, 255, 191, 0),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: knormallight,
            ),
          ],
        ),
      ),
    );
  }
}
