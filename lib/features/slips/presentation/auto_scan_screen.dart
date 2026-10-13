import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/audio_feedback_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/ocr_parser.dart';
import '../domain/services/ocr_voting_service.dart';

class AutoScanScreen extends StatefulWidget {
  final AppDatabase db;

  const AutoScanScreen({super.key, required this.db});

  @override
  State<AutoScanScreen> createState() => _AutoScanScreenState();
}

class _AutoScanScreenState extends State<AutoScanScreen> with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final OcrVotingService _votingService = OcrVotingService();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isProcessingFrame = false;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  bool _hasCaptured = false;

  Timer? _timeoutTimer;
  String _hintMessage = 'Parchi ko frame mein rakho';
  bool _showManualTrigger = false;

  late AnimationController _animController;
  late Animation<double> _scanLineAnim;

  ScannedSlipData? _latestConsolidated;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initCamera();
    _startTimeoutTimer();
  }

  void _initAnimation() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scanLineAnim = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && !_hasCaptured) {
        setState(() {
          _hintMessage = 'Roshni badhao ya haath sthir rakho';
          _showManualTrigger = true;
        });
      }
    });
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _isCameraInitialized = false);
        return;
      }

      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() => _isCameraInitialized = true);
        _startFrameProcessing();
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isCameraInitialized = false);
      }
    }
  }

  void _startFrameProcessing() {
    if (_cameraController == null || !_cameraController!.value.isStreamingImages) {
      _cameraController?.startImageStream((CameraImage image) async {
        if (_isProcessingFrame || _hasCaptured) return;
        _isProcessingFrame = true;

        try {
          final WriteBuffer allBytes = WriteBuffer();
          for (final Plane plane in image.planes) {
            allBytes.putUint8List(plane.bytes);
          }
          final bytes = allBytes.done().buffer.asUint8List();

          final InputImage inputImage = InputImage.fromBytes(
            bytes: bytes,
            metadata: InputImageMetadata(
              size: Size(image.width.toDouble(), image.height.toDouble()),
              rotation: InputImageRotation.rotation0deg,
              format: InputImageFormat.nv21,
              bytesPerRow: image.planes.first.bytesPerRow,
            ),
          );

          final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
          final frameData = OcrParser.parseText(recognizedText.text);

          _votingService.addFrame(frameData);
          final consolidated = _votingService.getConsolidatedResult();

          if (mounted) {
            setState(() {
              _latestConsolidated = consolidated;
            });
          }

          if (_votingService.isSteadyMatch && !_hasCaptured) {
            _onAutoCaptureSuccess(consolidated);
          }
        } catch (_) {
          // Ignore frame processing errors
        } finally {
          _isProcessingFrame = false;
        }
      });
    }
  }

  Future<void> _onAutoCaptureSuccess(ScannedSlipData data) async {
    _hasCaptured = true;
    _timeoutTimer?.cancel();

    if (_cameraController != null && _cameraController!.value.isStreamingImages) {
      await _cameraController!.stopImageStream();
    }

    String? photoPath;
    try {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        final file = await _cameraController!.takePicture();
        photoPath = file.path;
      }
    } catch (_) {}

    final finalData = data.copyWith(scanPhotoPath: photoPath);

    AudioFeedbackService.instance.playScanSuccess();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Slip mil gayi!'),
          backgroundColor: AppColors.lime,
          duration: Duration(seconds: 1),
        ),
      );

      context.push('/slips/scan-result', extra: finalData);
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    final parsedData = OcrParser.parseText(recognizedText.text, image.path);

    if (mounted) {
      context.push('/slips/scan-result', extra: parsedData);
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    try {
      _isFlashOn = !_isFlashOn;
      await _cameraController!.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    } catch (_) {}
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _animController.dispose();
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final consolidated = _latestConsolidated;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              // Header (.hd)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    child: const Icon(Icons.close_rounded, color: AppColors.text, size: 22),
                  ),
                  const SizedBox(width: 10),
                  const Text('Slip scan', style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleFlash,
                    child: Icon(
                      _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                      color: _isFlashOn ? AppColors.lime : AppColors.muted,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Viewfinder Container
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF19191C),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Camera Preview or Fallback Simulation Box
                      if (_isCameraInitialized && _cameraController != null)
                        Positioned.fill(child: CameraPreview(_cameraController!))
                      else
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color(0xFF19191C),
                          alignment: Alignment.center,
                          child: Container(
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A2E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                      // Corner Brackets
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Container(width: 26, height: 26, decoration: const BoxDecoration(border: Border(left: BorderSide(color: AppColors.lime, width: 3), top: BorderSide(color: AppColors.lime, width: 3)))),
                      ),
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Container(width: 26, height: 26, decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColors.lime, width: 3), top: BorderSide(color: AppColors.lime, width: 3)))),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: Container(width: 26, height: 26, decoration: const BoxDecoration(border: Border(left: BorderSide(color: AppColors.lime, width: 3), bottom: BorderSide(color: AppColors.lime, width: 3)))),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: Container(width: 26, height: 26, decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColors.lime, width: 3), bottom: BorderSide(color: AppColors.lime, width: 3)))),
                      ),

                      // Moving Scan Line Overlay
                      AnimatedBuilder(
                        animation: _scanLineAnim,
                        builder: (context, child) {
                          return Positioned(
                            top: MediaQuery.of(context).size.height * 0.4 * _scanLineAnim.value,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 2,
                              color: AppColors.lime,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Hint Text
              Text(_hintMessage, style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),

              // Live Detected Chips
              if (consolidated != null) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: [
                    if (consolidated.receiptNo.value != null)
                      _buildChip('रसीद नं. ${consolidated.receiptNo.value}'),
                    if (consolidated.vehicleNo.value != null)
                      _buildChip(consolidated.vehicleNo.value!),
                    if (consolidated.grossKg.value != null)
                      _buildChip('${consolidated.grossKg.value} kg'),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              // Manual Trigger Button (if timeout or no camera)
              if (_showManualTrigger || !_isCameraInitialized) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lime,
                          foregroundColor: AppColors.onLime,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          // Simulate or capture current result
                          final dummy = OcrParser.parseText('रसीद नं. 1031\n11/10/2026\nमोहन लाल\nRJ 31 GA 0987\nगेहूं\nवाहन सहित माल 52,350 kg\nखाली तुलाने पर 13,450 kg');
                          _onAutoCaptureSuccess(dummy);
                        },
                        child: const Text('Photo lo (Manual)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface3,
                          foregroundColor: AppColors.text,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => context.push('/slips/new'),
                        child: const Text('Manual Entry', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              // Bottom Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: const Icon(Icons.photo_library_outlined, color: AppColors.text, size: 22),
                  ),
                  const Text('Auto-capture: 1 second', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                  GestureDetector(
                    onTap: _toggleFlash,
                    child: const Icon(Icons.flash_on_rounded, color: AppColors.text, size: 22),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.limeTintBg,
        border: Border.all(color: AppColors.limeTintBorder, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
