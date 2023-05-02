// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:separdianz/widgets/graph.dart';
import 'package:separdianz/widgets/profile.dart';
import 'package:separdianz/widgets/progresscard.dart';

Color primary = Color.fromARGB(255, 187, 255, 252);
Color otherAvatar = Color.fromARGB(255, 247, 255, 173);

void main() => runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
          fontFamily: 'Default',
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 187, 255, 252)))),
    ));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List> avatars = [
    ["Your Progress", "assets/nahida.jpg", 0.2, primary],
    ["Dainsleif", "assets/dainsleif.png", 0.66, otherAvatar],
    ["Kazuha", "assets/kazuha.jpg", 0.76, otherAvatar],
    ["Albedo", "assets/albedo.jpg", 0.96, otherAvatar],
    ["Dainsleif", "assets/dainsleif.png", 0.66, otherAvatar],
  ];

  List<List> tasks = [
    ["Machine Learning", 3, 4],
    ["Academics", 3, 7],
    ["Flutter App Development", 6, 8]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 34, 34),
      appBar: AppBar(
          title: Text(
            'SepardianZ',
            style:
                TextStyle(fontFamily: 'Default', fontWeight: FontWeight.bold),
          ),
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
                        Text('Hello there!!')));
              },
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.stacked_bar_chart))
          ]),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              //padding: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: avatars.map((e) {
                    return ProfileAvatar(
                        name: e[0],
                        progress: e[2],
                        picpath: e[1],
                        barcolor: e[3],
                        delete: () {
                          setState(() {
                            avatars.remove(e);
                          });
                        });
                  }).toList(),
                ),
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
              child: ProgressTitle(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                children: tasks.map((e) {
                  return ProgressCard(task: e[0], outof: e[2], completed: e[1]);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProgressTitle extends StatelessWidget {
  const ProgressTitle({super.key, this.total = 0});
  final int total;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          '77% Progress!',
          style: TextStyle(
              fontSize: 20.0, color: primary, fontWeight: FontWeight.bold),
        ),
        Text(
          '4/7',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 176, 255, 217),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
