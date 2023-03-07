import 'dart:core';

import 'package:hive/hive.dart';

part 'moviemodel.g.dart';

@HiveType(typeId: 0)
class Add extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? overview;
  @HiveField(2)
  String? backdrop;
  @HiveField(3)
  String? poster;
  @HiveField(4)
  String? rating;
  @HiveField(5)
  String? releasedate;
  @HiveField(6)
  String? id;
  

Add({
    this.title,
    this.overview,
    this.backdrop,
    this.poster,
    this.rating,
    this.releasedate,
    this.id,
    
  });

}
