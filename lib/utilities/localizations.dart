class AppLocalizations {
  static String timerSettingsScreenTitle = 'Create Timer';
  static String start = 'Start';
  static String addTempo = 'Add Tempo';
  static String sets = 'Sets';
  static String addSets = 'Add sets';
  static String reps = 'Reps';
  static String addReps = 'Add Reps';
  static String rest = 'Rest';
  static String addRest = 'Add Rest';
  static String tempoNamePlaceholder = 'Enter tempo name';
  static String durationInSeconds = 'Duration (seconds)';
  static String getReady = 'Get Ready';
  static String currentSet = 'Set: {AMOUNT}';
  static String currentRep = 'Rep: {AMOUNT}';
  static String currentProgress = 'Progress: {AMOUNT}';
  static String createTimer = 'Timed';

  static String getLocalization(String key, String oldText, String newText) {
    return key.replaceAll(oldText, newText);
  }
}