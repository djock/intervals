class TimerConfig {
  final int sets;
  final int reps;
  final int time;
  final Map config;

  TimerConfig(this.sets, this.reps, this.time, this.config);

  // 3 sets
  // 8 reps
  // {concentric, 4}
  // {hold, 2}
  // {eccentric, 4}
  // {hold, 0}
}