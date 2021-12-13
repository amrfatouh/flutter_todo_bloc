part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoaded extends FilterState {
  final Filter filter;
  final List<Todo> filteredTodos;

  const FilteredTodosLoaded(this.filter, this.filteredTodos);

  @override
  List<Object> get props => [filter, filteredTodos];

  @override
  String toString() {
    return 'FilteredTodosLoaded { filter: $filter, filteredTodos: $filteredTodos }';
  }

  FilteredTodosLoaded copyWith({Filter? filter, List<Todo>? filteredTodos}) {
    return FilteredTodosLoaded(
        filter ?? this.filter, filteredTodos ?? this.filteredTodos);
  }
}
