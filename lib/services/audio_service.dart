import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _recordedFilePath;

  String? get recordedFilePath => _recordedFilePath;

  // Checks microphone permission and starts recording to a local file.
  Future<bool> startRecording() async {
    final bool hasPermission = await _audioRecorder.hasPermission();

    if (!hasPermission) {
      return false;
    }

    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/voice_recording.m4a';

    await _audioRecorder.start(
      const RecordConfig(),
      path: filePath,
    );

    return true;
  }

  // Stops the active recording and stores the generated audio file path.
  Future<String?> stopRecording() async {
    _recordedFilePath = await _audioRecorder.stop();
    return _recordedFilePath;
  }

  // Plays the most recently recorded audio file.
  Future<void> playRecording() async {
    if (_recordedFilePath == null) {
      return;
    }

    await _audioPlayer.play(
      DeviceFileSource(_recordedFilePath!),
    );
  }

  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
  }
}