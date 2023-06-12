import 'dart:io';
import 'package:flutter/material.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:attendace/services/functions.dart';
import 'package:attendace/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

// String? pickedFile;
// PdfDocument? pickedFilePdf;

class TimetableReader extends StatefulWidget {
  const TimetableReader({Key? key}) : super(key: key);

  @override
  State<TimetableReader> createState() => _TimetableReaderState();
}

class _TimetableReaderState extends State<TimetableReader> {
  // bool isLoading = false;
  // FilePickerResult? result;
  // var _myFormKey = GlobalKey<FormState>();
  // String startingDateOfSemester = '2023-04-12', endingDateOfSemester = '2023-06-12';
  //
  // void anything()
  // {
  //   print('something');
  // }
  //
  // void filePicker() async{
  //   setState() {
  //     isLoading = true;
  //   }
  //
  //   result = await FilePicker.platform.pickFiles(
  //     allowedExtensions: ['pdf'],
  //     type: FileType.custom,
  //     allowMultiple: false
  //   );
  //
  //   if(result == null)
  //     {
  //       print('abc');
  //     }
  //   pickedFile = result!.files.first.path;
  //   // pickedFilePdf = File(pickedFile!) as PdfDocument;
  //   pickedFilePdf =
  //   PdfDocument(inputBytes: File(pickedFile!).readAsBytesSync());
  //     print(result!.files.first.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Up'),
      ),
      body: Column(
        children: [
          // const Text('Enter the Starting Date of the Semester: '),
          // TextFormField(
          //   validator: (startingDate)
          //   {
          //     if( startingDate == null || startingDate.isEmpty) {
          //       return 'Please Enter the Starting Date of the Semester';
          //     }
          //
          //     startingDateOfSemester = startingDate;
          //     return null;
          //   },
          //   // keyboardType: TextInputType.datetime,
          //   decoration: const InputDecoration(
          //     labelText: 'Starting Date:',
          //     hintText: 'yyyy-mm-dd',
          //   ),
          // ),
          // const Text('Enter the Ending Date of the Semester: '),
          // TextFormField(
          //   validator: (endingDate) {
          //     if (endingDate == null || endingDate.isEmpty) {
          //       return 'Please Enter the Ending Date of the Semester';
          //     }
          //
          //     endingDateOfSemester = endingDate;
          //
          //     if (is_after(endingDateOfSemester, startingDateOfSemester)) {
          //       return null;
          //     } else {
          //       return 'Ending Date must be after the Starting Date';
          //     }
          //   },
          //   decoration: const InputDecoration(
          //     labelText: 'Ending Date:',
          //     hintText: 'yyyy-mm-dd'
          //   )
          // ),
          //
          // isLoading? CircularProgressIndicator():TextButton(
          //     onPressed: () async{
          //       // anything();
          //       filePicker();
          //
          //     },
          //     child: Text('Pick the Timetable')),
          //
          // TextButton(
          //     child: Text('Proceed'),
          //     onPressed: () async{
          //       // if(_myFormKey.currentState!.validate()) {
          //         box.put(StartingDate,startingDateOfSemester);
          //         box.put(EndingDate, endingDateOfSemester);
          //         // print('anything');
          //
          //         await generateTimeTable();
          //         startingSemester();
          //         // print('something');
          //         Navigator.pushReplacementNamed(context, '/home');
          //       // }
          //     }
          // ),

        ],
      ),

    );
  }
}
