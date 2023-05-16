// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

//Code by Xaferdian. Please remove these comments after reading to improve code clarity.

//Packages to import from external sources.
import 'package:flutter/material.dart'; //Material UI
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart'; //3rd party progress bar
import 'package:fl_chart/fl_chart.dart'; //3rd party graphing widget
import 'package:separdianz/userdata.dart';

//Packages segmented internally. Each file holds a definition of widget.
import 'package:separdianz/widgets/graph.dart'; //Line graph
import 'package:separdianz/widgets/profile.dart'; //The widget that appears on the top row
import 'package:separdianz/widgets/progresscard.dart'; //The widget that shows task completion status
import 'package:separdianz/taskitem.dart';
//Color declarations to use throughout the document
import 'package:separdianz/preferences.dart';

//The main function which triggers the 'runApp' function that starts the app

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());

  box = await Hive.openBox(boxName);

  checkUpdate(boxName);

  /*box.put(
    dataName,
    UserData(
        name: 'Grandez Xaferdian',
        currentTasks: [
          ['Test', 2, 3, 45]
        ],
        completedTasks: [
          ['Tsst', 3, 3, 45]
        ],
        outdatedTasks: [['Tgh', 0, 3, 45],['Tghdd', 0, 3, 45]],
        progress: {'14-05-2023': 56},
        lastUpdated: DateTime.now().toString(),
        currentProgress: 0),
  );*/

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Material App Instantiation

      home:
          Home(), //Home is the first page to appear. Its definition is given later on in the code
      theme: ThemeData(
          //This class instantiation sets the overall font of the application and few other preferences, such as style of every text button.
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: text),
              labelStyle: TextStyle(color: text),
              //activeIndicatorBorder: BorderSide(color: primary, width: 1.0),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: otherAvatar)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 3.0))),
          fontFamily: 'Default',
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 187, 255, 252)))),
    );
  }
}

//Home page stateful widget definition. I do not get how these classes work as of yet, but please take them for granted for now, or refer to the flutter documentation for more information.

//The primary distinction between stateless and stateful widget is that the former cant change its form after being declared, while the latter is dynamic and its components can change while the app is running

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() =>
      _HomeState(); //A stateful widget can have many states. We define default state and call it here
}

class _HomeState extends State<Home> {
  //Stateful widget state definition

  //Ignore these data for now. Just know that these are the data that is used to construct the many avatars and many progress cards in the app.

  List<List> avatars = [
    ["Your Progress", "assets/nahida.jpg", 0.2, primary],
    ["Dainsleif", "assets/dainsleif.png", 0.66, otherAvatar],
    ["Kazuha", "assets/kazuha.jpg", 0.76, otherAvatar],
    ["Albedo", "assets/albedo.jpg", 0.96, otherAvatar],
    ["Dainsleif", "assets/dainsleif.png", 0.66, otherAvatar],
  ];

  //The build method of a stateless widget is the one that 'builds' the widget when the app is created and the widget is created.
  @override
  Widget build(BuildContext context) {
    UserData data = box.get(dataName);
    return Scaffold(
      //Every page should return a Scaffold. The Scaffold is the superior ancestor to every widget in a page. Its attributes are self explanatory

      backgroundColor: base_bg,
      appBar: AppBar(
          //Every scaffold contains an appBar and a body. A Body can be any widget tree, while an appbar must return an instantiation of class AppBar
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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${data.name} is your username!')));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: TaskList(
                  data: data,
                ))
          ],
        ),
      ),
    );
  }
}
