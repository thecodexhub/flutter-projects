part of 'stopwatch_bloc.dart';

abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent();

  @override
  List<Object> get props => [];
}

class StopwatchStarted extends StopwatchEvent {
  const StopwatchStarted();
}

class StopwatchPaused extends StopwatchEvent {
  const StopwatchPaused();
}

class StopwatchResumed extends StopwatchEvent {
  const StopwatchResumed();
}

class StopwatchReset extends StopwatchEvent {
  const StopwatchReset();
}

class _StopwatchTicked extends StopwatchEvent {
  const _StopwatchTicked({required this.ticks});
  final int ticks;

  @override
  List<Object> get props => [ticks];
}

class StopwatchLapAdded extends StopwatchEvent {
  const StopwatchLapAdded();
}
