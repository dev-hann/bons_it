import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventStarted>(_onStarted);
  }

  FutureOr<void> _onStarted(HomeEventStarted event, Emitter<HomeState> emit) {}
}
