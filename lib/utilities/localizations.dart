import 'dart:math';

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
  static String noTemposErrorMessage = 'Add intervals to create a timer';
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
  static String timerName = 'Timer name';
  static String intervalName = 'Interval Name';
  static String addTimerName = 'Please add a name for the timer';
  static String saveInterval = 'Save interval';
  static String progress = 'Progress';
  static String timersScreenTitle = 'My timers';
  static String noTimers = 'No saved timers, tap on the + icon to create one';
  static String noActivities = 'No activities';
  static String intervals = 'Intervals';
  static String setsReps = 'Sets x Reps';
  static String target = 'Target';
  static String timerInfo = 'Timer info';
  static String editTimer = 'Edit timer';
  static String updateTimer = 'Update';
  static String tapToStart = 'Tap to start';
  static String tapToPause = 'Tap to pause';
  static String wellDone = 'Well Done!';
  static String tapToClose = 'Tap to close';
  static String youHaveCompleted = 'Finished: {TIMER_NAME}';
  static String activities = 'Activities';
  static String done = 'Done';

  static List<String> timerEndedCongrats = ['Congrats!', 'Well done!', 'Great job!'];

  static String getLocalization(String key, String oldText, String newText) {
    return key.replaceAll(oldText, newText);
  }

  static String getCongrats() {
    return timerEndedCongrats[(timerEndedCongrats.length * Random().nextDouble()).floor()];
  }
}