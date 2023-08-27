part of 'stopwatch_bloc.dart';

enum StopwatchStatus { initial, inProgress, inPause }

class StopwatchState extends Equatable {
  const StopwatchState({
    this.ticks = 0,
    this.status = StopwatchStatus.initial,
    this.laps = const <int>[],
  });

  final int ticks;
  final StopwatchStatus status;
  final List<int> laps;

  @override
  List<Object> get props => [ticks, status, laps];

  StopwatchState copyWith({
    int? ticks,
    StopwatchStatus? status,
    List<int>? laps,
  }) {
    return StopwatchState(
      ticks: ticks ?? this.ticks,
      status: status ?? this.status,
      laps: laps ?? this.laps,
    );
  }
}

extension StopwatchStatusX on StopwatchStatus {
  bool get isInitial {
    return this == StopwatchStatus.initial;
  }

  bool get inProgress {
    return this == StopwatchStatus.inProgress;
  }

  bool get inPause {
    return this == StopwatchStatus.inPause;
  }
}
