class AppLocalizations {
  static String createTimerScreenTitle = 'Create Timer';
  static String start = 'Start';
  static String addTempo = 'Add Tempo';
  static String sets = 'Sets';
  static String addSets = 'Add sets';
  static String reps = 'Reps';
  static String addReps = 'Add Reps';
  static String rest = 'Rest';
  static String addRest = 'Add Rest';
  static String enterIntervalName = 'Enter interval name';
  static String durationInSeconds = 'Duration (seconds)';
  static String getReady = 'Get Ready';
  static String currentSet = 'Set';
  static String currentRep = 'Rep';
  static String currentProgress = 'Progress';
  static String createTimer = 'Timed';
  static String noTemposErrorTitle = 'No tempos added';
  static String noTemposErrorMessage = 'Add some tempos to start the timer';
  static String resumeTimerButton = 'Resume';
  static String pauseTimerButton = 'Pause';
  static String closeAppTitle = 'Close App';
  static String closeAppMessage = 'Are you sure you want to close the app?';
  static String close = 'Close';
  static String cancel = 'Cancel';
  static String saveTimer = 'Save Timer';
  static String timerType = 'Timer type';
  static String forTime = 'Time';
  static String forReps = 'Reps';
  static String totalTime = 'Total Time';
  static String addNameHere = 'Add name here';

  static String getLocalization(String key, String oldText, String newText) {
    return key.replaceAll(oldText, newText);
  }
}