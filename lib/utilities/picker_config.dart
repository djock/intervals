class PickerConfig {
  final int min;
  final int max;
  final int step;

  PickerConfig(this.min, this.max, this.step);

  static PickerConfig get totalTime => PickerConfig(0, 300, 5);
  static PickerConfig get sets => PickerConfig(1, 100, 1);
  static PickerConfig get interval => PickerConfig(0, 960, 1);
}