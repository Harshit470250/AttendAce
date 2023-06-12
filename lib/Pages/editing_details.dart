import 'package:flutter/material.dart';
import 'package:attendace/services/passing_argument.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:day_picker/day_picker.dart';

class EditingDetails extends StatefulWidget {
  const EditingDetails({Key? key}) : super(key: key);

  @override
  State<EditingDetails> createState() => _EditingDetailsState();
}

class _EditingDetailsState extends State<EditingDetails> {

  @override
  Widget build(BuildContext context) {

    index_value data = ModalRoute.of(context)!.settings.arguments as index_value;

    return Scaffold(
      appBar: AppBar(),
      // body: ListView.builder(
      //   itemCount: listOfCourses[data.current_index].Time_course.length,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2.0),
      //       child: Card(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //           DropdownButton(
      //           value: listOfCourses[data.current_index].Time_course[index].Day,
      //           onChanged: ( String? value) {
      //             // listOfCourses[data.current_index].Time_course[index].Day = value!;
      //             setState(() {
      //               // print(listOfCourses);
      //               listOfCourses[data.current_index].Time_course[index].Day = value!;
      //             });
      //           },
      //           items: day.map<DropdownMenuItem<String>>((String value) {
      //             return DropdownMenuItem<String>(
      //               value: value,
      //               child: Text(value),
      //             );
      //           }).toList(),
      //         ),
      //             TextButton(
      //               child: Text('${listOfCourses[data.current_index].Time_course[index].Starting_Time.hour}:${listOfCourses[data.current_index].Time_course[index].Starting_Time.minute}',
      //                 style: TextStyle(
      //                   fontSize: 20.0,
      //                 ),
      //               ),
      //               onPressed: () async{
      //                   TimeOfDay? newTime = await  showTimePicker(context: context, initialTime: listOfCourses[data.current_index].Time_course[index].Starting_Time);
      //
      //                   if(newTime == null) return;
      //                   setState(() {
      //                     listOfCourses[data.current_index].Time_course[index].Starting_Time = newTime;
      //                   });
      //               },
      //             ),
      //
      //             TextButton(
      //               child: Text('${listOfCourses[data.current_index].Time_course[index].Ending_Time.hour}:${listOfCourses[data.current_index].Time_course[index].Ending_Time.minute}',
      //                 style: TextStyle(
      //                   fontSize: 20.0,
      //                 ),
      //               ),
      //               onPressed: () async{
      //                 TimeOfDay? newTime = await  showTimePicker(context: context, initialTime: listOfCourses[data.current_index].Time_course[index].Ending_Time);
      //                 // print(listOfCourses[data.current_index].Time_course[index].Ending_Time);
      //                 if(newTime == null) return;
      //                 setState(() {
      //                   listOfCourses[data.current_index].Time_course[index].Ending_Time = newTime;
      //
      //                 });
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}

const List<String> day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];





