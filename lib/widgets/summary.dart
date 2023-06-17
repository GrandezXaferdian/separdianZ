import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:separdianz/preferences.dart';

import '../taskitem.dart';

final GlobalKey<_SummaryState> summaryKey = GlobalKey<_SummaryState>();

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  List details = [0, 0, 0];
  late Timer infiniteUpdate;
  int tolerance = 0;
  String status = 'You are doing well. Keep it up!';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateSummary();
      infiniteUpdate = Timer.periodic(Duration(milliseconds: 1000), (t) {
        updateSummary();
      });
    });
  }

  void updateSummary() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);
    int availableSeconds = midnight.difference(now).inSeconds;
    int allocatedSeconds = details[1] - details[0];
    tolerance = availableSeconds - allocatedSeconds;

    if (details[1] != 0) {
      if (tolerance > 5000) {
        setState(() {
          status = 'You are doing well! Keep up!';
        });
      } else if (tolerance > 3600) {
        setState(() {
          status = 'Stay focused! Dont procrasticate. ';
        });
      } else if (tolerance > 600) {
        setState(() {
          status = 'You are up against a challenge!';
        });
      } else {
        setState(() {
          status = 'Cut down on your goals.';
        });
      }
    } else {
      setState(() {
        status = 'Plan tasks to start day!';
      });
    }
    setState(() {
      details = taskListKey.currentState?.calculateProgress(false) ?? [0, 0, 0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: base_bg,
      child: Column(children: [
        Text(
          'Total time: ${(details[0] / 3600).toStringAsFixed(1)}/${(details[1] / 3600).toStringAsFixed(1)}',
          style: title_secondary_light,
        ),
        Text(
          'Tolerance: ${convertTimeToString(tolerance)}',
          style: title_secondary_light,
        ),
        Text(
          status,
          style: microtitle_secondary_light,
        )
      ]),
    );
  }
}

/*

*/