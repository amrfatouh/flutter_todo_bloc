part of 'todos_bloc.dart';

@immutable
abstract class TodosState extends Equatable {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded(this.todos);

  @override
  List<Object?> get props => [todos];

  TodosLoaded copyWith({List<Todo>? todos}) {
    return TodosLoaded(todos ?? [...this.todos]);
  }

  @override
  String toString() {
    return 'TodosLoaded { todos: $todos }';
  }
}
