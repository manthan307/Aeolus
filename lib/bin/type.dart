import 'package:flutter/material.dart';

class TaskType {
  const TaskType({
    required this.id,
    required this.title,
    this.description = "",
    this.time = TimeOfDay.now,
    this.dailyTask = false,
    this.remaindbefore = false,
    this.remaind = false,
  });

  final String title;
  final String description;
  final int id;
  final dynamic time;
  final bool dailyTask;
  final bool remaind;
  final bool remaindbefore;
}
