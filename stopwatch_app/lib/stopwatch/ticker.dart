/// {@template ticker}
/// Ticker class that exposes a stream of ticks.
/// {@endtemplate}
class Ticker {
  /// {@macro ticker}
  const Ticker();

  /// Return the stream of ticks.
  Stream<int> tick() =>
      Stream<int>.periodic(const Duration(seconds: 1), (tick) => tick);
}
