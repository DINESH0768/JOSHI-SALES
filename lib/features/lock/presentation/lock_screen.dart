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
  String _enteredPin = '';
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
      // Biometrics fallback to PIN
    }
  }

  Future<void> _onKeyPress(String val) async {
    if (_enteredPin.length < 4) {
      setState(() {
        _errorText = '';
        _enteredPin += val;
      });

      if (_enteredPin.length == 4) {
        await _verifyPin();
      }
    }
  }

  void _onBackspace() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _errorText = '';
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  Future<void> _verifyPin() async {
    final savedPin = await _storage.read(key: 'user_pin') ?? '1234';
    if (_enteredPin == savedPin) {
      widget.onUnlocked();
    } else {
      setState(() {
        _errorText = 'Galat PIN, phir se koshish karein';
      });
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _enteredPin = '';
        });
      }
    }
  }

  Widget _buildKeypadButton(String text, {VoidCallback? onTap, Widget? icon}) {
    return InkWell(
      onTap: onTap ?? () => _onKeyPress(text),
      borderRadius: BorderRadius.circular(36),
      child: Container(
        width: 68,
        height: 68,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.surface2,
          shape: BoxShape.circle,
        ),
        child: icon ??
            Text(
              text,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
    );
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
              const Spacer(),
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

              // PIN dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < _enteredPin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? AppColors.lime : AppColors.surface3,
                      border: Border.all(
                        color: isFilled ? AppColors.lime : AppColors.border,
                        width: 1,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),
              SizedBox(
                height: 20,
                child: _errorText.isNotEmpty
                    ? Text(_errorText, style: const TextStyle(color: AppColors.danger, fontSize: 13))
                    : null,
              ),

              const Spacer(),

              // Numeric Keypad (1-9, 0, backspace, fingerprint)
              SizedBox(
                width: 260,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKeypadButton('1'),
                        _buildKeypadButton('2'),
                        _buildKeypadButton('3'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKeypadButton('4'),
                        _buildKeypadButton('5'),
                        _buildKeypadButton('6'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKeypadButton('7'),
                        _buildKeypadButton('8'),
                        _buildKeypadButton('9'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildKeypadButton(
                          '',
                          onTap: _checkBiometrics,
                          icon: const Icon(Icons.fingerprint, color: AppColors.lime, size: 28),
                        ),
                        _buildKeypadButton('0'),
                        _buildKeypadButton(
                          '',
                          onTap: _onBackspace,
                          icon: const Icon(Icons.backspace_outlined, color: AppColors.text, size: 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
