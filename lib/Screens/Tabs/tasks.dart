import 'package:aeolus/Providers/task_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tasks extends ConsumerWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(CupertinoIcons.add),
        ),
        body: todos.isEmpty
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/empty.png",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Add Tasks By Clicking '+' Button",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ))
            : ListView(
                padding: const EdgeInsets.only(top: 10),
                // const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                children: [
                    TaskTile(
                      context: context,
                      title: todos.first.title,
                      completed: todos.first.complete,
                      id: todos.first.id,
                    ),
                    TaskTile(
                      context: context,
                      title: "title",
                      id: "",
                    ),
                  ]));
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.context,
    required this.title,
    required this.id,
    this.completed = false,
  });

  final BuildContext context;
  final String title;

  final bool completed;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9).withOpacity(0.32),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Checkbox(
            value: completed,
            onChanged: (bool? value) {
              // TaskList().toggle(id);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.clock,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("4:00 pm")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
