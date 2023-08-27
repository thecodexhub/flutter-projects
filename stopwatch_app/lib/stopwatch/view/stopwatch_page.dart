import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch_app/stopwatch/stopwatch.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchBloc>(
      create: (context) => StopwatchBloc(),
      child: const _StopwatchView(),
    );
  }
}

class _StopwatchView extends StatelessWidget {
  const _StopwatchView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Center(child: _StopwatchText()),
            SizedBox(height: 24),
            Expanded(child: _StopwatchLapList()),
          ],
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: _StopwatchActionButtons(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _StopwatchText extends StatelessWidget {
  const _StopwatchText();

  @override
  Widget build(BuildContext context) {
    final totalTicks = context.select((StopwatchBloc bloc) => bloc.state.ticks);
    final hoursStr = '${(totalTicks / 3600).floor()}'.padLeft(2, '0');
    final minutesStr = '${((totalTicks / 60) % 60).floor()}'.padLeft(2, '0');
    final secondsStr = '${(totalTicks % 60).floor()}'.padLeft(2, '0');

    return Text(
      '$hoursStr:$minutesStr:$secondsStr',
      style: const TextStyle(
        fontSize: 64,
        color: Colors.white60,
      ),
    );
  }
}

class _StopwatchActionButtons extends StatelessWidget {
  const _StopwatchActionButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchBloc, StopwatchState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isInitial) {
          return FloatingActionButton.extended(
            key: const Key('stopwatchInitial_startButton'),
            onPressed: () => context.read<StopwatchBloc>().add(
                  const StopwatchStarted(),
                ),
            label: Row(
              children: const [
                Icon(Icons.play_arrow),
                SizedBox(width: 4),
                Text('Start stopwatch'),
              ],
            ),
          );
        }

        if (state.status.inProgress) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.small(
                key: const Key('stopwatchInProgress_resetButton'),
                onPressed: () => context.read<StopwatchBloc>().add(
                      const StopwatchReset(),
                    ),
                child: const Icon(Icons.rotate_left),
              ),
              FloatingActionButton.extended(
                key: const Key('stopwatchInProgress_pauseButton'),
                onPressed: () => context.read<StopwatchBloc>().add(
                      const StopwatchPaused(),
                    ),
                label: Row(
                  children: const [
                    Icon(Icons.pause),
                    SizedBox(width: 4),
                    Text('Pause stopwatch'),
                  ],
                ),
              ),
              FloatingActionButton.small(
                key: const Key('stopwatchInProgress_lapCreateButton'),
                onPressed: () => context.read<StopwatchBloc>().add(
                      const StopwatchLapAdded(),
                    ),
                child: const Icon(Icons.timer_outlined),
              ),
            ],
          );
        }

        if (state.status.inPause) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.small(
                key: const Key('stopwatchInPause_resetButton'),
                onPressed: () => context.read<StopwatchBloc>().add(
                      const StopwatchReset(),
                    ),
                child: const Icon(Icons.rotate_left),
              ),
              FloatingActionButton.extended(
                key: const Key('stopwatchInPause_resumeButton'),
                onPressed: () => context.read<StopwatchBloc>().add(
                      const StopwatchResumed(),
                    ),
                label: Row(
                  children: const [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 4),
                    Text('Resume stopwatch'),
                  ],
                ),
              ),
              const Opacity(
                opacity: 0,
                child: FloatingActionButton.small(
                  key: Key('stopwatchInPause_placeholderButton'),
                  onPressed: null,
                  child: Icon(Icons.rotate_left),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}

class _StopwatchLapList extends StatelessWidget {
  const _StopwatchLapList();

  @override
  Widget build(BuildContext context) {
    final laps = context.select((StopwatchBloc bloc) => bloc.state.laps);

    return ListView.separated(
      itemCount: laps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final totalTicks = laps[index];
        final hh = '${(totalTicks / 3600).floor()}'.padLeft(2, '0');
        final mm = '${((totalTicks / 60) % 60).floor()}'.padLeft(2, '0');
        final ss = '${(totalTicks % 60).floor()}'.padLeft(2, '0');

        return Text(
          '#${index + 1}      $hh:$mm:$ss',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white60,
          ),
        );
      },
    );
  }
}
