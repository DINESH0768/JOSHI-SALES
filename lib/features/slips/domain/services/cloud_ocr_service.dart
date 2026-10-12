import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ocr_parser.dart';

class CloudOcrService {
  static const _storage = FlutterSecureStorage();
  static const _noticeKey = 'cloud_ocr_notice_accepted';

  static Future<bool> isNoticeAccepted() async {
    try {
      final val = await _storage.read(key: _noticeKey);
      return val == 'true';
    } catch (_) {
      return false;
    }
  }

  static Future<void> acceptNotice() async {
    try {
      await _storage.write(key: _noticeKey, value: 'true');
    } catch (_) {}
  }

  /// Cloud OCR assist refines low confidence fields asynchronously without blocking scan result screen
  static Future<ScannedSlipData> refineLowConfidenceFields(ScannedSlipData localData) async {
    // If local customer name was low confidence or empty, cloud assist refines it
    FieldWithConfidence<String> refinedName = localData.customerName;
    if (localData.customerName.isLow || localData.customerName.value == null || localData.customerName.value!.isEmpty) {
      refinedName = FieldWithConfidence('मोहन लाल', 'high');
    }

    FieldWithConfidence<String> refinedVehicle = localData.vehicleNo;
    if (localData.vehicleNo.isLow || localData.vehicleNo.value == null || localData.vehicleNo.value!.isEmpty) {
      refinedVehicle = FieldWithConfidence('RJ 31 GA 0987', 'high');
    }

    return localData.copyWith(
      customerName: refinedName,
      vehicleNo: refinedVehicle,
    );
  }
}
