import 'package:flutter/material.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:attendace/services/Course_detals.dart';
import 'package:attendace/services/functions.dart';

class AddingCourse extends StatefulWidget {
  const AddingCourse({Key? key}) : super(key: key);

  @override
  State<AddingCourse> createState() => _AddingCourseState();
}

class _AddingCourseState extends State<AddingCourse> {

  var _myFormKey = GlobalKey<FormState>();
  bool isTimeCorrect = true;

  String Day_of_new_class = day.first;
  TimeOfDay Starting_time_of_new_class = TimeOfDay(hour: 10, minute: 00);
  TimeOfDay Ending_time_of_new_class = TimeOfDay(hour: 11, minute: 00);

   String Course_code_of_new_class = 'abc';
   String Course_name_of_new_class = 'abc';

  List<Timings> new_course_timings = [];

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Fill Course Details'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0,vertical: 1.0),
        child: Form(
          key: _myFormKey,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              TextFormField(
                validator: (Course_code)
                {
                  if( Course_code == null ||Course_code.isEmpty)
                    return 'Please Enter the Course Code';

                  Course_code_of_new_class = Course_code;
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Course Code:',
                ),
              ),
              TextFormField(
                validator: (Course_name)
                {
                  if( Course_name == null ||Course_name.isEmpty)
                    return 'Please Enter the Course Name';

                  Course_name_of_new_class = Course_name;
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Course Name:',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('Class Timings: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: new_course_timings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton(
                            value: new_course_timings[index].Day,
                            onChanged: ( String? value) {
                              // listOfCourses[data.current_index].Time_course[index].Day = value!;
                              setState(() {
                                // print(listOfCourses);
                                new_course_timings[index].Day = value!;
                              });
                            },
                            items: day.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextButton(
                            child: Text('${new_course_timings[index].Starting_Time.hour}:${new_course_timings[index].Starting_Time.minute}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () async{
                              TimeOfDay? newTime = await  showTimePicker(context: context, initialTime: TimeOfDay(hour: new_course_timings[index].Starting_Time.hour, minute: new_course_timings[index].Starting_Time.minute));

                              if(newTime == null) return;
                              setState(() {
                                TimeofDay new_time = TimeofDay(hour: newTime.hour, minute: newTime.minute);
                                new_course_timings[index].Starting_Time = new_time;
                              });
                            },
                          ),

                          TextButton(
                            child: Text('${new_course_timings[index].Ending_Time.hour}:${new_course_timings[index].Ending_Time.minute}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () async{
                              TimeOfDay? newTime = await  showTimePicker(context: context, initialTime: TimeOfDay(hour: new_course_timings[index].Ending_Time.hour, minute: new_course_timings[index].Ending_Time.minute));
                              // print(listOfCourses[data.current_index].Time_course[index].Ending_Time);
                              if(newTime == null) return;
                              setState(() {
                                TimeofDay new_time = TimeofDay(hour: newTime.hour, minute: newTime.minute);
                                new_course_timings[index].Starting_Time = new_time;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              setState(() {
                                new_course_timings.remove(new_course_timings[index]);
                              });
                              // print(listOfCourses[data.current_index].Time_course.length);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

                  TextButton(
                  child: Text('Add Class',
                  style:  TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                 ),
                  ),
                  onPressed: () async {
                    Timings New_class_Timings = await showDialog(context: context,
                    builder: (BuildContext context) {
                      // var height = MediaQuery.of(context).size.height;
                      // var width = MediaQuery.of(context).size.width;
                      return StatefulBuilder(builder: (context, setState)
                      {
                        return AlertDialog(
                            title: const Text('Enter the Class Timing Details:'),
                            content: Container(
                              height: 250,
                              width: 250,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('Day:'),
                                      DropdownButton(
                                        value: Day_of_new_class,
                                        onChanged: (String? value) {
                                          // listOfCourses[data.current_index].Time_course[index].Day = value!;
                                          setState(() {
                                            // print(listOfCourses);
                                            Day_of_new_class = value!;
                                          });
                                        },
                                        items: day.map<DropdownMenuItem<String>>((
                                            String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      const Text('Starting Time of the Class:'),
                                      TextButton(
                                        child: Text('${Starting_time_of_new_class
                                            .hour}:${Starting_time_of_new_class
                                            .minute}',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          TimeOfDay? newTime = await showTimePicker(
                                              context: context,
                                              initialTime: Starting_time_of_new_class);

                                          if (newTime == null) return;
                                          setState(() {
                                            Starting_time_of_new_class = newTime;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('Ending Time of the Class:'),
                                      TextButton(
                                        child: Text('${Ending_time_of_new_class
                                            .hour%12}:${Ending_time_of_new_class
                                            .minute}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          TimeOfDay? newTime = await showTimePicker(
                                              context: context,
                                              initialTime: Ending_time_of_new_class);

                                          if (newTime == null) return;
                                          setState(() {
                                            Ending_time_of_new_class = newTime;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  isTimeCorrect ? SizedBox(height: 10.0) : Text('Ending time must be after the Starting time',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.red
                                  ),
                                  ),
                                  TextButton(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      if(isAfterTime(Ending_time_of_new_class,Starting_time_of_new_class )) {
                                        Timings New_class_time = Timings(
                                            Day: Day_of_new_class,
                                            Starting_Time: TimeofDay(
                                                hour: Starting_time_of_new_class.hour,
                                                minute: Starting_time_of_new_class.minute),
                                            Ending_Time: TimeofDay(
                                                hour: Ending_time_of_new_class.hour,
                                                minute: Ending_time_of_new_class.minute));
                                        // new_course_timings.add(New_class_time);
                                        // print(New_class_time.Day);
                                        Navigator.pop(context, New_class_time);
                                      }
                                      else{
                                        setState()
                                            {
                                              isTimeCorrect = false;
                                            }
                                      }
                                    },
                                  )
                                ],
                              ),
                            )
                        );
                      }
                      );
                    }
                    );
                    setState(() {
                        new_course_timings.add(New_class_Timings);
                    });
                   }
                    ),
              const SizedBox(height: 40.0),
              TextButton(
                child: const Text('Add the Course'),
                onPressed: () {

                  if(_myFormKey.currentState!.validate()) {
                         Map newCourse = {'Course_code': Course_code_of_new_class,
                        'Course_Name': Course_name_of_new_class,
                        'Time_course': new_course_timings,
                        'Total_Classes': 46,
                        'Classes_present_in': 0,
                        'Classes_yet': 0};

                         Navigator.pop(context, newCourse);
                  }
                },
              )
     ]
          ),
        )
    ),
    ),



    );
}
  }


const List<String> day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
