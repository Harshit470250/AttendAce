import 'package:flutter/material.dart';
import 'package:attendace/services/Course_detals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:attendace/main.dart';
import 'package:attendace/Pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

late List<Course> courseList;
late int nosos;

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

void startingSemester() async
{
  int oneShot = 1;
  int cancel = 3;
  DateTime current_time = DateTime.now();

 nosos = box.get(NumberOfCourses);

  if(current_time.isAfter(DateTime(
    int.parse(box.get(StartingDate).substring(0, 4)),
    int.parse(box.get(StartingDate).substring(5, 7)),
    int.parse(box.get(StartingDate).substring(8, 10)),
  ))){
    print(box.get(StartingDate));
    Start_semester();
  }
  else {
    print(box.get(StartingDate));
    await AndroidAlarmManager.oneShotAt(
        DateTime(
            int.parse(box.get(StartingDate).substring(0, 4)),
            int.parse(box.get(StartingDate).substring(5, 7)),
            int.parse(box.get(StartingDate).substring(8, 10)),
            9,
            37),
        oneShot,
        Start_semester);
  }
  await AndroidAlarmManager.oneShotAt(
      DateTime(
          int.parse(box.get(EndingDate).substring(0, 4)),
          int.parse(box.get(EndingDate).substring(5, 7)),
          int.parse(box.get(EndingDate).substring(8, 10)),
          0,
          01),
      cancel, () {
    AndroidAlarmManager.cancel(cancel);
  });
}

late int numberCourses;

void createCourseList()
{

}

void Start_semester()
{
  print(abds());
  print(asdf());
  print(box.get(6).Course_Name);
  int periodic = 2;
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  AwesomeNotifications().createNotification(
      content: NotificationContent(id: 10,
      channelKey: 'basic channel',
      title: 'Semester Started',
      // body: '${box.get(6 + box.get(IndexOfClassHappening)).Course_Name} is scheduled now'
      )
  );
  // DateTime now = DateTime.now();
  // print(now);
  print('semester started');
  AndroidAlarmManager.periodic(Duration(minutes: 1), periodic, isAnyCurrentClass);

}

int abds(){
  return box.get(NumberOfCourses);
}

String asdf(){
  return box.get(StartingDate);
}

void isAnyCurrentClass() async
{
  // print(nosos);
  // await Hive.initFlutter();
  box = await Hive.openBox('Course_list');
  final _box = Hive.box('Course_list');
  print('checking for class');
  DateTime now = DateTime.now();
  print(now);
  print(_box.get(NumberOfCourses));
  // Course abc = await box.get(8);
  // print(abc.Time_course[1].Starting_Time.hour);
  // print(box.get(NumberOfCourses));
  // int numberOfCourses = abds();
  // print(numberOfCourses);
  for(int i = 0; i < box.get(NumberOfCourses); i++)
    {
      // print('fuck');
      for(int j = 0; j < box.get(6 + i).Time_course.length; j++)
        {
          print(box.get(6 + i).Time_course.Day);
          print(box.get(6 + i).Time_course.Starting_Time.hour);
          if(Weekday_num(box.get(6 + i).Time_course[j].Day) == now.weekday &&
              box.get(6 + i).Time_course[j].Starting_Time.hour <= now.hour &&
              box.get(6 + i).Time_course[j].Ending_Time.hour >= now.hour
  )
            {
              print(box.get(6 + i).Time_course.Day);
              print(box.get(6 + i).Time_course.Starting_Time.hour);
              print(box.get(6 + i).Time_course.Starting_Time.minute);
              print('Class is happening');
              box.delete(IndexOfClassHappening);
              box.put(IndexOfClassHappening, i);
              tracking_user();
            }
        }
    }
}
// Reminder 15 mins before

/* Position current_position = await Geolocator.getCurrentPosition();

isAnyCurrentClass() if yes then Classes_yet++;

if(current_position.latitude != class_location.latitude || current_position.longitude != class_location.longitude)
{
  send notification

}

track position until current position becomes class position or class ends

if class ends skip

if class still going on
Keep tracking position and adding the time
if time spent in the class is more than 30 min class_attended++;

 */

void tracking_user() async
{
  Course changedCourse = box.get(6 + box.get(IndexOfClassHappening));
  changedCourse.Classes_yet++;
  box.put(6 + box.get(IndexOfClassHappening), changedCourse);

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled)
  {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied)
  {
    permission = await Geolocator.requestPermission();
  }

  Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(currentPosition.latitude);
  print(currentPosition.longitude);
  if(currentPosition.latitude != box.get(ClassLocation).latitude || currentPosition.longitude != box.get(ClassLocation).longitude)
  {
     print('send notification');
     notificationForClass();
  }

  int oneShot = 1;

  await AndroidAlarmManager.oneShot(const Duration(minutes: 1), oneShot, class_attended);
}

void class_attended() async
{
  Position currentPosition = await Geolocator.getCurrentPosition();
  if(currentPosition.latitude == box.get(ClassLocation).latitude && currentPosition.longitude == box.get(ClassLocation).longitude) {
    Course changedCourse = box.get(6 + box.get(IndexOfClassHappening));
    changedCourse.Classes_present_in++;
    box.put(6 + box.get(IndexOfClassHappening), changedCourse);
    notificationForPresent();
    print(box.get(6 + box.get(IndexOfClassHappening)).Classes_present_in);
  }
  else
    {
      print('Class not attended');
      notificationForAbsent();
    }
  box.put(IndexOfClassHappening, -1);
}


void notificationForClass()
{
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic channel',
      title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
      body: '${box.get(6 + box.get(IndexOfClassHappening)).Course_Name} is scheduled now'
    )
  );
}
void notificationForPresent()
{
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 11,
          channelKey: 'basic channel',
          title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
          body: 'You are marked present for ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}'
      )
  );
}
void notificationForAbsent()
{
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 12,
          channelKey: 'basic channel',
          title: 'Class of ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}',
          body: 'You are marked absent for ${box.get(6 + box.get(IndexOfClassHappening)).Course_Name}'
      )
  );
}