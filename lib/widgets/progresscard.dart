// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:separdianz/preferences.dart';
import 'package:separdianz/taskpage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard(
      {super.key,
      this.task = "Task",
      this.completed = 0,
      this.outof = 1,
      required this.remove,
      this.cycleDuration,
      required this.inctask,
      required this.dectask,
      required this.delete});
  final String task;
  final int completed;
  final int outof;
  final Function() remove;
  final Function() delete;
  final cycleDuration;
  final Function() inctask;
  final Function() dectask;

  @override
  State<ProgressCard> createState() => _ProgressCardState(
      completed: completed, outof: outof, cycleDuration: cycleDuration);
}

class _ProgressCardState extends State<ProgressCard> {
  int completed;
  int outof;
  int cycleDuration;
  Color prim = primary;

  void increment_task() {
    widget.inctask();
    setState(() {
      completed++;
      if (completed == outof) {
        prim = otherAvatar;
      }
    });
    print('$completed/$outof');
  }

  void decrement_task() {
    widget.dectask();
    setState(() {
      if (completed == outof) {
        prim = primary;
      }
      completed--;
    });
    print('$completed/$outof');
  }

  _ProgressCardState(
      {this.completed = 0, this.outof = 1, this.cycleDuration = 10});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
          dismissible:
              DismissiblePane(key: UniqueKey(), onDismissed: widget.delete),
          motion: ScrollMotion(),
          children: <Widget>[
            SlidableAction(
                onPressed: (context) {
                  widget.delete();
                },
                backgroundColor: error,
                foregroundColor: Colors.black,
                icon: Icons.delete,
                label: 'Delete')
          ]),
      child: Card(
        color: card_bg,
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
                      widget.task,
                      style: title_secondary_light,
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
                color: prim,
                minHeight: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(prim),
                            foregroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 0, 0, 0))),
                        onPressed: () {
                          (completed == outof)
                              ? widget.remove()
                              //super.dispose();

                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                          task: widget.task,
                                          completed: completed,
                                          parentinc: increment_task,
                                          parentdec: decrement_task,
                                          outof: outof,
                                          cycleDuration: cycleDuration)),
                                );
                        },
                        icon: Icon(Icons.task_alt_sharp),
                        label: (completed == outof)
                            ? Text('Finish Task!')
                            : Text('Continue Task!')),
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
