import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'hindi_number_speaker.dart';

class AudioFeedbackService {
  static final AudioFeedbackService instance = AudioFeedbackService._internal();

  AudioFeedbackService._internal();

  factory AudioFeedbackService() => instance;

  static const _storage = FlutterSecureStorage();
  static const _toneKey = 'setting_success_tone';
  static const _voiceKey = 'setting_voice_speech';
  static const _soundPath = 'sounds/ding.wav';

  AudioPlayer? _player;
  FlutterTts? _tts;
  bool _isTtsInitialized = false;

  Future<void> _initTts() async {
    if (_isTtsInitialized) return;
    try {
      _tts = FlutterTts();
      await _tts!.setLanguage('hi-IN');
      await _tts!.setSpeechRate(0.45);
      await _tts!.setVolume(1.0);
      _isTtsInitialized = true;
    } catch (e) {
      if (kDebugMode) print('TTS Init Error: $e');
    }
  }

  Future<bool> isToneEnabled() async {
    try {
      final val = await _storage.read(key: _toneKey);
      return val != 'false'; // Default ON
    } catch (_) {
      return true;
    }
  }

  Future<bool> isVoiceEnabled() async {
    try {
      final val = await _storage.read(key: _voiceKey);
      return val != 'false'; // Default ON
    } catch (_) {
      return true;
    }
  }

  Future<void> setToneEnabled(bool value) async {
    try {
      await _storage.write(key: _toneKey, value: value.toString());
    } catch (_) {}
  }

  Future<void> setVoiceEnabled(bool value) async {
    try {
      await _storage.write(key: _voiceKey, value: value.toString());
    } catch (_) {}
  }

  Future<void> playTone() async {
    try {
      HapticFeedback.mediumImpact();
      final toneOn = await isToneEnabled();
      if (!toneOn) return;

      _player ??= AudioPlayer();
      await _player!.stop();
      await _player!.play(AssetSource(_soundPath));
    } catch (e) {
      if (kDebugMode) print('Audio play error: $e');
    }
  }

  Future<void> speak(String text) async {
    try {
      final voiceOn = await isVoiceEnabled();
      if (!voiceOn) return;

      await _initTts();
      if (_tts != null) {
        await _tts!.speak(text);
      }
    } catch (e) {
      if (kDebugMode) print('TTS speak error: $e');
    }
  }

  Future<void> playPaymentSuccess({
    required int amount,
    required String mode, // 'cash', 'upi', 'udhar_jama'
  }) async {
    await playTone();

    final spokenAmount = HindiNumberSpeaker.convertAmountToWords(amount);
    String phrase;
    if (mode == 'cash') {
      phrase = '$spokenAmount rupaye cash mein mile';
    } else if (mode == 'upi') {
      phrase = '$spokenAmount rupaye UPI se mile';
    } else if (mode == 'udhar_jama') {
      phrase = '$spokenAmount rupaye jama hue';
    } else {
      phrase = '$spokenAmount rupaye mile';
    }

    await speak(phrase);
  }

  Future<void> playScanSuccess() async {
    await playTone();
    await speak('Slip mil gayi');
  }
}
