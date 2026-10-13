import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration base = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration bottomNav = Duration(milliseconds: 350);
  static const Duration countUp = Duration(milliseconds: 700);

  static const Curve easeOutCubic = Curves.easeOutCubic;
  static const Curve easeOutBack = Curves.easeOutBack;
  static const Curve easeInOut = Curves.easeInOut;

  static const _storage = FlutterSecureStorage();
  static const _key = 'setting_animations_enabled';

  static bool _animationsSetting = true;

  static Future<void> init() async {
    try {
      final val = await _storage.read(key: _key);
      _animationsSetting = (val != 'false');
    } catch (_) {
      _animationsSetting = true;
    }
  }

  static bool get animationsSetting => _animationsSetting;

  static Future<void> setAnimationsSetting(bool value) async {
    _animationsSetting = value;
    try {
      await _storage.write(key: _key, value: value.toString());
    } catch (_) {}
  }

  static bool isAnimationsEnabled(BuildContext context) {
    if (!_animationsSetting) return false;
    return !MediaQuery.of(context).disableAnimations;
  }
}
