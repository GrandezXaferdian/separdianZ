// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SepardianZ'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 70, 185, 174),
      ),
      // ignore: prefer_const_constructors
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Welcome to SepardianZ!",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text("The app was made by Sep and Xaferdian!"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    print("clicked!");
                  },
                  icon: Icon(Icons.access_alarm),
                  label: Text("Click me!")),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('X'),
        backgroundColor: Colors.indigo.shade50,
      ),
    );
  }
}
