import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/theme/app_colors.dart';

class LockScreen extends StatefulWidget {
  final VoidCallback onUnlocked;

  const LockScreen({super.key, required this.onUnlocked});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController _pinController = TextEditingController();
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool isDeviceSupported = await _auth.isDeviceSupported();

      if (canAuthenticateWithBiometrics && isDeviceSupported) {
        final bool authenticated = await _auth.authenticate(
          localizedReason: 'Kanta Slip unlock karne ke liye fingerprint lagayein',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (authenticated) {
          widget.onUnlocked();
        }
      }
    } catch (_) {
      // Biometrics failed or not available, fallback to PIN
    }
  }

  Future<void> _verifyPin() async {
    final savedPin = await _storage.read(key: 'user_pin') ?? '1234';
    if (_pinController.text == savedPin) {
      widget.onUnlocked();
    } else {
      setState(() {
        _errorText = 'Galat PIN, phir se koshish karein';
      });
      await Future.delayed(const Duration(milliseconds: 500));
      _pinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Image.asset('assets/branding/app_icon_dark.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Kanta Slip Security',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'PIN ya Fingerprint se unlock karein',
                style: TextStyle(color: AppColors.muted, fontSize: 14),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 24,
                  letterSpacing: 8,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.surface,
                  hintText: 'PIN',
                  hintStyle: const TextStyle(color: AppColors.muted, letterSpacing: 0, fontSize: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.lime, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                  ),
                ),
                onSubmitted: (_) => _verifyPin(),
              ),
              if (_errorText.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(_errorText, style: const TextStyle(color: AppColors.danger, fontSize: 13)),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _verifyPin,
                child: const Text('Unlock'),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: _checkBiometrics,
                icon: const Icon(Icons.fingerprint, color: AppColors.lime),
                label: const Text('Fingerprint', style: TextStyle(color: AppColors.lime)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
