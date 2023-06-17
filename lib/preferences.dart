import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:separdianz/taskitem.dart';
import 'package:separdianz/userdata.dart';

String boxName = 'SepardianZ_DATA';
String dataName = 'USERDATA';
String taskDataName = 'USERDATA_TASK';

String version = 'v.0.2.4';
String updateInfo = '''
Version 0.2.4 changes

Various functionality optimizations such as 
1) Prevent the task to be dismissable
2) Add a step up button to add a new cycle
3) Make the time save when the user presses the back button as well
4) Add provision to hide tasks completed''';
Color primary = Color.fromARGB(255, 187, 255, 252);
Color otherAvatar = Color.fromARGB(255, 247, 255, 173);
Color base_bg = Color.fromARGB(255, 30, 34, 34);
Color progress_bg = Color.fromARGB(255, 22, 25, 25);
Color text = Color.fromARGB(255, 206, 206, 206);
Color card_bg = Color.fromARGB(255, 38, 40, 40);
Color error = Color.fromARGB(255, 255, 101, 101);

TextStyle title_secondary_light =
    TextStyle(fontSize: 18.0, color: text, fontWeight: FontWeight.bold);

TextStyle description = TextStyle(fontSize: 16.0, color: text);

TextStyle microtitle_secondary_light =
    TextStyle(fontSize: 12.0, color: text, fontWeight: FontWeight.bold);

TextStyle bigtitle_secondary_light =
    TextStyle(fontSize: 60.0, color: text, fontWeight: FontWeight.bold);

TextStyle midtitle_primary =
    TextStyle(fontSize: 25.0, color: primary, fontWeight: FontWeight.bold);

TextStyle midtitle_black =
    TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

TextStyle title_tertiary =
    TextStyle(fontSize: 18.0, color: otherAvatar, fontWeight: FontWeight.bold);

TextStyle title_primary =
    TextStyle(fontSize: 18.0, color: otherAvatar, fontWeight: FontWeight.bold);

TextStyle title_error =
    TextStyle(fontSize: 18.0, color: error, fontWeight: FontWeight.bold);

ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(primary),
    foregroundColor:
        MaterialStatePropertyAll<Color>(Color.fromARGB(255, 0, 0, 0)));

ButtonStyle tertiaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(otherAvatar),
    foregroundColor:
        MaterialStatePropertyAll<Color>(Color.fromARGB(255, 0, 0, 0)));

String convertTimeToString(int seconds) {
  String timestr = '';
  bool hrs = false;
  bool mins = false;
  Duration time = Duration(seconds: seconds);
  if (time.inHours > 0) {
    timestr += '${time.inHours} h ';
    hrs = true;
  }
  if (time.inMinutes % 60 > 0) {
    timestr += '${time.inMinutes % 60} m ';
    seconds -= time.inMinutes * 60;
    mins = true;
  }

  if (!hrs && !mins) {
    timestr += '${time.inSeconds % 60} s ';
  }

  return timestr;
}

String getFormattedDate(DateTime obj) {
  return '${obj.day}-${obj.month}-${obj.year}';
}

void checkUpdate(String boxName) {
  Box box = Hive.box(boxName);
  UserData data = box.get(dataName);

  String lastDate = getFormattedDate(
      DateTime.parse(data.lastUpdated).subtract(Duration(hours: 2)));
  String currentDate =
      getFormattedDate(DateTime.now().subtract(Duration(hours: 2)));
  if (lastDate != currentDate) {
    print(lastDate + " || " + currentDate);
    print("Day has lapsed. Updating lists");
    print(data.currentTasks);
    print(data.currentProgress);
    for (var element in data.currentTasks) {
      data.outdatedTasks.add(element);
    }

    data.currentTasks = [];
    data.completedTasks = [];

    data.progress[lastDate] = data.currentProgress;
    data.currentProgress = 0;
    data.lastUpdated = DateTime.now().toString();

    print('After Modification:');
    print(data.currentTasks);
    print(data.currentProgress);
    print('Progress Map:');
    print(data.progress);
    box.put(dataName, data);
  } else {
    print('Day has not lapsed. Tasks are retained as is');
  }
}

List getWeekdays() {
  DateTime today = DateTime.now();
  int cap = today.weekday;
  today = today.subtract(Duration(days: today.weekday - 1));
  List<String> dates = [];
  for (int i = 0; i < cap - 1; i++) {
    dates.add(getFormattedDate(today));

    today = today.add(Duration(days: 1));
  }

  return dates;
}
