import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todos/models/todo.dart';
import 'package:meta/meta.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(TodosLoaded(Todo.initialTodos)) {
    on<AddTodo>(addTodo);
    on<UpdateTodo>(updateTodo);
    on<DeleteTodo>(deleteTodo);
    on<ToggleAllTodos>(toggleAllTodos);
    on<CompleteAllTodos>(completeAllTodos);
  }

  void addTodo(AddTodo event, Emitter<TodosState> emit) {
    final todosLoaded = state as TodosLoaded;
    emit(todosLoaded.copyWith(todos: [...todosLoaded.todos, event.todo]));
  }

  void updateTodo(UpdateTodo event, Emitter emit) {
    final todosLoaded = state as TodosLoaded;
    var newTodos = [...todosLoaded.todos];
    int index = newTodos.indexWhere((todo) => todo.id == event.todo.id);
    newTodos.replaceRange(index, index + 1, [event.todo]);
    emit(todosLoaded.copyWith(todos: newTodos));
  }

  void deleteTodo(DeleteTodo event, Emitter emit) {
    final todosLoaded = state as TodosLoaded;
    List<Todo> newTodos = [...todosLoaded.todos]..remove(event.todo);
    final newTodosLoaded = todosLoaded.copyWith(todos: newTodos);
    emit(newTodosLoaded);
  }

  void toggleAllTodos(ToggleAllTodos event, Emitter emit) {
    final todosLoaded = state as TodosLoaded;
    List<Todo> newTodos = List.from(todosLoaded.todos)
        .map<Todo>(
            (todo) => (todo as Todo).copyWith(completed: !todo.completed))
        .toList();
    emit(todosLoaded.copyWith(todos: newTodos));
  }

  void _setAllTodos(Emitter emit, bool completed) {
    final todosLoaded = state as TodosLoaded;
    List<Todo> newTodos = List.from(todosLoaded.todos)
        .map<Todo>((todo) => (todo as Todo).copyWith(completed: completed))
        .toList();
    emit(todosLoaded.copyWith(todos: newTodos));
  }

  void completeAllTodos(CompleteAllTodos event, Emitter emit) =>
      _setAllTodos(emit, true);
}
