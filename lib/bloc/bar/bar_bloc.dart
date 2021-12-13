import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bar_event.dart';

class BarBloc extends Bloc<BarEvent, int> {
  BarBloc() : super(0) {
    on<TabChanged>((TabChanged event, Emitter emit) {
      emit(event.newTab);
    });
  }
}
