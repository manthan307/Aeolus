import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Tasks",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.merge(const TextStyle(color: Colors.white54)),
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.only(top: 20),
                children: [
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                  taskCard(context),
                ],
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Iconsax.add),
        ));
  }

  Card taskCard(context) {
    return Card(
      surfaceTintColor: Theme.of(context).cardColor,
      child: ListTile(
        leading: Checkbox(value: false, onChanged: (bool? newval) {}),
        title: const Text("Complete Chemistry Notes"),
      ),
    );
  }
}
