class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final String dueDate;
  final String status;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.status,
  });

  // Konwersja z mapy (np. z bazy danych) na obiekt Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      priority: map['priority'],
      dueDate: map['dueDate'],
      status: map['status'],
    );
  }

  // Konwersja obiektu Task na mapę (np. do zapisania w bazie danych)
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
}
