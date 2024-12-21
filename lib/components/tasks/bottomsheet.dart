import 'package:aeolus/db/type.dart';
import 'package:aeolus/provider/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskSheet extends ConsumerStatefulWidget {
  final Task? task;

  const TaskSheet({this.task, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskSheet();
}

class _TaskSheet extends ConsumerState<TaskSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void>? _pendingAddTask;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with task data if editing an existing task
    if (widget.task != null) {
      titleController.value = TextEditingValue(text: widget.task!.title);
      descriptionController.value =
          TextEditingValue(text: widget.task!.description);
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.task == null) {
                                      // Add new task
                                      final future = ref
                                          .read(taskProvider.notifier)
                                          .addTodo(Task(
                                            title: titleController.text,
                                            createdAt: DateTime.now(),
                                            description:
                                                descriptionController.text,
                                          ));
                                      setState(() {
                                        _pendingAddTask = future;
                                        Navigator.pop(context);
                                      });
                                    } else {
                                      // Update existing task
                                      final future = ref
                                          .read(taskProvider.notifier)
                                          .updateTask(
                                              Task(
                                                title: titleController.text,
                                                createdAt:
                                                    widget.task!.createdAt,
                                                description:
                                                    descriptionController.text,
                                              ),
                                              widget.task!);
                                      setState(() {
                                        _pendingAddTask = future;
                                        Navigator.pop(context);
                                      });
                                    }
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
                                        widget.task != null ? "Update" : "Done",
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
