import 'package:flutter/material.dart';
import 'package:separdianz/preferences.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage(
      {super.key,
      required this.addfunc,
      this.tasktitle = "",
      this.removeHandler});
  final String tasktitle;
  final Function(String taskname, int cycles, int duration) addfunc;
  final Function()? removeHandler;
  @override
  State<CreateTaskPage> createState() =>
      _CreateTaskPageState(tasktitle: tasktitle);
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final taskname = TextEditingController();
  final cycles = TextEditingController();
  final duration = TextEditingController();
  String tasktitle;
  _CreateTaskPageState({required this.tasktitle}) {
    if (tasktitle != "") {
      taskname.text = tasktitle;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: base_bg,
      appBar: AppBar(
        backgroundColor: base_bg,
        foregroundColor: primary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: taskname,
              style: title_tertiary,
              decoration: InputDecoration(labelText: 'Enter Task name'),
            ),
            TextField(
              controller: cycles,
              style: title_tertiary,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter number of cycles'),
            ),
            TextField(
              controller: duration,
              cursorColor: primary,
              style: title_tertiary,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Enter duration of each cycle'),
            ),
            ElevatedButton(
                style: primaryButtonStyle,
                onPressed: () {
                  //TO DO: Implement checking of values here
                  widget.addfunc(taskname.text, int.parse(cycles.text),
                      int.parse(duration.text));
                  if (widget.removeHandler != null) {
                    widget.removeHandler!();
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${taskname.text} task created!')));
                },
                child: Text('Create task!'))
          ],
        ),
      ),
    );
  }
}
