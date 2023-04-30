import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, this.task = "Task"});
  final String task;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_outlined)),
            title: Text(
              widget.task,
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
                  content: Text('Settings is currently under construction!')));
            },
          ),
        ]));
  }
}
