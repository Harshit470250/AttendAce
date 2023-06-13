import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attendace/services/Course_detals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:attendace/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

bool is_after (String Date1, String Date2)
{
  if(int.parse(Date1.substring(0,4)) < int.parse(Date2.substring(0,4))) return false;
  else if(int.parse(Date1.substring(0,4)) > int.parse(Date2.substring(0,4))) return true;

  else {
    if (int.parse(Date1.substring(5,7)) < int.parse(Date2.substring(5,7))) return false;
    else if(int.parse(Date1.substring(5,7)) > int.parse(Date2.substring(5,7))) return true;

    else{
      if(int.parse(Date1.substring(8,10)) <= int.parse(Date2.substring(8,10))) return false;
      else {
        return true;
      }
    }
  }
}

int total_number_of_classes (String startingDate, String endingDate, List<Timings> courseTimings)
{

  DateTime starting_Date = DateTime(int.parse(startingDate.substring(0,4)),int.parse(startingDate.substring(5,7)),int.parse(startingDate.substring(8,10)));
  DateTime ending_Date = DateTime(int.parse(endingDate.substring(0,4)),int.parse(endingDate.substring(5,7)),int.parse(endingDate.substring(8,10)));
  double ans = 0;

  int totalDays = ending_Date.difference(starting_Date).inDays + 1;
  if(totalDays > 14) {
    ans = ((totalDays - (7 - starting_Date.weekday + 1) - (ending_Date.weekday)) / 7)* courseTimings.length;
  }

// If number of days is greater than 14
  for(var i = 0; i < courseTimings.length; i++)
  {
    if(Weekday_num(courseTimings[i].Day) >= starting_Date.weekday)
    {
      ans = ans + 1;
    }
    if(Weekday_num(courseTimings[i].Day) <= ending_Date.weekday)
    {
      ans = ans + 1;
    }
  }

  return ans.floor();
}

int Weekday_num (String Day)
{
  if(Day == 'Monday') return 1;
  if(Day == 'Tuesday') return 2;
  if(Day == 'Wednesday') return 3;
  if(Day == 'Thursday') return 4;
  if(Day == 'Friday') return 5;
  if(Day == 'Saturday') return 6;
  if(Day == 'Sunday') {return 7;}
  else {
    return 0;
  }
}

bool isAfterTime(TimeOfDay endingTime, TimeOfDay startingTime)
{
  if(endingTime.hour > startingTime.hour) {
    return true;
  }
  else{
    if(endingTime.minute > startingTime.minute){
      return true;
    }
    else{
      return false;
    }
  }
}

// void startingSemester() async
// {
//   int oneShot = 1;
//   int cancel = 3;
//   DateTime current_time = DateTime.now();
//
//   if(current_time.isAfter(DateTime(
//     int.parse(box.get(StartingDate).substring(0, 4)),
//     int.parse(box.get(StartingDate).substring(5, 7)),
//     int.parse(box.get(StartingDate).substring(8, 10)),
//   ))){
//     Start_semester();
//   }
//   else {
//     print(box.get(StartingDate));
//     await AndroidAlarmManager.oneShotAt(
//         DateTime(
//             int.parse(box.get(StartingDate).substring(0, 4)),
//             int.parse(box.get(StartingDate).substring(5, 7)),
//             int.parse(box.get(StartingDate).substring(8, 10)),
//             0,
//             0),
//         oneShot,
//         Start_semester);
//   }
//   await AndroidAlarmManager.oneShotAt(
//       DateTime(
//           int.parse(box.get(EndingDate).substring(0, 4)),
//           int.parse(box.get(EndingDate).substring(5, 7)),
//           int.parse(box.get(EndingDate).substring(8, 10)),
//           0,
//           01),
//       cancel, () {
//     AndroidAlarmManager.cancel(cancel);
//   });
// }


// void Start_semester()
// {
//   int periodic = 2;
//   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//     if (!isAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   });
//   AwesomeNotifications().createNotification(
//       content: NotificationContent(id: 10,
//       channelKey: 'basic channel',
//       title: 'Semester Started',
//       )
//   );
//   print('semester started');
//   AndroidAlarmManager.periodic(Duration(hour: 1), periodic, isAnyCurrentClass);
//
// }
//
// void isAnyCurrentClass() async
// {
//   box = await Hive.openBox('Course_list');
//   final _box = Hive.box('Course_list');
//   print('checking for class');
//   DateTime now = DateTime.now();
//   for(int i = 0; i < box.get(NumberOfCourses); i++)
//     {
//       for(int j = 0; j < box.get(6 + i).Time_course.length; j++)
//         {
//           if(Weekday_num(box.get(6 + i).Time_course[j].Day) == now.weekday &&
//               box.get(6 + i).Time_course[j].Starting_Time.hour <= now.hour &&
//               box.get(6 + i).Time_course[j].Ending_Time.hour >= now.hour
//   )
//             {
//               box.delete(IndexOfClassHappening);
//               box.put(IndexOfClassHappening, i);
//               tracking_user();
//             }
//         }
//     }
// }
//
// void tracking_user() async
// {
//   Course changedCourse = box.get(6 + box.get(IndexOfClassHappening));
//   changedCourse.Classes_yet++;
//   box.put(6 + box.get(IndexOfClassHappening), changedCourse);
//
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if(!serviceEnabled)
//   {
//     return Future.error('Location services are disabled');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if(permission == LocationPermission.denied)
//   {
//     permission = await Geolocator.requestPermission();
//   }
//
//   Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   print(currentPosition.latitude);
//   print(currentPosition.longitude);
//   if(currentPosition.latitude != box.get(ClassLocation).latitude || currentPosition.longitude != box.get(ClassLocation).longitude)
//   {
//      print('send notification');
//      notificationForClass();
//   }
//
//   int oneShot = 1;
//
//   await AndroidAlarmManager.oneShot(const Duration(minutes: 45), oneShot, class_attended);
// }
//
// void class_attended() async
// {
//   Position currentPosition = await Geolocator.getCurrentPosition();
//   if(currentPosition.latitude == box.get(ClassLocation).latitude && currentPosition.longitude == box.get(ClassLocation).longitude) {
//     Course changedCourse = box.get(6 + box.get(IndexOfClassHappening));
//     changedCourse.Classes_present_in++;
//     box.put(6 + box.get(IndexOfClassHappening), changedCourse);
//     notificationForPresent();
//     print(box.get(6 + box.get(IndexOfClassHappening)).Classes_present_in);
//   }
//   else
//     {
//       print('Class not attended');
//       notificationForAbsent();
//     }
//   box.put(IndexOfClassHappening, -1);
// }
//
//
// void notificationForClass()
// {
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 10,
//       channelKey: 'basic channel',
//       title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
//       body: '${box.get(6 + box.get(IndexOfClassHappening)).Course_Name} is scheduled now'
//     )
//   );
// }
// void notificationForPresent()
// {
//   AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: 11,
//           channelKey: 'basic channel',
//           title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
//           body: 'You are marked present for ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}'
//       )
//   );
// }
// void notificationForAbsent()
// {
//   AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: 12,
//           channelKey: 'basic channel',
//           title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
//           body: 'You are marked absent for ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}'
//       )
//   );
// }