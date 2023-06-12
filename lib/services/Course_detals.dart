import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'Course_detals.g.dart';

@HiveType(typeId: 1)
class Course {
  @HiveField(0)
  String Course_code;

  @HiveField(1)
  String Course_Name;

  @HiveField(2)
  List<Timings> Time_course;

  @HiveField(3)
  int Total_Classes;

  @HiveField(4)
  int Classes_present_in;

  @HiveField(5)
  int Classes_yet;

  Course({required this.Course_code, required this.Course_Name, required this.Time_course,
    required this.Total_Classes,required this.Classes_present_in, required this.Classes_yet });

}


@HiveType(typeId: 2)
class location {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  String address;

  location({required this.latitude, required this.longitude,required this.address});
}

@HiveType(typeId: 3)
class Timings {
  @HiveField(0)
  String Day;

  @HiveField(1)
  TimeofDay Starting_Time;

  @HiveField(2)
  TimeofDay Ending_Time;

  Timings({required this.Day, required this.Starting_Time, required this.Ending_Time});
}

@HiveType(typeId: 4)
class TimeofDay {
  @HiveField(0)
  int hour;

  @HiveField(1)
  int minute;

  TimeofDay({required this.hour, required this.minute});
}