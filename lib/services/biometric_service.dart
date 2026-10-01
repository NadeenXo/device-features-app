import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  // Prompts the user for biometric authentication.
  Future<bool> authenticate() async {
    try {
      final bool canUseBiometrics =
          await _localAuthentication.canCheckBiometrics;

      final bool isSupported =
          await _localAuthentication.isDeviceSupported();

      if (!canUseBiometrics || !isSupported) {
        return false;
      }

      return await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to open your profile',
        biometricOnly: true,
      );
    } catch (_) {
      return false;
    }
  }
}