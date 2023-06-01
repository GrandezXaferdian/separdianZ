import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:separdianz/preferences.dart';
import 'package:separdianz/widgets/progresscard.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    super.key,
    this.task = "Task",
    this.parentinc,
    this.parentdec,
    this.completed = 0,
    this.outof = 1,
    this.cycleDuration,
    this.elapsedUpdate,
    this.elapsed = 0,
  });
  final int outof;
  final int completed;
  final int elapsed;
  final String task;
  final Function()? parentinc;
  final Function()? parentdec;
  final Function(int)? elapsedUpdate;
  final cycleDuration;
  @override
  State<TaskPage> createState() => _TaskPageState(
      parentinc: parentinc,
      taskcompleted: completed,
      taskoutof: outof,
      parentdec: parentdec,
      cycleDuration: cycleDuration,
      elapsedUpdate: elapsedUpdate,
      elapsed: elapsed);
}

class _TaskPageState extends State<TaskPage> {
  int taskcompleted;
  int taskoutof;
  int cycleDuration;
  int elapsed;
  Duration totalseconds = Duration(seconds: 15);
  Duration remainingseconds = Duration(seconds: 15);

  _TaskPageState({
    this.parentinc,
    this.taskcompleted = 0,
    this.taskoutof = 1,
    this.parentdec,
    this.cycleDuration = 15,
    this.elapsedUpdate,
    this.elapsed = 0,
  }) {
    totalseconds = Duration(seconds: cycleDuration);
    remainingseconds = Duration(seconds: cycleDuration - elapsed);
  }

  final player = AudioPlayer();

  Function()? parentdec;
  Function()? parentinc;
  Function(int)? elapsedUpdate;
  Color prim = primary;

  bool taskallcomplete = false;
  Timer? timerfunc;
  String time = "17:08";

  double progress = 0;
  bool running = false;
  bool over = false;
  String quote =
      "And on the day, the choice she made between a million stars and an eternal life is her prince's smile :)";

  void handleTimer() {
    if (!over && !taskallcomplete) {
      if (!running) {
        setState(() {
          running = true;
        });

        timerfunc = Timer.periodic(Duration(milliseconds: 100), (t) {
          setState(() {
            remainingseconds =
                Duration(milliseconds: remainingseconds.inMilliseconds - 100);
            if (remainingseconds.isNegative) {
              over = true;
              timerfunc?.cancel();
              //update_timer();
              increment_task();
              time = "Over!";
              player.play(
                AssetSource('finish.wav'),
              );
              remainingseconds = totalseconds;
              running = false;

              over = false;

              return;
            }
            update_timer();
          });
        });
      } else {
        setState(() {
          running = false;
        });

        timerfunc?.cancel();
      }
    }
  }

  void increment_task() {
    if (!taskallcomplete) {
      setState(() {
        taskcompleted++;
        parentinc!();
      });
      if (taskcompleted == taskoutof) {
        setState(() {
          taskallcomplete = true;
          prim = otherAvatar;
        });
      }
    }
  }

  void decrement_task() {
    if (taskallcomplete) {
      setState(() {
        taskallcomplete = false;
        prim = primary;
        taskcompleted--;
        parentdec!();
      });
    } else if (taskcompleted != 0) {
      setState(() {
        parentdec!();
        taskcompleted--;
      });
    }
  }

  void update_timer() {
    progress =
        1 - (remainingseconds.inMilliseconds / totalseconds.inMilliseconds);
    Duration stime = Duration(milliseconds: remainingseconds.inMilliseconds);
    print(stime.inSeconds);
    String ssec = (stime.inSeconds % 60).toString().padLeft(2, '0');
    String smin = (stime.inMinutes % 60).toString().padLeft(2, '0');
    time = "$smin:$ssec";
  }

  @override
  void initState() {
    super.initState();
    if (taskcompleted == taskoutof) {
      setState(() {
        taskallcomplete = true;
      });
    }
    update_timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base_bg,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                //Do not pop the page. Just send it to the background
                elapsedUpdate!(totalseconds.inSeconds - remainingseconds.inSeconds);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_outlined)),
          title: Text(
            widget.task,
            style:
                TextStyle(fontFamily: 'Default', fontWeight: FontWeight.bold),
          ),
          foregroundColor: prim,
          backgroundColor: Color.fromARGB(255, 30, 34, 34),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                player.play(
                  AssetSource('finish.wav'),
                );
              },
            ),
          ]),
      body: Column(
        children: [
          LinearPercentIndicator(
            progressColor: prim,
            backgroundColor: progress_bg,
            percent: taskcompleted / taskoutof,
            animation: true,
            animateFromLastPercent: true,
            animationDuration: 500,
          ),
          SizedBox(
            height: 160.0,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CircularPercentIndicator(
                radius: 130.0,
                lineWidth: 10,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 90,
                percent: progress,
                backgroundColor: progress_bg,
                progressColor: taskallcomplete ? prim : null,
                // ignore: prefer_const_constructors
                linearGradient: !taskallcomplete
                    ? LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        stops: [0.0, 1.0],
                        colors: [primary, otherAvatar])
                    : null,
              ),
              Text(
                time,
                style: bigtitle_secondary_light,
              )
            ],
          ),
          SizedBox(
            height: 60.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: running
                    ? null
                    : () {
                        if (remainingseconds == totalseconds) {
                          setState(() {
                            decrement_task();
                            update_timer();
                            print("Decrementing tasks. Now: $taskcompleted");
                          });
                        } else {
                          setState(() {
                            remainingseconds = totalseconds;
                            update_timer();
                            print("Resetting timer. Now: $taskcompleted");
                          });
                        }
                      },
                icon: Icon(Icons.restart_alt_sharp),
                disabledColor: text,
                color: prim,
                iconSize: 50.0,
              ),
              ElevatedButton.icon(
                  onPressed: handleTimer,
                  icon: running
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow_sharp),
                  label: running ? Text("Pause") : Text("Resume!"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(prim),
                      foregroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 0, 0, 0)))),
              IconButton(
                onPressed: running
                    ? null
                    : () {
                        setState(() {
                          increment_task();
                        });
                      },
                disabledColor: text,
                icon: Icon(Icons.add),
                color: prim,
                iconSize: 50.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Color.fromARGB(40, 255, 255, 255),
            endIndent: 15.0,
            indent: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${quote}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: text,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}
