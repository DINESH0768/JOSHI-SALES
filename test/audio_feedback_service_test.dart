import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanta_slip/core/services/audio_feedback_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  test('AudioFeedbackService enables tone and voice settings by default and allows toggling', () async {
    final service = AudioFeedbackService.instance;

    expect(await service.isToneEnabled(), isTrue);
    expect(await service.isVoiceEnabled(), isTrue);

    await service.setToneEnabled(false);
    expect(await service.isToneEnabled(), isFalse);

    await service.setVoiceEnabled(false);
    expect(await service.isVoiceEnabled(), isFalse);

    await service.setToneEnabled(true);
    await service.setVoiceEnabled(true);
  });
}
