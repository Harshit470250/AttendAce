import 'package:flutter/material.dart';
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
        title: const Text('Fill Course Details'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
          child: Form(
            key: _myFormKey,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text('Enter the Course Code: ',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  validator: (Course_code)
                  {
                    if( Course_code == null ||Course_code.isEmpty) {
                      return 'Please Enter the Course Code';
                    }

                    Course_code_of_new_class = Course_code;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Course Code:',
                  ),
                ),
                const SizedBox(height: 25.0),
                const Row(
                  children: [
                    Text('Enter the Course Name: ',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  validator: (Course_name)
                  {
                    if( Course_name == null ||Course_name.isEmpty) {
                      return 'Please Enter the Course Name';
                    }

                    Course_name_of_new_class = Course_name;
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Course Name:',
                  ),
                ),
                const SizedBox(height: 20.0),
                const Row(
                  children: [
                    Text('Class Timings: ',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                      ),
                    ),
                  ],
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
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
                            ),
                            TextButton(
                              child: new_course_timings[index].Starting_Time.minute > 10 ?
                              Text('${new_course_timings[index].Starting_Time.hour}:${new_course_timings[index].Starting_Time.minute}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ):Text('${new_course_timings[index].Starting_Time.hour}:0${new_course_timings[index].Starting_Time.minute}',
                                style: const TextStyle(
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
                              child: new_course_timings[index].Ending_Time.minute > 10?
                              Text('${new_course_timings[index].Ending_Time.hour}:${new_course_timings[index].Ending_Time.minute}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ):
                              Text('${new_course_timings[index].Ending_Time.hour}:0${new_course_timings[index].Ending_Time.minute}',
                                style: const TextStyle(
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
                              icon: const Icon(Icons.cancel_outlined),
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

                    ElevatedButton(
                    child: const Text('Add Class',
                    style:  TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                   ),
                    ),
                    onPressed: () async {
                      Timings New_class_Timings = await showDialog(context: context,
                      builder: (BuildContext context) {
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
                                        const Text('Day:'),
                                        DropdownButton(
                                          value: Day_of_new_class,
                                          onChanged: (String? value) {
                                            setState(() {
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
                                          child: Starting_time_of_new_class.minute > 10 ?
                                          Text('${Starting_time_of_new_class
                                              .hour}:${Starting_time_of_new_class
                                              .minute}',
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ):Text('${Starting_time_of_new_class
                                              .hour}:0${Starting_time_of_new_class
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
                                        const Text('Ending Time of the Class:'),
                                        TextButton(
                                          child: Ending_time_of_new_class.minute > 10 ?
                                          Text('${Ending_time_of_new_class
                                              .hour%12}:${Ending_time_of_new_class
                                              .minute}',
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ): Text('${Ending_time_of_new_class
                                              .hour%12}:0${Ending_time_of_new_class
                                              .minute}',
                                            style: const TextStyle(
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
                                    isTimeCorrect ? const SizedBox(height: 10.0) : const Text('Ending time must be after the Starting time',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.red
                                    ),
                                    ),
                                    ElevatedButton(
                                      child: const Text('Submit'),
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
                const SizedBox(height: 350.0),
                ElevatedButton(
                  child: const Text('Add the Course',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  ),
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
      ),



    );
}
  }


const List<String> day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
