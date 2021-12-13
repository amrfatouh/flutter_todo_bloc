import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todos/bloc/todos/todos_bloc.dart';
import 'package:flutter_bloc_todos/models/enums.dart';
import 'package:flutter_bloc_todos/models/todo.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  TodosBloc todosBloc;
  late StreamSubscription streamSubscription;

  FilterBloc(this.todosBloc)
      : super(FilteredTodosLoaded(
            Filter.all, (todosBloc.state as TodosLoaded).todos)) {
    streamSubscription = todosBloc.stream.listen((TodosState state) {
      add(TodosUpdated((state as TodosLoaded).todos));
    });
    on<FilterChanged>(filterChanged);
    on<TodosUpdated>(todosUpdated);
  }

  void filterChanged(FilterChanged event, Emitter emit) {
    TodosLoaded todosLoaded = todosBloc.state as TodosLoaded;
    FilteredTodosLoaded filteredTodosLoaded = state as FilteredTodosLoaded;
    emit(filteredTodosLoaded.copyWith(
        filter: event.filter,
        filteredTodos: _filterTodos(todosLoaded.todos, event.filter)));
  }

  void todosUpdated(TodosUpdated event, Emitter emit) {
    FilteredTodosLoaded filteredTodosLoaded = state as FilteredTodosLoaded;
    emit(filteredTodosLoaded.copyWith(
        filteredTodos: _filterTodos(event.todos, filteredTodosLoaded.filter)));
  }

  List<Todo> _filterTodos(List<Todo> todos, Filter filter) {
    switch (filter) {
      case Filter.all:
        return todos;
      case Filter.completed:
        return todos.where((todo) => todo.completed).toList();
      case Filter.inProgress:
        return todos.where((todo) => !todo.completed).toList();
    }
  }
}
