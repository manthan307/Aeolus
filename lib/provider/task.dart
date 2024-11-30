import 'package:aeolus/db/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final taskProvider = AsyncNotifierProvider.autoDispose<Todolist, List<Task>>(
  Todolist.new,
);

class Todolist extends AutoDisposeAsyncNotifier<List<Task>> {
  late Box<Task> _hive;
  late List<Task> _box;

  @override
  Future<List<Task>> build() async {
    _hive = Hive.box<Task>("tasks");
    _box = _hive.values.toList();
    return _box;
  }

  Future<void> addTodo(Task todo) async {
    _hive.add(todo);
    state = AsyncData(_hive.values.toList());
  }

  Future<void> delete(Task todo) async {
    _hive.values.where((e) => e.id == todo.id).first.delete();
    state = AsyncData(_hive.values.toList());
  }

  Future<void> updateTask(Task todo) async {}
}
