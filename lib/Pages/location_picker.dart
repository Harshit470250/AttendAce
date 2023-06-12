import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:attendace/services/Courses_list.dart';
import 'package:attendace/main.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose the location of Classes'),
      ),
          body: OpenStreetMapSearchAndPick(
        center: LatLong(box.get(ClassLocation).latitude, box.get(ClassLocation).longitude),
    buttonColor: Colors.blue,
    buttonText: 'Set Current Location',
    onPicked: (pickedData) {
          Map classes_location = {
            'Longitude': pickedData.latLong.longitude,
            'Latitude': pickedData.latLong.latitude,
            'address' : pickedData.address
          };
          Navigator.pop(context, classes_location);
    }),
    );
  }
}
