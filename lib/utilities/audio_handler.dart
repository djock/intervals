import 'package:assets_audio_player/assets_audio_player.dart';

class AudioHandler {
  static void playAudioFile(String fileName) {
    // if enabled
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/$fileName"),
      autoStart: true,
      showNotification: true,
    );
  }
  
  static void playTick() {
    playAudioFile('tick.wav');
  }

  static void playSwitch() {
    playAudioFile('ding.mp3');
  }
}