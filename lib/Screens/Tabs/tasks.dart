import 'package:aeolus/components/tasks/tasklist.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:aeolus/components/tasks/bottomsheet.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Tasklist(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffd6d0f0),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              enableDrag: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              builder: (BuildContext context) {
                return const TaskSheet();
              },
            );
          },
          child: const Icon(Iconsax.add),
        ));
  }
}
