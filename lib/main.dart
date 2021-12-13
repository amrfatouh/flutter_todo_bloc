import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todos/bloc/bar/bar_bloc.dart';
import 'package:flutter_bloc_todos/bloc/filter/filter_bloc.dart';
import 'package:flutter_bloc_todos/bloc/stats/stats_bloc.dart';
import 'package:flutter_bloc_todos/bloc/todos/todos_bloc.dart';
import 'package:flutter_bloc_todos/bloc/weather_bloc_observer.dart';
import 'package:flutter_bloc_todos/models/enums.dart';
import 'package:flutter_bloc_todos/models/todo.dart';

void main() {
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: TodosBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FilterBloc(context.read<TodosBloc>()),
              ),
              BlocProvider(
                create: (context) => StatsBloc(context.read<TodosBloc>()),
              ),
              BlocProvider(
                create: (context) => BarBloc(),
              ),
            ],
            child: MaterialApp(
              home: BlocBuilder<BarBloc, int>(
                builder: (context, state) {
                  return Scaffold(
                    appBar: AppBar(title: const Text('Todos App')),
                    bottomNavigationBar: BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.list),
                          label: 'Todos',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.show_chart),
                          label: 'Stats',
                        ),
                      ],
                      currentIndex: state,
                      onTap: (newTab) =>
                          context.read<BarBloc>().add(TabChanged(newTab)),
                    ),
                    body: state == 1
                        ? Center(
                            child: BlocBuilder<StatsBloc, StatsState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Total: ${state.total}'),
                                    Text('Completed: ${state.completed}'),
                                  ],
                                );
                              },
                            ),
                          )
                        : BlocBuilder<FilterBloc, FilterState>(
                            builder: (context, state) {
                            return Center(
                                child: ListView(
                              children: [
                                ...(context.read<FilterBloc>().state
                                        as FilteredTodosLoaded)
                                    .filteredTodos
                                    .map((todo) => Text(
                                        '${todo.title}, ${todo.completed ? '✔' : '✖'}'))
                                    .toList(),
                                ElevatedButton(
                                  child: const Text('add'),
                                  onPressed: () {
                                    int rand = Random().nextInt(2000000000);
                                    context.read<TodosBloc>().add(AddTodo(Todo(
                                        id: rand,
                                        title: 'todo $rand',
                                        description: 'desc $rand',
                                        completed: Random().nextBool())));
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('update'),
                                  onPressed: () {
                                    final bloc = context.read<TodosBloc>();
                                    bloc.add(UpdateTodo(
                                        (bloc.state as TodosLoaded)
                                            .todos
                                            .last
                                            .copyWith(title: 'todo2')));
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('delete'),
                                  onPressed: () {
                                    final bloc = context.read<TodosBloc>();
                                    bloc.add(DeleteTodo(
                                        (bloc.state as TodosLoaded)
                                            .todos
                                            .last));
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('toggle all'),
                                  onPressed: () {
                                    final bloc = context.read<TodosBloc>();
                                    bloc.add(ToggleAllTodos());
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('complete all'),
                                  onPressed: () {
                                    final bloc = context.read<TodosBloc>();
                                    bloc.add(CompleteAllTodos());
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<FilterBloc>().add(
                                            const FilterChanged(Filter.all));
                                      },
                                      child: const Text('all'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<FilterBloc>().add(
                                            const FilterChanged(
                                                Filter.completed));
                                      },
                                      child: const Text('completed'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<FilterBloc>().add(
                                            const FilterChanged(
                                                Filter.inProgress));
                                      },
                                      child: const Text('in progress'),
                                    ),
                                  ],
                                )
                              ],
                            ));
                          }),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
