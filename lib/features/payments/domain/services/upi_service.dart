import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpiService {
  static const _storage = FlutterSecureStorage();
  static const _upiIdKey = 'upi_id';
  static const _upiQrImageKey = 'upi_qr_image_path';
  static const _upiQrEnabledKey = 'upi_qr_enabled';

  /// Build standard UPI URI for dynamic QR generation
  static String buildUpiUri({
    required String upiId,
    required String payeeName,
    required double amount,
    required String note,
  }) {
    final cleanId = upiId.trim();
    final cleanName = Uri.encodeComponent(payeeName.trim());
    final cleanNote = Uri.encodeComponent(note.trim());
    final amtStr = amount.toStringAsFixed(2);

    return 'upi://pay?pa=$cleanId&pn=$cleanName&am=$amtStr&tn=$cleanNote';
  }

  /// Save UPI ID securely
  static Future<void> saveUpiId(String upiId) async {
    await _storage.write(key: _upiIdKey, value: upiId.trim());
  }

  /// Get stored UPI ID
  static Future<String?> getUpiId() async {
    return _storage.read(key: _upiIdKey);
  }

  /// Save static QR image path securely
  static Future<void> saveQrImagePath(String path) async {
    await _storage.write(key: _upiQrImageKey, value: path);
  }

  /// Get stored static QR image path
  static Future<String?> getQrImagePath() async {
    return _storage.read(key: _upiQrImageKey);
  }

  /// Save UPI QR enabled status
  static Future<void> setUpiQrEnabled(bool enabled) async {
    await _storage.write(key: _upiQrEnabledKey, value: enabled ? '1' : '0');
  }

  /// Check if UPI QR is enabled
  static Future<bool> isUpiQrEnabled() async {
    final val = await _storage.read(key: _upiQrEnabledKey);
    return val != '0'; // Default to true if not explicitly set
  }
}
