import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';

class Startedview extends StatefulWidget {
  const Startedview({super.key});

  @override
  State<Startedview> createState() => _StartedviewState();
}

class _StartedviewState extends State<Startedview> {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: TColor.primaryColor1,
    body: Stack(
      children: [
          Image.asset(
            "assets/img/GradCircle.png",
            width: 328,
            height: 399,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 115,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Image.asset(
                  "assets/img/Logo.png",
                  width: 103,
                  height: 99,
                ),
                Text(
                  'Heart Rate\nTracker',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                )
              ],
            ),
          )
      ],
    ),
  );
} 
}