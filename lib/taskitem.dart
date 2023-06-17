import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:separdianz/createtaskpage.dart';
import 'package:separdianz/preferences.dart';
import 'package:separdianz/userdata.dart';
import 'package:separdianz/widgets/progresscard.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final GlobalKey<_TaskListState> taskListKey = GlobalKey<_TaskListState>();

class Task {
  String name;
  int completed;
  int outof;
  int cycleDuration;
  int elapsed;

  Task(
      {required this.name,
      required this.completed,
      required this.outof,
      required this.cycleDuration,
      this.elapsed = 0});
}

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      this.taskname = "Task",
      this.completed = 0,
      this.outof = 1,
      required this.onremove,
      this.cycleDuration = 15,
      required this.elapsed,
      required this.inctask,
      required this.dectask,
      required this.delete,
      required this.elapsedUpdate});
  final int elapsed;
  final String taskname;
  final int completed;
  final int outof;
  final int cycleDuration;
  final Function() onremove;
  final Function() inctask;
  final Function() dectask;
  final Function() delete;
  final Function(int) elapsedUpdate;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return ProgressCard(
      key: ObjectKey(widget.taskname),
      task: widget.taskname,
      outof: widget.outof,
      completed: widget.completed,
      cycleDuration: widget.cycleDuration,
      elapsed: widget.elapsed,
      remove: widget.onremove,
      inctask: widget.inctask,
      dectask: widget.dectask,
      delete: widget.delete,
      elapsedUpdate: widget.elapsedUpdate,
    );
  }
}

List<Task> convertToTask(List<List> tasks) {
  List<Task> converted = [];

  for (var element in tasks) {
    converted.add(Task(
        name: element[0],
        completed: element[1],
        outof: element[2],
        cycleDuration: element[3],
        elapsed: element[4]));
  }
  return converted;
}

List<List> convertToList(List<Task> tasks) {
  List<List> converted = [];

  for (var element in tasks) {
    converted.add([
      element.name,
      element.completed,
      element.outof,
      element.cycleDuration,
      element.elapsed,
    ]);
  }
  return converted;
}

class TaskList extends StatefulWidget {
  TaskList({Key? key, required this.data}) : super(key: key) {
    contask = convertToTask(data.currentTasks);
    concompletedtask = convertToTask(data.completedTasks);
    conoutdatedtask = convertToTask(data.outdatedTasks);
  }
  UserData data;
  late List<Task> contask;
  late List<Task> concompletedtask;
  late List<Task> conoutdatedtask;
  @override
  State<TaskList> createState() => _TaskListState(
      tasks: contask,
      completedtasks: concompletedtask,
      outdatedtasks: conoutdatedtask);
}

class _TaskListState extends State<TaskList> with WidgetsBindingObserver {
  _TaskListState(
      {required this.tasks,
      required this.completedtasks,
      required this.outdatedtasks});
  List<Task> tasks;

  List<Task> completedtasks;

  List<Task> outdatedtasks;

  add_task(String name, int cycles, int duration) {
    print("Task add invoked");
    setState(() {
      tasks.add(Task(
          name: name, completed: 0, outof: cycles, cycleDuration: duration));
    });
  }

  calculateProgress(bool progressAlone) {
    //print('this is getting fired!');
    int dc = 0;
    int dof = 0;
    for (var element in tasks) {
      dc += element.cycleDuration * element.completed + element.elapsed;
      dof += element.outof * element.cycleDuration;
    }

    for (var element in completedtasks) {
      dc += element.cycleDuration * element.completed + element.elapsed;
      dof += element.outof * element.cycleDuration;
    }

    int progress = (dof != 0) ? (100 * (dc / dof)).ceil() : 0;

    if (progressAlone) {
      return progress;
    } else {
      return [dc, dof, progress];
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      print('Attempting to save!');
      widget.data.currentTasks = convertToList(tasks);
      widget.data.completedTasks = convertToList(completedtasks);
      widget.data.outdatedTasks = convertToList(outdatedtasks);
      widget.data.currentProgress = calculateProgress(true);
      widget.data.lastUpdated = DateTime.now().toString();
      Box box = Hive.box(boxName);
      box.put(dataName, widget.data);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: ProgressTitle(tasklist: tasks, complist: completedtasks),
        ),
        Column(
          children: completedtasks.map((task) {
            return CompletedTask(
                key: ObjectKey(task.name),
                taskobj: task,
                removefunc: () {
                  setState(() {
                    completedtasks.remove(task);
                  });
                });
          }).toList(),
        ),
        ((completedtasks.isNotEmpty)
            ? Divider(
                color: Color.fromARGB(40, 255, 255, 255),
                endIndent: 15.0,
                indent: 15.0,
              )
            : Container()),
        Column(
          children: tasks.map((task) {
            return TaskItem(
                taskname: task.name,
                completed: task.completed,
                outof: task.outof,
                cycleDuration: task.cycleDuration,
                elapsed: task.elapsed,
                onremove: () {
                  setState(() {
                    completedtasks.add(task);
                    tasks.remove(task);
                  });
                },
                inctask: () {
                  setState(() {
                    task.completed++;
                  });
                },
                dectask: () {
                  setState(() {
                    task.completed--;
                  });
                },
                delete: () {
                  setState(() {
                    tasks.remove(task);
                  });
                },
                elapsedUpdate: (int elapsed) {
                  setState(() {
                    task.elapsed = elapsed;
                  });
                });
          }).toList(),
        ),
        AddTask(addfunc: add_task),
        Column(
          children: outdatedtasks.map((e) {
            return OutdatedTask(
                taskobj: e,
                removefunc: () {
                  setState(() {
                    outdatedtasks.remove(e);
                  });
                },
                restorefunc: () {
                  setState(() {
                    tasks.add(e);
                    outdatedtasks.remove(e);
                  });
                });
          }).toList(),
        )
        //SaveTask(save: save)
      ],
    );
  }
}

