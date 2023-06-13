import 'package:attendace/services/Course_detals.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:attendace/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:attendace/Pages/course.dart';
import 'package:attendace/Pages/home.dart';
import 'package:attendace/Pages/Adding_Course.dart';
import 'package:attendace/Pages/location_picker.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:attendace/Pages/initial_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:attendace/Pages/loading_home.dart';
import 'package:firebase_core/firebase_core.dart';

late Box box;
int StartingDate = 1, EndingDate = 2, ClassLocation = 3, IndexOfClassHappening = 4, NumberOfCourses = 5;
int firstTime = 0;
List<Course> List_of_readed_data = [];

Future main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

    // WidgetsFlutterBinding.ensureInitialized();
    // await AndroidAlarmManager.initialize();
    //
    // AwesomeNotifications().initialize(
    //     null,
    //     [
    //       NotificationChannel(
    //           channelKey: 'basic channel',
    //           channelName: 'Class Notification',
    //           channelDescription: 'Notification for Attendace')
    //     ],
    //     debug: true);
    //
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });

    // LocationPermission permission = await Geolocator.requestPermission();
    // PermissionStatus backgroundLocation = await Permission.locationAlways.request();
    // PermissionStatus storage = await Permission.storage.request();

    await Hive.initFlutter();
    Hive.registerAdapter(CourseAdapter());
    Hive.registerAdapter(locationAdapter());
    Hive.registerAdapter(TimingsAdapter());
    Hive.registerAdapter(TimeofDayAdapter());
    box = await Hive.openBox('Course_list');

    box.put(ClassLocation, classes_location);
    box.put(IndexOfClassHappening, index_of_class_happen);
    // box_path = box.path!;
    // box.put(firstTime, true);

    runApp(MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/course': (context) => course(),
        '/Adding_Course': (context) => AddingCourse(),
        '/location_picker': (context) => LocationPicker(),
      },
    ));
}


