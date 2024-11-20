class Task {
  const Task({
    required this.id,
    required this.title,
    this.description = "",
    required this.time,
    this.remind = false,
    this.repeat = false,
  });

  final String title;
  final String description;
  final int id;
  final DateTime time;
  final bool remind;
  final bool repeat;
}
