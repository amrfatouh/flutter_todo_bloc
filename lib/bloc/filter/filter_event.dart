part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterChanged extends FilterEvent {
  final Filter filter;

  const FilterChanged(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'FilterChanged { filter: $filter }';
  }
}

class TodosUpdated extends FilterEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodosUpdated { todos: $todos }';
  }
}
