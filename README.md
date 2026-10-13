# Kanta Slip - Modern Weighbridge Slip Management App

Kanta Slip is a modern Flutter application for managing weighbridge (धर्मकांटा) slips, credit accounts (उधार खाता), payments, and expenses.

## Features
- **Milestone 1:** App branding, dark theme, splash screen, biometric/PIN lock, floating bottom navigation bar, and Settings.
- **Milestone 2:** Manual slip creation (auto-increment receipt counter, multi-round weighments, live net weight calculations, charge chips, draft autosave) and Slip Card PDF export/printing with Devanagari font support.
- **Milestone 3:** Payment status flow (Cash, UPI, Pending, Udhar allocation), Home screen latest income card, and "Aaj Ki Income" date-filtered breakdown.
- **Milestone 4:** Instant slips search across name, vehicle number, receipt number, and date; status filters; soft delete with undo; edit audit logging; duplicate slip detection warning; and reprint duplicate copy marking.
- **Milestone 5:** Udhar credit account management with oldest-first payment allocation algorithm (tested on 40-slip scenario), Jama Rasid receipt generation and PDF export.
- **Milestone 6:** Dynamic UPI QR generation (`upi://pay?pa=...`), static QR image import, screen brightness maximization during QR display, and secure local storage.
- **Milestone 7:** Expense management (category breakdown, monthly Bachat, soft delete with Undo) and Supplier credit khata (daily entries, payments creating linked expenses, oldest-first running balance, statement PDF).
- **Milestone 8:** Earning History date-wise line graph (`fl_chart`), range chips (7d, 15d, 30d, custom month), metric toggle (Kamai/Kharcha/Bachat), dark-green comparison card with percentage change, and Indian currency notation (`1,84,500`).
- **Milestone 9:** Auto Scan OCR (camera live stream, Devanagari + English text recognition, multi-frame voting, confidence tags, auto net weight recomputation, duplicate receipt detection, and payment flow redirection).
- **Milestone 10:** Offline-first Firebase backup/sync, Cloud OCR assist, complete JSON backup export/restore, PDF summary reports, release APK build setup with ProGuard rules, GitHub Actions CI/CD workflow, and production polish.
- **Milestone 11:** Success tone (synthesized dual-note `ding.wav` chime) and Hindi spoken voice feedback (`flutter_tts`, `HindiNumberSpeaker`) for received payments and scan completions.
- **Milestone 12:** Fintech-style smooth animations (`AppMotion`), custom page route transitions, floating bottom nav pill slide/opacity, `CountUpText` amount animations, `AppScaleButton` press feedback, `StaggeredListRow` entrances, and reduced-motion / settings toggles.

## Project Setup & Environment Configuration
1. Clone the repository and install Flutter dependencies:
   ```bash
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   ```
2. **Firebase Setup:**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com/).
   - Add an Android app with Package Name `com.joshi.kantaslip`.
   - Download `google-services.json` and place it in `android/app/google-services.json` (do NOT commit this file to git).
   - Enable Firestore Database, Firebase Storage, and Firebase App Check.

3. **Keystore Generation & Release Build:**
   - To generate a production release keystore:
     ```bash
     keytool -genkey -v -keystore release.keystore -alias kanta_slip_key -keyalg RSA -keysize 2048 -validity 10000
     ```
   - **Keystore Backup Procedure:** Save `release.keystore` and its passwords in a secure password manager or encrypted offline storage. If lost, app updates cannot be published to Google Play.
   - For GitHub Actions CI/CD release APK builds, encode your keystore to Base64 and add the following repository secrets:
     - `KEYSTORE_BASE64`: Base64 string of `release.keystore` (`base64 -w 0 release.keystore`)
     - `KEYSTORE_PASSWORD`: Keystore store password
     - `KEY_ALIAS`: Key alias (e.g. `kanta_slip_key`)
     - `KEY_PASSWORD`: Key password

4. **Building Release APK:**
   ```bash
   flutter build apk --release --split-per-abi
   ```
   The generated release APK artifact will be at `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`.

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
