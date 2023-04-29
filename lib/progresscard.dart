// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(146, 50, 50, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Academics",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 206, 206, 206),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              LinearProgressIndicator(
                value: 0.4,
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
                        onPressed: () {},
                        icon: Icon(Icons.task_alt_sharp),
                        label: Text('Continue Task!')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
