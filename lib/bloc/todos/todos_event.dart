part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent extends Equatable {}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];

  @override
  String toString() {
    return 'AddTodo { todo: $todo }';
  }
}

class UpdateTodo extends TodosEvent {
  final Todo todo;

  UpdateTodo(this.todo);

  @override
  List<Object?> get props => [todo];

  @override
  String toString() {
    return 'UpdateTodo { todo: $todo }';
  }
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo(this.todo);

  @override
  List<Object?> get props => [todo];

  @override
  String toString() {
    return 'DeleteTodo { todo: $todo }';
  }
}

class ToggleAllTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class CompleteAllTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class ClearAllTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}