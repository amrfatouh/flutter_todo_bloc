part of 'bar_bloc.dart';

class BarEvent extends Equatable {
  const BarEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends BarEvent {
  final int newTab;

  const TabChanged(this.newTab);

  @override
  List<Object> get props => [newTab];

  @override
  String toString() {
    return 'TabChanged { newTab: $newTab }';
  }
}
