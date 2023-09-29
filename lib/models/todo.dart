// The 'Todo' class represents a task with an identifier, title and completion status. It offers
// methods to convert between the object and its JSON representation, excluding the task's ID when needed.

class Todo {
  final String id;
  final String title;
  bool done;

  Todo({
    required this.id,
    required this.title,
    this.done = false,
  });

  // Factory constructor to create a Todo object from a map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      done: json['done'],
    );
  }

  // Method to convert Todo object to a map, excluding the ID
  Map<String, dynamic> toJsonWithoutId() {
    return {
      'title': title,
      'done': done,
    };
  }
}