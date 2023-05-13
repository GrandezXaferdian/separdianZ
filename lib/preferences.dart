import 'package:flutter/material.dart';

Color primary = Color.fromARGB(255, 187, 255, 252);
Color otherAvatar = Color.fromARGB(255, 247, 255, 173);
Color base_bg = Color.fromARGB(255, 30, 34, 34);
Color progress_bg = Color.fromARGB(255, 22, 25, 25);
Color text = Color.fromARGB(255, 206, 206, 206);
Color card_bg = Color.fromARGB(146, 50, 50, 50);

TextStyle title_secondary_light =
    TextStyle(fontSize: 18.0, color: text, fontWeight: FontWeight.bold);

TextStyle bigtitle_secondary_light =
    TextStyle(fontSize: 60.0, color: text, fontWeight: FontWeight.bold);

TextStyle title_tertiary =
    TextStyle(fontSize: 18.0, color: otherAvatar, fontWeight: FontWeight.bold);

ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(primary),
    foregroundColor:
        MaterialStatePropertyAll<Color>(Color.fromARGB(255, 0, 0, 0)));



String convertTimeToString(int seconds) {
  String timestr = '';
  bool hrs = false;
  Duration time = Duration(seconds: seconds);
  if (time.inHours > 0) {
    timestr += '${time.inHours} hrs ';
    hrs = true;
  }
  if (time.inMinutes % 60 > 0) {
    timestr += '${time.inMinutes % 60} mins ';
    seconds -= time.inMinutes * 60;
  }

  if (!hrs) {
    timestr += '${time.inSeconds % 60} secs ';
  }

  return timestr;
}
