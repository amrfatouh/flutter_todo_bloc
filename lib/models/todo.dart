import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todos/models/enums.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  Todo copyWith(
      {int? id, String? title, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return 'Todo { id: $id, title: $title, description: $description, completed: $completed }';
  }

  @override
  List<Object?> get props => [id, title, description, completed];

  static List<Todo> get initialTodos => const [
        Todo(id: 1, title: 'todo 1', description: 'desc 1', completed: true),
        Todo(id: 2, title: 'todo 2', description: 'desc 2', completed: false),
        Todo(id: 3, title: 'todo 3', description: 'desc 3', completed: true),
      ];
}

extension TodoListMethods on List<Todo> {
  int get countCompleted => where((todo) => todo.completed).length;

  List<Todo> filter(Filter filter) {
    switch (filter) {
      case Filter.all:
        return this;
      case Filter.completed:
        return where((todo) => todo.completed).toList();
      case Filter.inProgress:
        return where((todo) => !todo.completed).toList();
    }
  }
}
