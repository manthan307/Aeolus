import 'package:aeolus/db/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskProvider = AsyncNotifierProvider.autoDispose<Todolist, List<Task>>(
  Todolist.new,
);

class Todolist extends AutoDisposeAsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    // The logic we previously had in our FutureProvider is now in the build method.
    return [
      Task(id: 0, title: "Complete Chemistry Notes.", time: DateTime.now()),
      Task(id: 1, title: "Workout", repeat: true, time: DateTime.now()),
    ];
  }

  Future<void> addTodo(Task todo) async {}
}
