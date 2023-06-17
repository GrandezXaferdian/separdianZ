import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:separdianz/createtaskpage.dart';
import 'package:separdianz/preferences.dart';
import 'package:separdianz/taskitem.dart';
import 'package:separdianz/taskuserdata.dart';

class TodoPage extends StatefulWidget {
  TodoPage({super.key, required this.data});

  TaskUserData data;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin {
  late List todoList;

  final taskname = TextEditingController();
  @override
  void initState() {
    super.initState();
    todoList = widget.data.tasks;

    print("Tasks: ");
    print(widget.data.tasks);
    print(widget.data.lastUpdated);
  }

  int hr = DateTime.now().hour;
  addTask() {
    setState(() {
      todoList.add(taskname.text);
    });
    taskname.clear();
    Box box = Hive.box(boxName);
    widget.data.tasks = todoList;
    widget.data.lastUpdated = DateTime.now().toString();
    box.put(taskDataName, widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Container(
              width: double.infinity,
              height: 135,
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (4 <= hr && hr <= 18)
                          ? AssetImage('assets/todo_morning.jpg')
                          : AssetImage('assets/todo_night.jpg')))),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Tasks!',
                style: title_secondary_light,
              ),
              Text(
                '${todoList.length} Tasks',
                style: title_secondary_light,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: todoList
                .map((e) => TodoTask(
                      title: e,
                      removeHandler: () {
                        setState(() {
                          todoList.remove(e);
                        });
                      },
                    ))
                .toList(),
          )
        ]),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      decoration: BoxDecoration(color: base_bg, boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset.zero,
                            blurRadius: 10,
                            spreadRadius: 0)
                      ]),
                      child: TextField(
                        controller: taskname,
                        style: title_tertiary,
                        decoration: InputDecoration(
                            hintText: 'Enter new task here!',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 10,
                      )),
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: addTask,
                        child: Text("+"),
                        style: tertiaryButtonStyle,
                      ))
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}

class TodoTask extends StatelessWidget {
  const TodoTask({super.key, required this.title, required this.removeHandler});
  final String title;
  final Function() removeHandler;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(motion: ScrollMotion(), children: <Widget>[
          SlidableAction(
              //
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateTaskPage(
                              addfunc: taskListKey.currentState!.add_task,
                              tasktitle: title,
                              removeHandler: removeHandler,
                            )));
              },
              backgroundColor: otherAvatar,
              foregroundColor: Colors.black,
              icon: Icons.add,
              label: 'Create')
        ]),
        endActionPane: ActionPane(
            dismissible:
                DismissiblePane(key: UniqueKey(), onDismissed: removeHandler),
            motion: ScrollMotion(),
            children: <Widget>[
              SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: error,
                  foregroundColor: Colors.black,
                  icon: Icons.delete,
                  label: 'Delete Permanently')
            ]),
        child: Container(
          width: double.infinity,
          child: Card(
            color: card_bg,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: title_tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
