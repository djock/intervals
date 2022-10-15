import 'package:assets_audio_player/assets_audio_player.dart';

class AudioHandler {
  static void playAudioFile(String fileName) {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/$fileName"),
      autoStart: true,
      showNotification: false,
      volume: 1.0,
    );
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