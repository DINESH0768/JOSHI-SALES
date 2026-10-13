import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/audio_feedback_service.dart';
import '../../../core/services/data_export_service.dart';
import '../../../core/services/firebase_sync_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../payments/domain/services/upi_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppDatabase _db;
  bool _upiQrEnabled = true;
  bool _appLockEnabled = true;
  String? _upiId;
  String? _qrImagePath;
  String _backupStatus = 'Checking...';
  bool _isSyncing = false;
  bool _successToneEnabled = true;
  bool _voiceSpeechEnabled = true;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final upiId = await UpiService.getUpiId();
    final qrPath = await UpiService.getQrImagePath();
    final enabled = await UpiService.isUpiQrEnabled();
    final status = await FirebaseSyncService.getLastSyncedStatus();
    final toneOn = await AudioFeedbackService.instance.isToneEnabled();
    final voiceOn = await AudioFeedbackService.instance.isVoiceEnabled();

    if (mounted) {
      setState(() {
        _upiId = upiId;
        _qrImagePath = qrPath;
        _upiQrEnabled = enabled;
        _backupStatus = status;
        _successToneEnabled = toneOn;
        _voiceSpeechEnabled = voiceOn;
      });
    }
  }

  Future<void> _runBackup() async {
    setState(() => _isSyncing = true);
    final success = await FirebaseSyncService.syncAll(_db);
    final status = await FirebaseSyncService.getLastSyncedStatus();

    if (mounted) {
      setState(() {
        _isSyncing = false;
        _backupStatus = status;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Backup poora ho gaya!' : 'Sync offline mode mein save ho gaya'),
          backgroundColor: AppColors.surface,
        ),
      );
    }
  }

  Future<void> _editUpiIdDialog() async {
    final controller = TextEditingController(text: _upiId ?? '');
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('UPI ID set karein', style: TextStyle(color: AppColors.text, fontSize: 16)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: AppColors.text),
            decoration: const InputDecoration(
              hintText: 'उदा. 9214848519@upi',
              hintStyle: TextStyle(color: AppColors.muted),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.muted)),
            ),
            TextButton(
              onPressed: () async {
                final id = controller.text.trim();
                await UpiService.saveUpiId(id);
                setState(() => _upiId = id);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _importQrImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      await UpiService.saveQrImagePath(file.path);
      if (mounted) {
        setState(() => _qrImagePath = file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR image import ho gayi!')),
        );
      }
    }
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.chevron_left_rounded,
          color: AppColors.text,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSwitch({required bool value, required ValueChanged<bool> onChanged}) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 36,
        height: 20,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? AppColors.lime : AppColors.surface3,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? AppColors.onLime : AppColors.muted,
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    bool showBorder = true,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: showBorder
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.border,
                    width: 0.5,
                    style: BorderStyle.solid,
                  ),
                ),
              )
            : null,
        child: Row(
          children: [
            // Row Icon Container (.ic)
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.surface3,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 16,
                color: AppColors.text,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.muted,
                  size: 18,
                ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final upiSubtitle = _upiId != null && _upiId!.isNotEmpty
        ? 'ID: $_upiId'
        : (_qrImagePath != null ? 'Static QR imported' : 'QR dikhana on/off');

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header (.hd)
              Row(
                children: [
                  _buildBackButton(context),
                  const SizedBox(width: 10),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Shop details card (.card)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/branding/app_icon_dark.png'),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'जोशी कम्प्यूटराइज धर्मकांटा',
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'रावतसर (राज.) · 60 टन',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Section 1 (.s2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _buildRow(
                      icon: Icons.person_outline_rounded,
                      title: 'Shop details',
                      subtitle: 'Naam, address, phone',
                    ),
                    _buildRow(
                      icon: Icons.draw_outlined,
                      title: 'Signature',
                      subtitle: 'Kanta incharge ka signature',
                    ),
                    _buildRow(
                      icon: Icons.qr_code_2_rounded,
                      title: 'UPI QR / UPI ID',
                      subtitle: upiSubtitle,
                      onTap: _editUpiIdDialog,
                      trailing: _buildSwitch(
                        value: _upiQrEnabled,
                        onChanged: (val) async {
                          setState(() => _upiQrEnabled = val);
                          await UpiService.setUpiQrEnabled(val);
                        },
                      ),
                    ),
                    _buildRow(
                      icon: Icons.image_outlined,
                      title: 'Import static QR Image',
                      subtitle: _qrImagePath != null ? 'Gallery/Camera image set' : 'Gallery se QR image chuno',
                      onTap: _importQrImage,
                    ),
                    _buildRow(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Materials aur kharcha categories',
                      subtitle: 'Aapke chips',
                      showBorder: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Section 2 (.s2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _buildRow(
                      icon: Icons.volume_up_outlined,
                      title: 'Success tone',
                      subtitle: 'Payment/scan par ti-ting tone',
                      trailing: _buildSwitch(
                        value: _successToneEnabled,
                        onChanged: (val) async {
                          setState(() => _successToneEnabled = val);
                          await AudioFeedbackService.instance.setToneEnabled(val);
                        },
                      ),
                    ),
                    _buildRow(
                      icon: Icons.record_voice_over_outlined,
                      title: 'Bolkar batao (voice)',
                      subtitle: 'Hindi TTS aawaz (500 rupaye mile)',
                      trailing: _buildSwitch(
                        value: _voiceSpeechEnabled,
                        onChanged: (val) async {
                          setState(() => _voiceSpeechEnabled = val);
                          await AudioFeedbackService.instance.setVoiceEnabled(val);
                        },
                      ),
                    ),
                    _buildRow(
                      icon: Icons.lock_outline_rounded,
                      title: 'App lock',
                      subtitle: 'Fingerprint / PIN',
                      trailing: _buildSwitch(
                        value: _appLockEnabled,
                        onChanged: (val) => setState(() => _appLockEnabled = val),
                      ),
                    ),
                    _buildRow(
                      icon: Icons.cloud_outlined,
                      title: 'Backup status',
                      subtitle: 'Aakhri backup: $_backupStatus',
                      onTap: _runBackup,
                    ),
                    _buildRow(
                      icon: Icons.description_outlined,
                      title: 'Export & Report',
                      subtitle: 'PDF Report / JSON Backup',
                      onTap: () async {
                        await DataExportService.exportPdfSummaryReport(_db);
                      },
                      showBorder: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Button: Abhi backup lo (.btn .bd)
              GestureDetector(
                onTap: _isSyncing ? null : _runBackup,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface3,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: _isSyncing
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: AppColors.lime, strokeWidth: 2))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_outlined,
                              color: AppColors.text,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Abhi backup lo',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),

              // TTS Hint Notice
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: const Text(
                  'Hindi awaaz ke liye phone ki Text-to-speech settings mein Hindi voice install karo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Version label (.m)
              const Text(
                'Kanta Slip v1.0.0+1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
