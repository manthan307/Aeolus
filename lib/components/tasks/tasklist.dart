import 'package:aeolus/components/tasks/bottomsheet.dart';
import 'package:aeolus/db/type.dart';
import 'package:aeolus/provider/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class Tasklist extends StatefulWidget {
  const Tasklist({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Tasklist();
  }
}

class _Tasklist extends State<Tasklist> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                child: Text(
                  "Tasks",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final AsyncValue<List<Task>> list = ref.watch(taskProvider);

                  if (list.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (list.valueOrNull!.isEmpty) {
                    return empty();
                  } else {
                    return ReorderableListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: <Widget>[
                        for (int index = 0;
                            index < list.value!.length;
                            index += 1)
                          ListTile(
                            key: Key(list.value![index].id),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                showDragHandle: true,
                                isScrollControlled: true,
                                enableDrag: true,
                                backgroundColor: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                builder: (BuildContext context) {
                                  return TaskSheet(
                                    task: list.value![index],
                                  );
                                },
                              );
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.value![index].title,
                                  style: TextStyle(
                                      decoration: list.value![index].complete
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // list.value![index].createdAt
                                    //             .difference(DateTime(now.year,
                                    //                 now.month, now.day))
                                    //             .inDays
                                    date(list.value![index].createdAt),
                                  ],
                                )
                              ],
                            ),
                            leading: Checkbox(
                              value: list.value![index].complete,
                              shape: const CircleBorder(),
                              onChanged: (value) {
                                //pending...
                              },
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  void delete() {
                                    ref
                                        .watch(taskProvider.notifier)
                                        .delete(list.value![index]);
                                  }

                                  delete();
                                },
                                icon: const Icon(Iconsax.trash)),
                          )
                      ],
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          // if (oldIndex < newIndex) {
                          //   newIndex -= 1;
                          // }
                          // final item = tasks.removeAt(oldIndex);
                          // tasks.insert(newIndex, item);
                        });
                      },
                    );
                  }
                },
              )
            ],
          ),
        ));
  }

  SizedBox empty() => SizedBox(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/img/empty.png",
                cacheHeight: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Try Adding tasks by clicking '+' icon.",
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.color
                        ?.withOpacity(0.7)),
              )
            ],
          ),
        ),
      );
}

Text date(DateTime createdAt) {
  List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  DateTime now = DateTime.now();
  var day = createdAt.difference(DateTime(now.year, now.month, now.day)).inDays;

  if (day == 0) {
    return const Text("Today");
  } else if (day == -1) {
    return const Text("Yesterday");
  } else if (day == 1) {
    return const Text("Tomorrow");
  } else {
    return Text("${createdAt.day} ${months[(createdAt.month.toInt()) - 1]}");
  }
}
