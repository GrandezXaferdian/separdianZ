import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:separdianz/taskitem.dart';

part 'userdata.g.dart';

@HiveType(typeId: 14)
class UserData {
  UserData(
      {required this.name,
      required this.currentTasks,
      required this.completedTasks,
      required this.outdatedTasks,
      required this.progress,
      required this.lastUpdated,
      required this.currentProgress});
  @HiveField(0)
  String name;

  @HiveField(1)
  List<List> currentTasks;

  @HiveField(2)
  List<List> completedTasks;

  @HiveField(3)
  List<List> outdatedTasks;

  @HiveField(4)
  Map<String, int> progress;

  @HiveField(5)
  String lastUpdated;

  @HiveField(6)
  int currentProgress;
}
