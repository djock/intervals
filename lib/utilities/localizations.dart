class AppLocalizations {
  static String createTimerScreenTitle = 'Create timer';
  static String start = 'Start';
  static String addInterval = 'Add interval';
  static String sets = 'Sets';
  static String addSets = 'Add sets';
  static String reps = 'Reps';
  static String addReps = 'Add Reps';
  static String rest = 'Rest';
  static String addRest = 'Add Rest';
  static String enterIntervalName = 'Enter interval name';
  static String durationInSeconds = 'Duration (seconds)';
  static String getReady = 'Get ready!';
  static String currentSet = 'Set';
  static String currentRep = 'Rep';
  static String currentProgress = 'Progress';
  static String createTimer = 'Create new Timer';
  static String noTemposErrorTitle = 'No intervals added';
  static String noTemposErrorMessage = 'Add intervals tempos to start the timer';
  static String resumeTimerButton = 'Resume';
  static String pauseTimerButton = 'Pause';
  static String closeAppTitle = 'Close app';
  static String closeAppMessage = 'Are you sure you want to close the app?';
  static String close = 'Close';
  static String cancel = 'Cancel';
  static String saveTimer = 'Save';
  static String timerType = 'Timer type';
  static String forTime = 'Time';
  static String forReps = 'Reps';
  static String totalTime = 'Total time';
  static String addNameHere = 'Add name here';
  static String addTimerName = 'Please add a name for the timer';
  static String saveInterval = 'Save interval';
  static String progress = 'Progress';
  static String timersScreenTitle = 'My timers';
  static String noTimers = 'No saved timers, tap on the + icon to create one';
  static String intervals = 'Intervals';
  static String setsReps = 'Sets x Reps';
  static String target = 'Target';
  static String timerInfo = 'Timer info';

  static String getLocalization(String key, String oldText, String newText) {
    return key.replaceAll(oldText, newText);
  }
}