import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:separdianz/preferences.dart';

import '../taskitem.dart';

class Settings {
  static bool hideCompletedTasks = false;

  static void hideCompletedTaskSet(bool val) {
    hideCompletedTasks = val;
    taskListKey.currentState!.modifier(() {
      taskListKey.currentState!.hideCompletedTasks = hideCompletedTasks;
    });
  }
}

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base_bg,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: const Text(
          "Settings",
          style: TextStyle(fontFamily: 'Default', fontWeight: FontWeight.bold),
        ),
        foregroundColor: primary,
        backgroundColor: Color.fromARGB(255, 30, 34, 34),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: version,
                  applicationName: 'SepardianZ (Alpha)',
                  children: [Text(updateInfo)]);
            },
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Option(
                optionName: "Hide completed Tasks",
                modifier: (bool val) {
                  Settings.hideCompletedTaskSet(val);
                },
                defaultValue: Settings.hideCompletedTasks)
          ]),
    );
  }
}

class Option extends StatefulWidget {
  const Option(
      {super.key,
      required this.optionName,
      required this.modifier,
      required this.defaultValue});

  final bool defaultValue;
  final String optionName;
  final Function(bool) modifier;

  @override
  State<Option> createState() => _OptionState(value: defaultValue);
}

class _OptionState extends State<Option> {
  _OptionState({required this.value});

  bool value;

  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Track color when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return otherAvatar;
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.optionName,
                style: title_secondary_light,
              ),
            ),
            Switch(
                activeColor: primary,
                trackColor: trackColor,
                value: value,
                onChanged: (bool val) {
                  setState(() {
                    value = val;
                  });
                  widget.modifier(val);
                })
          ],
        ),
      ),
    );
  }
}
