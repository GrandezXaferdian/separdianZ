import 'package:flutter/material.dart';
import 'package:separdianz/widgets/progresscard.dart';

class Task {
  final String name;
  final int completed;
  final int outof;

  Task({required this.name, required this.completed, required this.outof});
}

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      this.taskname = "Task",
      this.completed = 0,
      this.outof = 1,
      required this.onremove});

  final String taskname;
  final int completed;
  final int outof;
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
    Task(name: "Machine Learning", completed: 3, outof: 4),
    Task(name: "Academics", completed: 3, outof: 7),
    Task(name: "Flutter App Development", completed: 7, outof: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        return TaskItem(
            taskname: task.name,
            completed: task.completed,
            outof: task.outof,
            onremove: () {
              setState(() {
                tasks.remove(task);
              });
            });
      }).toList(),
    );
  }
}
