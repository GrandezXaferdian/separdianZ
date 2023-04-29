// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:separdianz/graph.dart';
import 'package:separdianz/profile.dart';
import 'package:separdianz/progresscard.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 187, 255, 252)))),
    ));

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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
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
            ),
            Divider(
              color: Color.fromARGB(40, 255, 255, 255),
              endIndent: 15.0,
              indent: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: EfficiencyChart(),
            ),
            Divider(
              color: Color.fromARGB(40, 255, 255, 255),
              endIndent: 15.0,
              indent: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    '77% Progress!',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 176, 255, 217),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '4/7',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 176, 255, 217),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ProgressCard(),
            ProgressCard(),
            ProgressCard()
          ],
        ),
      )),
    );
  }
}
