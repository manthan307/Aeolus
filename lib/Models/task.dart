class Task {
  const Task({
    required this.id,
    required this.title,
    required this.category,
    this.complete = false,
    this.pinned = false,
    this.time = "",
    this.desc = "",
  });

  final String id;
  final String title;
  final String desc;
  final String time;
  final String category;
  final bool complete;
  final bool pinned;
}

class Category {
  const Category({required this.id, required this.title});

  final int id;
  final String title;
}
