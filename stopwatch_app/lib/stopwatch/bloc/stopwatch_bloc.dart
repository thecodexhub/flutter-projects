import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stopwatch_app/stopwatch/ticker.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  StopwatchBloc({Ticker? ticker})
      : _ticker = ticker ?? const Ticker(),
        super(const StopwatchState()) {
    on<StopwatchStarted>(_onStopwatchStarted);
    on<StopwatchPaused>(_onStopwatchPaused);
    on<StopwatchResumed>(_onStopwatchResumed);
    on<StopwatchReset>(_onStopwatchReset);
    on<StopwatchLapAdded>(_onStopwatchLapAdded);
    on<_StopwatchTicked>(_onStopwatchTicked);
  }

  final Ticker _ticker;

  StreamSubscription<int>? _stopwatchStreamSubscription;

  FutureOr<void> _onStopwatchStarted(
    StopwatchStarted event,
    Emitter<StopwatchState> emit,
  ) async {
    _stopwatchStreamSubscription?.cancel();
    _stopwatchStreamSubscription = _ticker.tick().listen((ticks) {
      add(_StopwatchTicked(ticks: ticks));
    });
  }

  FutureOr<void> _onStopwatchPaused(
    StopwatchPaused event,
    Emitter<StopwatchState> emit,
  ) async {
    _stopwatchStreamSubscription?.pause();
    emit(state.copyWith(status: StopwatchStatus.inPause));
  }

  FutureOr<void> _onStopwatchResumed(
    StopwatchResumed event,
    Emitter<StopwatchState> emit,
  ) async {
    _stopwatchStreamSubscription?.resume();
    emit(state.copyWith(status: StopwatchStatus.inProgress));
  }

  FutureOr<void> _onStopwatchReset(
    StopwatchReset event,
    Emitter<StopwatchState> emit,
  ) async {
    _stopwatchStreamSubscription?.cancel();
    emit(const StopwatchState());
  }

  FutureOr<void> _onStopwatchTicked(
    _StopwatchTicked event,
    Emitter<StopwatchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: StopwatchStatus.inProgress,
        ticks: event.ticks,
      ),
    );
  }

  FutureOr<void> _onStopwatchLapAdded(
    StopwatchLapAdded event,
    Emitter<StopwatchState> emit,
  ) async {
    emit(state.copyWith(laps: [...state.laps, state.ticks]));
  }

  @override
  Future<void> close() {
    _stopwatchStreamSubscription?.cancel();
    return super.close();
  }
}
