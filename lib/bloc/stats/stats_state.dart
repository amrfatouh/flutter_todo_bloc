part of 'stats_bloc.dart';

class StatsState extends Equatable {
  final int total;
  final int completed;

  const StatsState(this.total, this.completed);

  @override
  List<Object> get props => [total, completed];

  @override
  String toString() {
    return 'StatsState { total: $total, completed: $completed }';
  }
}
