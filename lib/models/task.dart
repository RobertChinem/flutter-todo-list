class Task {
  final String id;
  final String title;
  final String description;
  final bool done;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.done,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        description = json['description'],
        done = json['done'];
}
