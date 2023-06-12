import 'dart:io';
import 'package:flutter/material.dart';
import 'package:attendace/services/passing_argument.dart';
import 'package:attendace/services/Course_detals.dart';
import 'package:attendace/services/functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:attendace/main.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

String? pickedFile;
PdfDocument? pickedFilePdf;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  FilePickerResult? result;
  var _myFormKey = GlobalKey<FormState>();
  String startingDateOfSemester = '2023-04-12', endingDateOfSemester = '2023-06-12';

  void anything()
  {
    print('something');
  }

  void filePicker() async{
    // setState() ({
    //   isLoading = true;
    // })

    result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'],
        type: FileType.custom,
        allowMultiple: false
    );

    if(result == null)
    {
      print('abc');
    }
    pickedFile = result!.files.first.path;
    // pickedFilePdf = File(pickedFile!) as PdfDocument;
    pickedFilePdf =
        PdfDocument(inputBytes: File(pickedFile!).readAsBytesSync());
    print(result!.files.first.path);
  }

  @override
  Widget build(BuildContext context) {
    return box.get(6) != null ?
      Scaffold(
      appBar: AppBar(
        title: const Text('Courses',
           style: TextStyle(
             fontSize: 25.0,
           ),
        ),
        actions: [
           IconButton(
             icon: Icon(
                 Icons.location_on,
                 color: Colors.white,
             ),
             onPressed: () async{
               bool serviceEnabled;
               LocationPermission permission;

               serviceEnabled = await Geolocator.isLocationServiceEnabled();
               if(!serviceEnabled)
                 {
                   return Future.error('Location services are disabled');
                 }

                 permission = await Geolocator.checkPermission();
               if(permission != LocationPermission.always)
                 {
                   permission = await Geolocator.requestPermission();
                 }
                 dynamic new_class_location = await Navigator.pushNamed(context, '/location_picker');
                 setState(() {
                   box.delete(ClassLocation);
                   location new_location = location(latitude: new_class_location['Latitude'], longitude: new_class_location['Longitude'], address: new_class_location['address']);
                   box.put(ClassLocation, new_location);
                 });
             },
           )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Row(
                children: [
                  Text(box.get(ClassLocation).address),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: box.get(NumberOfCourses),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 1.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/course', arguments: index_value(index),
                        );
                      },
                      title: Text('${box.get(index + 6).Course_code}: ${box.get(index + 6).Course_Name}'),
                      //   title:  Text('${box.get(index + 6).Course_Name}'),
                        subtitle: Text('Classes Attended: ${box.get(index + 6).Classes_present_in}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('lib/Pages/Assets/Course_logo.jpg'),
                      )
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          dynamic new_course = await Navigator.pushNamed(context,'/Adding_Course');
          print(new_course['Course_Name']);
          // print(new_course['Starting_date']);
          // print(new_course['Ending_date']);
          Course new_Course = Course(
            Course_Name: new_course['Course_Name'],
            Course_code: new_course['Course_code'],
            Time_course: new_course['Time_course'],
            Total_Classes: total_number_of_classes(box.get(StartingDate),box.get(EndingDate),new_course['Time_course']),
            Classes_yet: new_course['Classes_yet'],
            Classes_present_in: new_course['Classes_present_in']
          );
          setState(() {
            // if(!new_course.isNull)
            //   {
                new_Course.Total_Classes = total_number_of_classes(box.get(StartingDate), box.get(EndingDate), new_Course.Time_course);
                int no_of_courses = box.get(NumberOfCourses) + 1;
                box.put(NumberOfCourses, no_of_courses);
                box.put(5 + box.get(NumberOfCourses),new_Course);
                // print(box.get(5 + box.get(NumberOfCourses)).Course_Name);
              // }
            // listOfCourses.add(new_Course);
          });
          // print(listOfCourses.length);
        },
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: const Text('Setting Up'),
      ),
      body: Column(
        children: [
          const Text('Enter the Starting Date of the Semester: '),
          TextFormField(
            validator: (startingDate)
            {
              if( startingDate == null || startingDate.isEmpty) {
                return 'Please Enter the Starting Date of the Semester';
              }

              startingDateOfSemester = startingDate;
              return null;
            },
            // keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Starting Date:',
              hintText: 'yyyy-mm-dd',
            ),
          ),
          const Text('Enter the Ending Date of the Semester: '),
          TextFormField(
              validator: (endingDate) {
                if (endingDate == null || endingDate.isEmpty) {
                  return 'Please Enter the Ending Date of the Semester';
                }

                endingDateOfSemester = endingDate;

                if (is_after(endingDateOfSemester, startingDateOfSemester)) {
                  return null;
                } else {
                  return 'Ending Date must be after the Starting Date';
                }
              },
              decoration: const InputDecoration(
                  labelText: 'Ending Date:',
                  hintText: 'yyyy-mm-dd'
              )
          ),

          isLoading? CircularProgressIndicator():TextButton(
              onPressed: () async{
                // anything();
                await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                  if (!isAllowed) {
                    AwesomeNotifications().requestPermissionToSendNotifications();
                  }
                });
                filePicker();

              },
              child: Text('Pick the Timetable')),

          TextButton(
              child: Text('Proceed'),
              onPressed: () async{

                // if(_myFormKey.currentState!.validate()) {
                box.put(StartingDate,startingDateOfSemester);
                box.put(EndingDate, endingDateOfSemester);
                // print('anything');

                await generateTimeTable();
                startingSemester();
                // print('something');
                setState(() {
                });
                // Navigator.pushReplacementNamed(context, '/home');
                // }
              }
          ),

        ],
      ),

    );
  }
  }

