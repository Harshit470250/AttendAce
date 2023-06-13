import 'dart:io';
// import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:attendace/services/Course_detals.dart';
import 'package:attendace/services/functions.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:attendace/main.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../Pages/home.dart';

location classes_location = location(latitude: 29.864724653518113, longitude: 77.89394727853104,address: 'LHC');

int index_of_class_happen = -1;

String Weekday_day (int num)
{
  if(num == 0) return 'Monday';
  if(num == 1) return 'Tuesday';
  if(num == 2) return 'Wednesday';
  if(num == 3) return 'Thursday';
  if(num == 4) return 'Friday';
  if(num == 5) return 'Saturday';
  if(num == 6) {return 'Sunday';}
  else return '';
}


List<String> course_code(List<String> invoiceNumber)
{
  List<String> SubjectCode = [];
  int i = 0;
  if(invoiceNumber.isEmpty)
    {
      return SubjectCode;
    }
  while(invoiceNumber[i] != 'Subject' && invoiceNumber[i + 2] != 'Code' && i <= invoiceNumber.length - 2) { i++; }
  i += 3;
  for(int j = i; j < invoiceNumber.length; j++)
  {
    if(invoiceNumber[j] == ';') { continue; }
    else
    {
      String word = '';
      while(invoiceNumber[j] != ';' && j < invoiceNumber.length) {
        word += invoiceNumber[j];
        j++;
      }
      SubjectCode.add(word);
    }
  }

  return SubjectCode;
}

List<String> course_name(List<String> invoiceNumber)
{
  List<String> SubjectName = [];
  int i = 0;
  while(invoiceNumber[i] != 'Subject' && invoiceNumber[i + 2] != 'Title' && i <= invoiceNumber.length - 2) { i++; }
  i += 3;
  for(int j = i; j < invoiceNumber.length; j++)
  {
    if(invoiceNumber[j] == ';') { continue; }
    else
    {
      String word = '';
      while(invoiceNumber[j] != ';' && j < invoiceNumber.length) {
        word += invoiceNumber[j];
        j++;
      }
      SubjectName.add(word);
    }
  }

  return SubjectName;
}

Future<void> generateTimeTable() async
{

  PdfTextExtractor extractor = PdfTextExtractor(pickedFilePdf!);

    List<TextLine> result = extractor.extractTextLines(startPageIndex: 0);

    Rect textBoundsForCode = const Rect.fromLTWH(00, 370, 100, 1000);
    Rect textBoundsForName = const Rect.fromLTWH(100, 370, 150, 1000);

    List<String> invoiceNumberCode = [];
    List<String> invoiceNumberName = [];

    for (int i = 0; i < result.length; i++) {
      List<TextWord> wordCollectionCode = result[i].wordCollection;
      for (int j = 0; j < wordCollectionCode.length; j++) {
        if (textBoundsForCode.overlaps(wordCollectionCode[j].bounds)) {
          invoiceNumberCode.add(wordCollectionCode[j].text);
        }
      }
      invoiceNumberCode.add(';');
    }
    for (int i = 0; i < result.length; i++) {
      List<TextWord> wordCollection = result[i].wordCollection;
      for (int j = 0; j < wordCollection.length; j++) {
        if (textBoundsForName.overlaps(wordCollection[j].bounds)) {
          invoiceNumberName.add(wordCollection[j].text);
        }
      }
      invoiceNumberName.add(';');
    }

    List<String> CourseCode = course_code(invoiceNumberCode);
    List<String> CourseName = course_name(invoiceNumberName);

    for (int i = 0; i < CourseCode.length; i++) {
      Course addCourse = Course(
          Course_code: CourseCode[i],
          Course_Name: CourseName[i],
          Time_course: [],
          Total_Classes: 0,
          Classes_present_in: 0,
          Classes_yet: 0);
      List_of_readed_data.add(addCourse);
    }

    for (int i = 0; i < result.length; i++) {
      List<TextWord> wordCollection = result[i].wordCollection;
      List<String> lectureInstance = [];
      for (int j = 0; j < wordCollection.length; j++) {
        if (wordCollection[j].bounds.left < 130 ||
            wordCollection[j].bounds.top < 100 ||
            wordCollection[j].bounds.right > 730 ||
            wordCollection[j].bounds.bottom > 215) {
          continue;
        } else {
          lectureInstance.add(wordCollection[j].text);
        }
      }
      if (lectureInstance.isEmpty) {
        continue;
      } else {
        int indexOfCourse = indexOfLectureInstance(lectureInstance, CourseCode);
        if (indexOfCourse == -1) {
          continue;
        } else {
          Timings classTimings = Timings(
              Day: Weekday_day(((wordCollection[wordCollection.length - 1]
                              .bounds
                              .right -
                          130) /
                      120)
                  .floor()),
              Starting_Time: TimeofDay(
                  hour: 8 +
                      ((wordCollection[wordCollection.length - 1]
                                      .bounds
                                      .bottom -
                                  100) /
                              23)
                          .floor(),
                  minute: 00),
              Ending_Time: TimeofDay(
                  hour: 9 +
                      ((wordCollection[wordCollection.length - 1]
                                      .bounds
                                      .bottom -
                                  100) /
                              23)
                          .floor(),
                  minute: 00));

          List_of_readed_data[indexOfCourse].Time_course.add(classTimings);
        }
      }
    }
    for (int i = 0; i < List_of_readed_data.length; i++) {
      List_of_readed_data[i].Total_Classes = total_number_of_classes(box.get(StartingDate), box.get(EndingDate), List_of_readed_data[i].Time_course);
      box.put(6 + i, List_of_readed_data[i]);
    }

    box.put(NumberOfCourses, List_of_readed_data.length);
    // final number_of_course = FirebaseFirestore.instance.collection('asdf').doc('my-id');
    // final json = {
    //   'numCourse': List_of_readed_data.length
    // };
    // await number_of_course.set(json);
}


int indexOfLectureInstance(List<String> lectureInstance, List<String> CourseCode)
{
  int index = -1;
  print(lectureInstance);
  if(lectureInstance.length < 5){
    return -1;
  }

  String CourseCodeFind = lectureInstance[2] + lectureInstance[3] + lectureInstance[4];

  for(int i = 0; i < CourseCode.length; i++)
    {
      if(CourseCode[i] == CourseCodeFind){
        return i;
      }
    }

  return index;
}

