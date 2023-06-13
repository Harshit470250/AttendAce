import 'package:attendace/services/Course_detals.dart';
import 'package:flutter/material.dart';
import 'package:attendace/services/passing_argument.dart';
import 'package:attendace/main.dart';
import 'package:attendace/services/functions.dart';


class course extends StatefulWidget {
  const course({Key? key}) : super(key: key);

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {

  // index_value current_index();

  @override
  Widget build(BuildContext context) {

    index_value data = ModalRoute.of(context)!.settings.arguments as index_value;


    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.blue[800],
       title: Text(box.get(6 + data.current_index).Course_Name),
       actions: [
         IconButton(onPressed: () {
           Navigator.pushReplacementNamed(context,'/');
         }, icon: const Icon(Icons.chevron_left_sharp))
       ],
     ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 0.0),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  const Row(
                    children: [
                      Text('Attendance Details',
                       style: TextStyle(
                         fontSize: 20.0
                       ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total no. of Classes:',
                        style: TextStyle(
                          fontSize: 17.0,
                            color: Colors.black54
                        ),

                      ),
                      Text('${box.get(6 + data.current_index).Total_Classes}',
                      style: const TextStyle(
                        fontSize: 17.0,
                          color: Colors.black54
                      ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text('Total no. of classes happened:',
                  //       style: TextStyle(
                  //           fontSize: 17.0,
                  //           color: Colors.black54
                  //       ),
                  //     ),
                  //     Text('${box.get(6 + data.current_index).Classes_yet}',
                  //     style: const TextStyle(
                  //         fontSize: 17.0,
                  //         color: Colors.black54
                  //     ),
                  //     )
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Classes attended:',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black54
                        ),
                      ),
                      SizedBox(width: 110.0),
                      Text('${box.get(6 + data.current_index).Classes_present_in}',
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black54
                        ),
                      ),
                          IconButton(
                              icon: const Icon(Icons.arrow_upward),
                            onPressed: () {
                                setState(() {
                                  Course updatedCourse = box.get(6 + data.current_index);
                                  updatedCourse.Classes_present_in++;
                                  box.put(6 + data.current_index, updatedCourse);
                                });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_downward),
                            onPressed: () {
                              setState(() {
                                Course updatedCourse = box.get(6 + data.current_index);
                                updatedCourse.Classes_present_in--;
                                box.put(6 + data.current_index, updatedCourse);
                              });
                            },
                      ),
                      // TextButton(
                      //   child: Text('${box.get(6 + data.current_index).Classes_present_in}'),
                      // onPressed: () async{
                      //   int valueDisplayed = box.get(6 + data.current_index).Classes_present_in;
                      //     int newNumberOfClassAttended = await showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return StatefulBuilder(builder: (context, setState) {
                      //           return AlertDialog(
                      //             content: Container(
                      //               height: 150,
                      //               width: 150,
                      //               child: Column(
                      //                 children: [
                      //                   NumberPicker(
                      //                     value: box.get(6 + data.current_index).Classes_present_in,
                      //                     minValue: 0,
                      //                     maxValue: box.get(6 + data.current_index).Total_Classes,
                      //                     step: 1,
                      //                     onChanged: (value) {
                      //                       setState(() {
                      //                         valueDisplayed = value;
                      //                       });
                      //                     },
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         });
                      //       }
                      //     );
                      //     setState(() {
                      //       Course updatedCourse = box.get(6 + data.current_index);
                      //       updatedCourse.Classes_present_in = newNumberOfClassAttended;
                      //       box.put(6 + data.current_index, updatedCourse);
                      //     });
                      //   }
                      // )
                      // Text('${box.get(6 + data.current_index).Classes_present_in}',
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //   ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Percentage of classes attended:',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black54
                        ),
                      ),
                      Text('${(box.get(6 + data.current_index).Classes_present_in/box.get(6 + data.current_index).Total_Classes*100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black54
                        ),
                        ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('% of classes attended(as of yet):',
                  //       style: TextStyle(
                  //         fontSize: 20.0,
                  //       ),
                  //     ),
                  //     Text('${box.get(6 + data.current_index).Classes_present_in/box.get(6 + data.current_index).Classes_yet*100}%',
                  //       style: TextStyle(
                  //         fontSize: 20.0,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20.0),
                  const Row(
                    children: [
                      Text('Class timings:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: box.get(6 + data.current_index).Time_course.length,
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
                            value: box.get(6 + data.current_index).Time_course[index].Day,
                            onChanged: ( dynamic? value) {
                              setState(() {
                                Course change_course = box.get(6 + data.current_index);
                                box.delete(6 + data.current_index);
                                change_course.Time_course[index].Day = value!;
                                box.put(6 + data.current_index, change_course);
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
                          child: box.get(6 + data.current_index).Time_course[index].Starting_Time.minute > 10 ?
                          Text('${box.get(6 + data.current_index).Time_course[index].Starting_Time.hour%12}:${box.get(6 + data.current_index).Time_course[index].Starting_Time.minute}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ):
                          Text('${box.get(6 + data.current_index).Time_course[index].Starting_Time.hour%12}:0${box.get(6 + data.current_index).Time_course[index].Starting_Time.minute}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async{
                            TimeOfDay? newTime = await  showTimePicker(context: context,
                                initialTime: TimeOfDay(hour: box.get(6 + data.current_index).Time_course[index].Starting_Time.hour,
                                    minute: box.get(6 + data.current_index).Time_course[index].Starting_Time.minute));;

                            if(newTime == null) return;
                            setState(() {
                              Course changed_course = box.get(6 + data.current_index);
                              TimeofDay new_time = TimeofDay(hour: newTime.hour, minute: newTime.minute);
                              changed_course.Time_course[index].Starting_Time = new_time;
                              box.put(6 + data.current_index, changed_course);
                              // box.get(listOfCourses)[data.current_index].Time_course[index].Starting_Time = newTime;
                            });
                          },
                        ),

                        TextButton(
                          child: box.get(6 + data.current_index).Time_course[index].Ending_Time.minute > 10 ?
                          Text('${box.get(6 + data.current_index).Time_course[index].Ending_Time.hour%12}:${box.get(6 + data.current_index).Time_course[index].Ending_Time.minute}'
                            ,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ) :
                          Text('${box.get(6 + data.current_index).Time_course[index].Ending_Time.hour%12}:0${box.get(6 + data.current_index).Time_course[index].Ending_Time.minute}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async{
                            TimeOfDay? newTime = await  showTimePicker(context: context,
                                initialTime: TimeOfDay(hour: box.get(6 + data.current_index).Time_course[index].Ending_Time.hour,
                                    minute: box.get(6 + data.current_index).Time_course[index].Ending_Time.minute));
                            if(newTime == null) return;
                            setState(() {
                              Course changed_course = box.get(6 + data.current_index);
                              TimeofDay new_time = TimeofDay(hour: newTime.hour, minute: newTime.minute);
                              changed_course.Time_course[index].Ending_Time = new_time;
                              box.put(6 + data.current_index, changed_course);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel_outlined),
                          onPressed: () {
                            setState(() {
                              Course changed_course = box.get(6 + data.current_index);
                              changed_course.Time_course.removeAt(index);
                              changed_course.Total_Classes = total_number_of_classes(box.get(StartingDate), box.get(EndingDate), changed_course.Time_course);
                              box.put(6 + data.current_index, changed_course);
                            });
                          },
                        )

                      ],
                    ),
                  ),
                );
              },
              ),
            TextButton(
                child: const Text('Add Class',
                  style:  TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async {
                  String Day_of_new_class = day.first;
                  TimeOfDay Starting_time_of_new_class = TimeOfDay(hour: 10, minute: 00);
                  TimeOfDay Ending_time_of_new_class = TimeOfDay(hour: 11, minute: 00);
                  bool isTimeCorrect = true;
                  Timings New_class_Timings = await showDialog(context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState)
                        {
                          return AlertDialog(
                                title: const Text('Enter the Class Timing Details:'),
                                content: Container(
                                  width: 250,
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            child: Starting_time_of_new_class.minute > 10?
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
                                            ):Text('${Ending_time_of_new_class
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
                                      TextButton(
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
                    Course updatedCourse = box.get(6 + data.current_index);
                    updatedCourse.Time_course.add(New_class_Timings);
                    updatedCourse.Total_Classes = total_number_of_classes(box.get(StartingDate ), box.get(EndingDate), updatedCourse.Time_course);
                    box.put(6 + data.current_index,updatedCourse);
                  });
                }
            ),

          ],
        ),
      ),
    );
  }
}
const List<String> day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];





