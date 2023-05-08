import 'package:flutter/material.dart';
import 'package:separdianz/widgets/progresscard.dart';

class Task {
  final String name;
  final int completed;
  final int outof;
  final int cycleDuration;

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
      this.cycleDuration = 15});

  final String taskname;
  final int completed;
  final int outof;
  final int cycleDuration;
  final Function() onremove;

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
        remove: widget.onremove);
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

  void add_task(String name, int cycles, int duration) {
    setState(() {
      tasks.add(Task(
          name: name, completed: 0, outof: cycles, cycleDuration: duration));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        return TaskItem(
            taskname: task.name,
            completed: task.completed,
            outof: task.outof,
            cycleDuration: task.cycleDuration,
            onremove: () {
              setState(() {
                tasks.remove(task);
              });
            });
      }).toList(),
    );
  }
}
