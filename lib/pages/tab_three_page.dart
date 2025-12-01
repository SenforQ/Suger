import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../services/coin_service.dart';
import '../utils/toast_utils.dart';

class TabThreePage extends StatefulWidget {
  const TabThreePage({super.key});

  @override
  State<TabThreePage> createState() => _TabThreePageState();
}

class _TabThreePageState extends State<TabThreePage> {
  final ImagePicker _picker = ImagePicker();
  String? _relativeImagePath;
  String? _documentsDirPath;
  bool _isSaving = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initDocumentsDir();
  }

  Future<void> _initDocumentsDir() async {
    final dir = await getApplicationDocumentsDirectory();
    setState(() {
      _documentsDirPath = dir.path;
    });
  }

  Future<void> _handleUpload() async {
    if (_isSaving) return;
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      if (_documentsDirPath == null) {
        await _initDocumentsDir();
      }
      if (_documentsDirPath == null) {
        return;
      }
      final Directory uploadsDir =
          Directory(p.join(_documentsDirPath!, 'uploads'));
      if (!uploadsDir.existsSync()) {
        uploadsDir.createSync(recursive: true);
      }
      final String fileName =
          'art_${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}';
      final File savedFile =
          await File(picked.path).copy(p.join(uploadsDir.path, fileName));
      final String relativePath =
          savedFile.path.replaceFirst('${_documentsDirPath!}/', '');
      setState(() {
        _relativeImagePath = relativePath;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  File? _resolveImageFile() {
    if (_relativeImagePath == null || _documentsDirPath == null) {
      return null;
    }
    return File(p.join(_documentsDirPath!, _relativeImagePath!));
  }

  Future<void> _handleSubmit() async {
    if (_relativeImagePath == null || _isSubmitting) {
      return;
    }

    const requiredCoins = 50;
    final currentCoins = await CoinService.getCurrentCoins();

    if (currentCoins < requiredCoins) {
      await _showInsufficientCoinsDialog(currentCoins, requiredCoins);
      return;
    }

    final result = await _showCoinUsageDialog(currentCoins, requiredCoins);
    if (result != true) {
      return;
    }

    final success = await CoinService.deductCoins(requiredCoins);
    if (!success) {
      showCenterToast(context, 'Failed to deduct coins');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    try {
      await _showUploadSuccessDialog();
      final File? file = _resolveImageFile();
      if (file != null && file.existsSync()) {
        await file.delete();
      }
      if (mounted) {
        setState(() {
          _relativeImagePath = null;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<bool?> _showCoinUsageDialog(int currentCoins, int requiredCoins) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.monetization_on, color: Color(0xFFFFCC1B)),
            SizedBox(width: 12),
            Text(
              'Coins Required',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uploading artwork requires 50 Coins.',
              style: TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your coins: $currentCoins',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Required: $requiredCoins Coins',
              style: const TextStyle(
                color: Color(0xFFFFCC1B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF999999)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC1B),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Use Coins',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInsufficientCoinsDialog(int currentCoins, int requiredCoins) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Color(0xFFFF6B6B)),
            SizedBox(width: 12),
            Text(
              'Insufficient Coins',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uploading artwork requires 50 Coins.',
              style: TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your coins: $currentCoins',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Required: $requiredCoins Coins',
              style: const TextStyle(
                color: Color(0xFFFF6B6B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please purchase more coins to continue.',
              style: TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFFFFCC1B)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showUploadSuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Submitted'),
        content: const Text(
          'Upload successful! Your artwork requires manual review. We will deliver the AI analysis results within 24 hours.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final File? displayFile = _resolveImageFile();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg_interpret_nor.webp',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/base_bg_botoom.webp',
              width: screenWidth,
              height: 82,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _isSaving ? null : _handleUpload,
                  child: Container(
                    width: 148,
                    height: 178,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: displayFile != null
                          ? Image.file(
                              displayFile,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/img_interpret_nor.webp',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Upload your artwork here to access professional AI analysis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: (_relativeImagePath == null || _isSubmitting)
                      ? null
                      : _handleSubmit,
                  child: Opacity(
                    opacity:
                        (_relativeImagePath == null || _isSubmitting) ? 0.6 : 1,
                    child: Container(
                      width: screenWidth - 40,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC600),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC600).withOpacity(0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  valueColor: AlwaysStoppedAnimation(
                                    Color(0xFF222222),
                                  ),
                                ),
                              )
                            : const Text(
                                'Upload',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}