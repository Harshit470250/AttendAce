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

  Future<void> filePicker() async{

    result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'],
        type: FileType.custom,
        allowMultiple: false
    );

    pickedFile = result!.files.first.path;
    pickedFilePdf =
        PdfDocument(inputBytes: File(pickedFile!).readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    return box.get(StartingDate) != null ?
      Scaffold(
      appBar: AppBar(
        title: const Text('Courses',
           style: TextStyle(
             fontSize: 25.0,
           ),
        ),
        actions: [
           IconButton(
             icon: const Icon(
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
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(box.get(ClassLocation).address,
                    style: const TextStyle(
                      color: Colors.black54
                    ),
                    ),
                  ],
                ),
              ),
            ),
            box.get(6) != null ?
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: box.get(NumberOfCourses),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 1.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/course', arguments: index_value(index),
                        );
                      },
                      title: Text('${box.get(index + 6).Course_code}: ${box.get(index + 6).Course_Name}'),
                        subtitle: Text('Classes Attended: ${box.get(index + 6).Classes_present_in}'),
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('lib/Pages/Assets/Course_logo.jpg'),
                      )
                    ),
                  ),
                );
              },
            ) : const Center(
              child: Text('Add the Courses',
               style: TextStyle(
                 fontSize: 15.0,
                 color: Colors.black45
               ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          dynamic new_course = await Navigator.pushNamed(context,'/Adding_Course');
          print(new_course['Course_Name']);
          Course new_Course = Course(
            Course_Name: new_course['Course_Name'],
            Course_code: new_course['Course_code'],
            Time_course: new_course['Time_course'],
            Total_Classes: total_number_of_classes(box.get(StartingDate),box.get(EndingDate),new_course['Time_course']),
            Classes_yet: new_course['Classes_yet'],
            Classes_present_in: new_course['Classes_present_in']
          );
          setState(() {
                new_Course.Total_Classes = total_number_of_classes(box.get(StartingDate), box.get(EndingDate), new_Course.Time_course);
                if(box.get(NumberOfCourses) == null){
                  box.put(NumberOfCourses, 0);
                }
                int no_of_courses = box.get(NumberOfCourses) + 1;
                box.put(NumberOfCourses, no_of_courses);
                box.put(5 + box.get(NumberOfCourses),new_Course);
          });
        },
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: const Text('Setting Up'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _myFormKey,
            child: Center(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('Enter the Starting Date of the Semester: ',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54
                        ),
                      ),
                    ],
                  ),

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
                  const SizedBox(height: 25.0),
                  const Row(
                    children: [
                      Text('Enter the Ending Date of the Semester: ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
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
                  const SizedBox(height: 25.0),

                  isLoading? CircularProgressIndicator():ElevatedButton(
                      onPressed: () async{
                        await filePicker();
                        // await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                        //   if (!isAllowed) {
                        //     AwesomeNotifications().requestPermissionToSendNotifications();
                        //   }
                        // });
                      },
                      child: const Text('Pick the Timetable')),
                  const SizedBox(height: 390.0),
                  ButtonTheme(
                    minWidth: 300.0,
                    child: ElevatedButton(
                        child: const Text('Proceed'),
                        onPressed: () async {
                          if (_myFormKey.currentState!.validate()) {
                            box.put(firstTime, false);
                            box.put(StartingDate, startingDateOfSemester);
                            box.put(EndingDate, endingDateOfSemester);
                            if (pickedFilePdf != null) {
                              await generateTimeTable();
                            }
                            // startingSemester();
                            setState(() {});
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  }

