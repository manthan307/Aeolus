import 'package:aeolus/Models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TaskList extends Notifier<List<Task>> {
  @override
  List<Task> build() => [
        const Task(id: "todo-0", title: "Hc verma", category: "study"),
        const Task(id: "todo-1", title: "Rd Sharma", category: "study"),
        const Task(id: "todo-2", title: "Exercise", category: "Health"),
      ];

  void add(String title, String category, String? desc) {
    state = [
      ...state,
      Task(id: _uuid.v4(), title: title, category: category, desc: desc!)
    ];
  }

  void toggle(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
            id: task.id,
            complete: !task.complete,
            title: task.title,
            category: task.category,
          )
        else
          task,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
              id: task.id,
              complete: task.complete,
              title: title,
              category: task.category)
        else
          task,
    ];
  }

  void remove(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

final todoListProvider = NotifierProvider<TaskList, List<Task>>(TaskList.new);
