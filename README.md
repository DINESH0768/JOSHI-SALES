# Kanta Slip - Modern Weighbridge Slip Management App

Kanta Slip is a modern Flutter application for managing weighbridge (धर्मकांटा) slips, credit accounts (उधार खाता), payments, and expenses.

## Features
- **Milestone 1:** App branding, dark theme, splash screen, biometric/PIN lock, floating bottom navigation bar, and Settings.
- **Milestone 2:** Manual slip creation (auto-increment receipt counter, multi-round weighments, live net weight calculations, charge chips, draft autosave) and Slip Card PDF export/printing with Devanagari font support.
- **Milestone 3:** Payment status flow (Cash, UPI, Pending, Udhar allocation), Home screen latest income card, and "Aaj Ki Income" date-filtered breakdown.
- **Milestone 4:** Instant slips search across name, vehicle number, receipt number, and date; status filters; soft delete with undo; edit audit logging; duplicate slip detection warning; and reprint duplicate copy marking.
- **Milestone 5:** Udhar credit account management with oldest-first payment allocation algorithm (tested on 40-slip scenario), Jama Rasid receipt generation and PDF export.
- **Milestone 6:** Dynamic UPI QR generation (`upi://pay?pa=...`), static QR image import, screen brightness maximization during QR display, and secure local storage.

## Setting up UPI QR & UPI ID
To configure UPI payments:
1. Open the app and navigate to **Settings** (icon on top left or via router `/settings`).
2. Tap **UPI QR / UPI ID** to enter your shop's UPI ID (e.g. `9214848519@upi`). This ID is stored securely on device via `flutter_secure_storage`.
3. To import a static QR image from gallery or camera, tap **Import static QR Image**. The image is stored privately on device local storage and never committed to version control.
4. When a UPI payment is initiated, the app dynamically generates a UPI QR code (`upi://pay?pa=<id>&pn=<name>&am=<amount>&tn=<slipNo>`) if an ID is present, or displays the imported static image.

## Testing & Verification
Run static analysis and full unit/widget test suite:
```bash
flutter analyze
flutter test
```
