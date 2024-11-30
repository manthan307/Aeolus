import 'package:aeolus/db/type.dart';
import 'package:aeolus/provider/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class TaskSheet extends ConsumerStatefulWidget {
  const TaskSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskSheet();
}

class _TaskSheet extends ConsumerState<TaskSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(const Duration(minutes: 5));
  bool remind = false;
  bool repeat = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void>? _pendingAddTask;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CalendarDatePicker(
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(9999),
                      onDateChanged: (value) {
                        setState(() {
                          selectedDate = value;
                        });
                      }),
                  const Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton.icon(
                      onPressed: () {
                        _selectTime(context);
                      },
                      label: const Text("Set Time"),
                      icon: const Icon(Iconsax.clock),
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton.icon(
                      onPressed: () {},
                      label: const Text("Repeat"),
                      iconAlignment: IconAlignment.start,
                      icon: const Icon(Iconsax.repeat),
                      style: ButtonStyle(
                        textStyle: const WidgetStatePropertyAll(
                            TextStyle(textBaseline: TextBaseline.alphabetic)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(onPressed: () {}, child: const Text("Done"))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pendingAddTask,
      builder: (context, snapshot) {
        final isErrored = snapshot.hasError &&
            snapshot.connectionState != ConnectionState.waiting;

        const snackBar = SnackBar(
          content: Text("Oops!! Something went wrong."),
        );
        if (isErrored) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      right: 20,
                      left: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              )),
                          maxLength: 25,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                          controller: titleController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          minLines: 2,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () => {_selectDate(context)},
                                icon: const Icon(Iconsax.calendar)),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final future = ref
                                        .read(taskProvider.notifier)
                                        .addTodo(Task(
                                            title: titleController.text,
                                            time: selectedDate,
                                            createdAt: DateTime.now(),
                                            description:
                                                descriptionController.text,
                                            remind: remind,
                                            repeat: repeat));

                                    setState(() {
                                      _pendingAddTask = future;
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .onPrimaryContainer,
                                )),
                                child: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        "Done",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme
                                                ?.onPrimary),
                                      )),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ]))),
            ],
          ),
        );
      },
    );
  }
}
