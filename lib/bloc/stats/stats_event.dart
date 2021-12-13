part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];
}

class TodosUpdatedStats extends StatsEvent {
  final List<Todo> todos;

  const TodosUpdatedStats(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodosUpdated { todos: $todos }';
  }
}
