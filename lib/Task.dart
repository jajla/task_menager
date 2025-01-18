class Task {
  int? id;
  String title;
  String description;
  String category;
  String priority;
  String dueDate;
  String status; // completed or pending

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'dueDate': dueDate,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      priority: map['priority'],
      dueDate: map['dueDate'],
      status: map['status'],  // assuming 'status' is a string (completed/pending)
    );
  }
}
