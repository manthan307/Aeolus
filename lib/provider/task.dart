import 'package:aeolus/db/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// Provider for managing the list of tasks.
final taskProvider = AsyncNotifierProvider.autoDispose<Todolist, List<Task>>(
  Todolist.new,
);

// Class to manage the list of tasks using Riverpod and Hive.
class Todolist extends AutoDisposeAsyncNotifier<List<Task>> {
  late Box<Task> _hive; // Hive box to store tasks
  late List<Task> _box; // List to hold tasks

  @override
  Future<List<Task>> build() async {
    _hive = Hive.box<Task>("tasks"); // Open Hive box for tasks.
    _box = _hive.values.toList(); // Get the list of tasks from Hive.
    return _box; // Return the list of tasks.
  }

  // Add a new task to the list.
  Future<void> addTodo(Task todo) async {
    _hive.add(todo); // Add task to Hive box.
    state = AsyncData(
        _hive.values.toList()); // Update the state with the new list of tasks.
  }

  // Delete a task from the list.
  Future<void> delete(Task todo) async {
    _hive.values
        .where((e) => e.id == todo.id)
        .first
        .delete(); // Delete task from Hive box.
    state = AsyncData(
        _hive.values.toList()); // Update the state with the new list of tasks.
  }

  // Update an existing task.
  Future<void> updateTask(Task todo, Task prev) async {
    _hive.values.where((e) => e.id == prev.id).first.delete();
    await _hive.add(todo);
    state = AsyncData(
        _hive.values.toList()); // Update the state with the new list of tasks.
  }
}
