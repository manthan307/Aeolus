import 'package:aeolus/db/type.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Tasklist extends StatefulWidget {
  const Tasklist({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Tasklist();
  }
}

class _Tasklist extends State<Tasklist> {
  List<Task> tasks = [
    Task(id: 0, title: "Complete Chemistry Notes.", time: DateTime.now()),
    Task(id: 1, title: "Workout", repeat: true, time: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Tasks",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ReorderableListView(
                shrinkWrap: true,
                children: <Widget>[
                  for (int index = 0; index < tasks.length; index += 1)
                    Tasktile(
                      task: tasks[index],
                      key: Key("$index"),
                    )
                ],
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = tasks.removeAt(oldIndex);
                    tasks.insert(newIndex, item);
                  });
                },
              ),
            ],
          ),
        ));
  }
}

class Tasktile extends StatefulWidget {
  final Task task;

  const Tasktile({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _Tasktile();
}

class _Tasktile extends State<Tasktile> {
  bool completed = false;
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.title,
            style: TextStyle(
                decoration: completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Today, 7:45 PM"),
              widget.task.repeat
                  ? Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Iconsax.repeat,
                        size: 15,
                      ),
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
      leading: Checkbox(
        value: completed,
        shape: const CircleBorder(),
        onChanged: (value) {
          setState(() {
            completed = value!;
          });
        },
      ),
    );
  }
}
