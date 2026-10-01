import 'package:device_features_app/widges/feature_card.dart';
import 'package:flutter/material.dart';

import '../services/biometric_service.dart';
import 'audio_recorder_screen.dart';
import 'device_info_screen.dart';
import 'google_map_screen.dart';
import 'image_gallery_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final BiometricService _biometricService = BiometricService();

  // Opens the profile only after successful biometric authentication.
  Future<void> _openProfile(BuildContext context) async {
    final bool authenticated = await _biometricService.authenticate();

    if (!context.mounted) {
      return;
    }

    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biometric authentication failed.')),
      );
    }
  }

  void _openScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Features'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _openProfile(context),
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Device Features App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore native device capabilities.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 28),

            FeatureCard(
              title: 'Device Info',
              subtitle: 'View device model and OS version',
              icon: Icons.phone_android,
              onTap: () => _openScreen(context, const DeviceInfoScreen()),
            ),

            FeatureCard(
              title: 'Image Gallery',
              subtitle: 'Pick multiple images from your gallery',
              icon: Icons.photo_library,
              onTap: () => _openScreen(context, const ImageGalleryScreen()),
            ),

            FeatureCard(
              title: 'Google Map',
              subtitle: 'View Cairo on Google Maps',
              icon: Icons.map,
              onTap: () => _openScreen(context, const GoogleMapScreen()),
            ),

            FeatureCard(
              title: 'Audio Recorder',
              subtitle: 'Record and play back your voice',
              icon: Icons.mic,
              onTap: () => _openScreen(context, const AudioRecorderScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
