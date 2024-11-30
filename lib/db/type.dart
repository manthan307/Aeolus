import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'type.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final bool remind;
  @HiveField(5)
  final bool repeat;
  @HiveField(6)
  final bool complete;
  @HiveField(7)
  final DateTime createdAt;

  Task({
    required this.title,
    this.description = "",
    required this.time,
    required this.createdAt,
    this.remind = false,
    this.repeat = false,
    this.complete = false,
  }) : id = const Uuid().v4();

  Task copywith({
    String? id,
    String? title,
    String? description,
  }) {
    return Task(
      title: title ?? this.title,
      time: time,
      description: description ?? this.description,
      createdAt: DateTime.now(),
    );
  }
}