class ProgressTitle extends StatelessWidget {
  late int progress;
  late int completed;
  late int outof;

  ProgressTitle({super.key, required this.tasklist, required this.complist}) {
    int dc = 0;
    int dof = 0;
    int cc = 0;
    int oc = 0;
    for (var element in tasklist) {
      dc += element.cycleDuration * element.completed + element.elapsed;
      dof += element.outof * element.cycleDuration;
      cc += element.completed;
      oc += element.outof;
    }

    for (var element in complist) {
      dc += element.cycleDuration * element.completed + element.elapsed;
      dof += element.outof * element.cycleDuration;
      cc += element.completed;
      oc += element.outof;
    }
    completed = cc;
    outof = oc;
    progress = (dof != 0) ? (100 * (dc / dof)).ceil() : 0;
  }
  final List<Task> tasklist;
  final List<Task> complist;
  @override
  Widget build(BuildContext context) {
    return (tasklist.isNotEmpty)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                '$progress% Progress!',
                style: TextStyle(
                    fontSize: 20.0,
                    color: primary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$completed/$outof',
                style: TextStyle(
                    fontSize: 20.0,
                    color: primary,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        : Text(
            'All tasks completed! Otsukarasamadesu~',
            style: TextStyle(
                fontSize: 16.0, color: primary, fontWeight: FontWeight.bold),
          );
  }
}

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key, required this.taskobj, required this.removefunc}) {
    int total = taskobj.cycleDuration * taskobj.outof;
    time = Duration(seconds: total);
    timestring = convertTimeToString(total);
  }
  final removefunc;
  final Task taskobj;
  late Duration time;
  late String timestring;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
          dismissible:
              DismissiblePane(key: UniqueKey(), onDismissed: removefunc),
          motion: ScrollMotion(),
          children: <Widget>[
            SlidableAction(
                onPressed: (context) {
                  removefunc();
                },
                backgroundColor: error,
                foregroundColor: Colors.black,
                icon: Icons.delete,
                label: 'Delete')
          ]),
      child: Card(
        color: card_bg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(taskobj.name, style: title_tertiary),
              Text(
                timestring,
                style: title_secondary_light,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OutdatedTask extends StatelessWidget {
  OutdatedTask(
      {super.key,
      required this.taskobj,
      required this.removefunc,
      required this.restorefunc}) {
    int total = taskobj.cycleDuration * taskobj.completed;
    time = Duration(seconds: total);
    timestring = convertTimeToString(total);
  }
  final restorefunc;
  final removefunc;
  final Task taskobj;
  late Duration time;
  late String timestring;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
          dismissible:
              DismissiblePane(key: UniqueKey(), onDismissed: restorefunc),
          motion: ScrollMotion(),
          children: <Widget>[
            SlidableAction(
                onPressed: (context) {
                  restorefunc();
                },
                backgroundColor: otherAvatar,
                foregroundColor: Colors.black,
                icon: Icons.restore,
                label: 'Restore')
          ]),
      endActionPane: ActionPane(
          dismissible:
              DismissiblePane(key: UniqueKey(), onDismissed: removefunc),
          motion: ScrollMotion(),
          children: <Widget>[
            SlidableAction(
                onPressed: (context) {},
                backgroundColor: error,
                foregroundColor: Colors.black,
                icon: Icons.delete,
                label: 'Delete Permanently')
          ]),
      child: Card(
        color: card_bg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(taskobj.name, style: title_error),
              Text(
                '${taskobj.completed}/${taskobj.outof}',
                style: title_secondary_light,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddTask extends StatelessWidget {
  const AddTask({super.key, required this.addfunc});
  final Function(String taskname, int cycles, int duration) addfunc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: primary, width: 2.0),
              foregroundColor: primary),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateTaskPage(addfunc: addfunc)));
          },
          icon: Icon(Icons.add),
          label: Text('Create New Task!')),
    );
  }
}

/*class SaveTask extends StatelessWidget {
  const SaveTask({super.key, required this.save});
  final Function() save;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: primary, width: 2.0),
              foregroundColor: primary),
          onPressed: save,
          icon: Icon(Icons.add),
          label: Text('SAVE')),
    );
  }
}*/
