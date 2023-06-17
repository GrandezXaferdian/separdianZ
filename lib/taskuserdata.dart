import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:separdianz/taskitem.dart';

part 'taskuserdata.g.dart';

@HiveType(typeId: 12)
class TaskUserData {
  TaskUserData({required this.lastUpdated, required this.tasks});

  @HiveField(4)
  List tasks;

  @HiveField(5)
  String lastUpdated;

}
