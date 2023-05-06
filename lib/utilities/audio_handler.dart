import 'package:assets_audio_player/assets_audio_player.dart';

class AudioHandler {
  static final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  static void playAudioFile(String fileName) {
    _assetsAudioPlayer.open(
      Audio("assets/$fileName"),
      autoStart: true,
      showNotification: false,
      volume: 1.0,
      audioFocusStrategy: AudioFocusStrategy.request(
        resumeAfterInterruption: true,
        resumeOthersPlayersAfterDone: true,
      ),
    );
  }

  static void stopAudioFile() {
    _assetsAudioPlayer.stop();
  }

  static void playTick() {
    playAudioFile('tick.mp3');
  }

  static void playSwitch() {
    playAudioFile('ding.mp3');
  }

  static void playTimerEnd() {
    playAudioFile('end.wav');
  }
}
