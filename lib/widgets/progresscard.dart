// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:separdianz/taskpage.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard(
      {super.key, this.task = "Task", this.completed = 0, this.outof = 1});
  final String task;
  final int completed;
  final int outof;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(146, 50, 50, 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 206, 206, 206),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${completed.toString()}/${outof.toString()}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 206, 206, 206),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            LinearProgressIndicator(
              value: completed / outof,
              backgroundColor: Color.fromARGB(255, 22, 25, 25),
              color: Color.fromARGB(255, 176, 255, 217),
              minHeight: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 176, 255, 217)),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 0, 0, 0))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskPage(task: task)),
                        );
                      },
                      icon: Icon(Icons.task_alt_sharp),
                      label: Text('Continue Task!')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
