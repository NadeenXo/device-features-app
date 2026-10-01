import 'package:flutter/material.dart';

import '../services/audio_service.dart';

class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  State<AudioRecorderScreen> createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final AudioService _audioService = AudioService();

  bool _isRecording = false;
  bool _hasRecording = false;

  // Starts or stops voice recording depending on the current state.
  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final String? recordingPath = await _audioService.stopRecording();

      setState(() {
        _isRecording = false;
        _hasRecording = recordingPath != null;
      });

      return;
    }

    final bool started = await _audioService.startRecording();

    if (!mounted) {
      return;
    }

    if (started) {
      setState(() {
        _isRecording = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission is required.')),
      );
    }
  }

  Future<void> _playAudio() async {
    await _audioService.playRecording();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Recorder'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_isRecording ? Icons.mic : Icons.mic_none, size: 80),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleRecording,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  label: Text(_isRecording ? 'Stop Recording' : 'Record Audio'),
                ),
              ),

              const SizedBox(height: 16),

              if (_hasRecording)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _playAudio,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play Audio'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
