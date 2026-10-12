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
      // Biometrics fallback
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
    String? savedPin;
    try {
      savedPin = await _storage.read(key: 'user_pin');
    } catch (_) {}
    savedPin ??= '1234';

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

  Widget _buildKeypadButton({String? text, VoidCallback? onTap, Widget? icon}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? (text != null ? () => _onKeyPress(text) : null),
        borderRadius: BorderRadius.circular(29),
        child: Container(
          width: 58,
          height: 58,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.surface2,
            shape: BoxShape.circle,
          ),
          child: icon ??
              Text(
                text ?? '',
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Icon Square
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('assets/branding/app_icon_dark.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kanta Slip lock',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'PIN daalo ya fingerprint lagao',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 22),

                // PIN dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final isFilled = index < _enteredPin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled ? AppColors.lime : Colors.transparent,
                        border: Border.all(
                          color: isFilled ? AppColors.lime : const Color(0xFF3A3A3F),
                          width: 1.5,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 12),
                SizedBox(
                  height: 18,
                  child: _errorText.isNotEmpty
                      ? Text(
                          _errorText,
                          style: const TextStyle(color: AppColors.danger, fontSize: 12),
                        )
                      : null,
                ),

                const SizedBox(height: 14),

                // Keypad Grid 3x4
                SizedBox(
                  width: 240,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildKeypadButton(text: '1'),
                          _buildKeypadButton(text: '2'),
                          _buildKeypadButton(text: '3'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildKeypadButton(text: '4'),
                          _buildKeypadButton(text: '5'),
                          _buildKeypadButton(text: '6'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildKeypadButton(text: '7'),
                          _buildKeypadButton(text: '8'),
                          _buildKeypadButton(text: '9'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildKeypadButton(
                            onTap: _checkBiometrics,
                            icon: const Icon(
                              Icons.fingerprint_rounded,
                              color: AppColors.lime,
                              size: 22,
                            ),
                          ),
                          _buildKeypadButton(text: '0'),
                          _buildKeypadButton(
                            onTap: _onBackspace,
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              color: AppColors.text,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
