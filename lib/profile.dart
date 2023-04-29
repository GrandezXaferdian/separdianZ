import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String picpath;
  final double progress;
  final Color barcolor;

  ProfileAvatar(
      {super.key,
      this.name = "Your progress",
      this.picpath = "assets/nahida.jpg",
      this.progress = 0.0,
      this.barcolor = const Color.fromARGB(255, 176, 255, 217)});

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Stack(alignment: AlignmentDirectional.center, children: [
          CircleAvatar(
            backgroundImage: AssetImage(picpath),
            radius: 38.0,
          ),
          CircularPercentIndicator(
            backgroundColor: Color.fromARGB(255, 22, 25, 25),
            progressColor: barcolor,
            percent: progress,
            lineWidth: 3.0,
            radius: 40.0,
            // animateFromLastPercent: true,
            animation: true,
            animationDuration: 1000,
          )
        ]),
        SizedBox(height: 5.0),
        Text(
          name,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        )
      ],
    );
  }
}
