import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<StatefulWidget> createState() => _TaskSheet();
}

class _TaskSheet extends State<TaskSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now().add(const Duration(minutes: 5));
  bool remind = false;
  bool repeat = false;

  @override
  Widget build(BuildContext context) {
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
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          )),
                      maxLength: 25,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      minLines: 2,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Card(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 200,
                                                    child: CupertinoDatePicker(
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .dateAndTime,
                                                      initialDateTime:
                                                          selectedDate,
                                                      minimumDate:
                                                          DateTime.now().add(
                                                              const Duration(
                                                                  minutes: 1)),
                                                      onDateTimeChanged:
                                                          (value) {
                                                        setState(() {
                                                          selectedDate = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Done")),
                                                    ],
                                                  )
                                                ],
                                              )),
                                            ),
                                          );
                                        },
                                      )
                                    },
                                icon: const Icon(Iconsax.calendar)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    remind = !remind;
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        remind
                                            ? Theme.of(context)
                                                .buttonTheme
                                                .colorScheme
                                                ?.primary
                                                .withOpacity(0.2)
                                            : Colors.transparent)),
                                icon: Icon(remind
                                    ? Icons.alarm_on_outlined
                                    : Icons.alarm_off_outlined)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    repeat = !repeat;
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        repeat
                                            ? Theme.of(context)
                                                .buttonTheme
                                                .colorScheme
                                                ?.primary
                                                .withOpacity(0.2)
                                            : Colors.transparent)),
                                icon: const Icon(Iconsax.repeat))
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                            Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .onPrimaryContainer,
                          )),
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    ?.onPrimary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ]))),
        ],
      ),
    );
  }
}
