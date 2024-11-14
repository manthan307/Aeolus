import 'package:aeolus/bin/type.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  List<TaskType> habits = [
    const TaskType(id: 0, title: "WakeUp at 5 A.M.", dailyTask: true),
    const TaskType(id: 1, title: "Study For 5 hours", dailyTask: true),
  ];

  List<TaskType> tasks = [
    const TaskType(id: 0, title: "Complete Chemistry Notes.", dailyTask: false),
    const TaskType(id: 1, title: "Workout", dailyTask: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Habits",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.merge(const TextStyle(color: Colors.white54)),
                    ),
                  ),
                  // Daily task List
                  SizedBox(
                    height: (70 * habits.length).toDouble(),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        return Taskcard(title: habits[index].title);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "Tasks",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.merge(const TextStyle(color: Colors.white54)),
                    ),
                  ),
                  //Tasks
                  SizedBox(
                    height: (70 * tasks.length).toDouble(),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Taskcard(title: tasks[index].title);
                      },
                    ),
                  ),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              enableDrag: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              builder: (BuildContext context) {
                return const BottomSheet();
              },
            );
          },
          child: const Icon(Iconsax.add),
        ));
  }
}

class Taskcard extends StatefulWidget {
  const Taskcard({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _TaskCard();
}

class _TaskCard extends State<Taskcard> {
  @override
  Widget build(BuildContext context) {
    var checked = false;

    return Card(
      key: widget.key,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: Theme.of(context).cardColor,
        leading: Checkbox(
            value: checked,
            onChanged: (bool? newval) {
              setState(() {
                checked = !checked;
              });
            }),
        trailing: const Icon(Iconsax.star),
        title: Text(
          widget.title,
          style: TextStyle(
              decoration:
                  checked ? TextDecoration.lineThrough : TextDecoration.none),
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheet();
}

class _BottomSheet extends State<BottomSheet> {
  var dailyTasks = {true};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: SegmentedButton(
                emptySelectionAllowed: false,
                segments: const [
                  ButtonSegment(value: true, label: Text("Habit")),
                  ButtonSegment(value: false, label: Text("Task"))
                ],
                selected: dailyTasks,
                onSelectionChanged: (s) {
                  setState(() {
                    dailyTasks = s;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    right: 20,
                    left: 20),
                child: Column(children: <Widget>[
                  const TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        )),
                    maxLength: 25,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 150, child: Text("data")),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Category",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                          Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onPrimaryContainer,
                        )),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  ?.onPrimary),
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text("Cancel"))
                    ],
                  ),
                  const SizedBox(height: 20),
                ])),
          ],
        ),
      ),
    );
  }
}
