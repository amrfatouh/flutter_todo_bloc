import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todos/bloc/todos/todos_bloc.dart';
import 'package:flutter_bloc_todos/models/todo.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  TodosBloc todosBloc;
  late StreamSubscription streamSubscription;

  StatsBloc(this.todosBloc)
      : super(StatsState((todosBloc.state as TodosLoaded).todos.length,
            (todosBloc.state as TodosLoaded).todos.countCompleted)) {
    streamSubscription = todosBloc.stream.listen((TodosState state) {
      add(TodosUpdatedStats((state as TodosLoaded).todos));
    });

    on<TodosUpdatedStats>((TodosUpdatedStats event, Emitter emit) {
      emit(StatsState(event.todos.length, event.todos.countCompleted));
    });
  }
}
