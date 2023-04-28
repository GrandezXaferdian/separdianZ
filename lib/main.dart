// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 34, 34),
      appBar: AppBar(
          title: Text('SepardianZ'),
          foregroundColor: Color.fromARGB(255, 187, 255, 252),
          backgroundColor: Color.fromARGB(255, 30, 34, 34),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Settings is currently under construction!')));
              },
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.stacked_bar_chart))
          ]),
      // ignore: prefer_const_constructors
      body: Center(
        child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        //padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(width: 15.0),
            ProfileAvatar(
              progress: 0.2,
            ),
            SizedBox(width: 12.0),
            ProfileAvatar(
              name: "Dainsleif",
              progress: 0.75,
              picpath: "assets/dainsleif.png",
              barcolor: Color.fromARGB(255, 247, 255, 173),
            ),
            SizedBox(width: 12.0),
            ProfileAvatar(
              name: "Kazuha",
              progress: 0.55,
              picpath: "assets/kazuha.jpg",
              barcolor: Color.fromARGB(255, 247, 255, 173),
            ),
            SizedBox(width: 12.0),
            ProfileAvatar(
              name: "Albedo",
              progress: 0.77,
              picpath: "assets/albedo.jpg",
              barcolor: Color.fromARGB(255, 247, 255, 173),
            ),
            SizedBox(width: 12.0),
            ProfileAvatar(
              name: "Kazuha",
              progress: 0.55,
              picpath: "assets/kazuha.jpg",
              barcolor: Color.fromARGB(255, 247, 255, 173),
            )
          ],
        ),
      )),
        floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('X'),
        backgroundColor: Colors.indigo.shade50,
      ),
    );
  }
}

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
