import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingHome extends StatefulWidget {
  const LoadingHome({Key? key}) : super(key: key);

  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.blue,
        size: 50,
    ),
        ),
    );
  }
}
