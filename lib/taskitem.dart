import 'package:flutter/material.dart';
import 'package:separdianz/createtaskpage.dart';
import 'package:separdianz/preferences.dart';
import 'package:separdianz/widgets/progresscard.dart';

class Task {
  String name;
  int completed;
  int outof;
  int cycleDuration;

  Task(
      {required this.name,
      required this.completed,
      required this.outof,
      required this.cycleDuration});
}

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      this.taskname = "Task",
      this.completed = 0,
      this.outof = 1,
      required this.onremove,
      this.cycleDuration = 15,
      required this.inctask,
      required this.dectask});

  final String taskname;
  final int completed;
  final int outof;
  final int cycleDuration;
  final Function() onremove;
  final Function() inctask;
  final Function() dectask;

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
        remove: widget.onremove,
        inctask: widget.inctask,
        dectask: widget.dectask);
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(name: "Machine Learning", completed: 3, outof: 4, cycleDuration: 5),
    Task(name: "Academics", completed: 3, outof: 7, cycleDuration: 15),
    Task(
        name: "Flutter App Development",
        completed: 7,
        outof: 8,
        cycleDuration: 10),
  ];

  List<Task> completedtasks = [
    Task(name: 'Solving crisis', completed: 1, outof: 1, cycleDuration: 3650)
  ];

  add_task(String name, int cycles, int duration) {
    setState(() {
      tasks.add(Task(
          name: name, completed: 0, outof: cycles, cycleDuration: duration));
    });
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
            return CompletedTask(taskobj: task);
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
                });
          }).toList(),
        ),
        AddTask(addfunc: add_task),
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
    tasklist!.forEach((element) {
      dc += element.completed;
      dof += element.outof;
    });

    complist.forEach((element) {
      dc += element.completed;
      dof += element.outof;
    });

    completed = dc;
    outof = dof;
    progress = (100 * (completed / outof)).ceil();
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
            'All tasks completed! Otsukarasamadesu！',
            style: TextStyle(
                fontSize: 16.0, color: primary, fontWeight: FontWeight.bold),
          );
  }
}

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key, required this.taskobj}) {
    int total = taskobj.cycleDuration * taskobj.outof;
    time = Duration(seconds: total);
    timestring = convertTimeToString(total);
  }
  final Task taskobj;
  late Duration time;
  late String timestring;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: card_bg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(taskobj.name, style: title_tertiary),
            Text(
              '${timestring}spent',
              style: title_secondary_light,
            )
          ],
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTaskPage(addfunc: addfunc)));
          },
          icon: Icon(Icons.add),
          label: Text('Create New Task!')),
    );
  }
}
