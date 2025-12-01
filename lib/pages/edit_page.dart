import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/preference_helper.dart';
import '../utils/toast_utils.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _documentsDirPath;
  String? _selectedImagePath;
  String? _currentAvatarPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDocumentsDir();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _initDocumentsDir() async {
    final dir = await getApplicationDocumentsDirectory();
    setState(() {
      _documentsDirPath = dir.path;
    });
  }

  Future<void> _loadUserData() async {
    final name = await PreferenceHelper.getUserName();
    final avatarPath = await PreferenceHelper.getUserAvatarPath();
    
    if (mounted) {
      setState(() {
        _nameController.text = name ?? 'Vivoc';
        _currentAvatarPath = avatarPath;
        _selectedImagePath = avatarPath;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_documentsDirPath == null) {
        await _initDocumentsDir();
      }
      if (_documentsDirPath == null) {
        showCenterToast(context, 'Failed to initialize storage directory');
        return;
      }

      final Directory avatarsDir = Directory(p.join(_documentsDirPath!, 'avatars'));
      if (!avatarsDir.existsSync()) {
        avatarsDir.createSync(recursive: true);
      }

      final String fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}';
      final File savedFile = await File(picked.path).copy(p.join(avatarsDir.path, fileName));
      final String relativePath = savedFile.path.replaceFirst('${_documentsDirPath!}/', '');

      if (mounted) {
        setState(() {
          _selectedImagePath = relativePath;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        showCenterToast(context, 'Failed to save image: $e');
      }
    }
  }

  File? _resolveImageFile(String? relativePath) {
    if (relativePath == null || _documentsDirPath == null) {
      return null;
    }
    final file = File(p.join(_documentsDirPath!, relativePath));
    return file.existsSync() ? file : null;
  }

  Future<void> _handleSave() async {
    final isVip = await PreferenceHelper.isVipActive();
    
    if (!isVip) {
      showCenterToast(context, 'VIP subscription required to save changes');
      return;
    }

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showCenterToast(context, 'Please enter a name');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await PreferenceHelper.setUserName(name);
      await PreferenceHelper.setUserAvatarPath(_selectedImagePath);
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        showCenterToast(context, 'Saved successfully');
        await Future.delayed(const Duration(milliseconds: 300));
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        showCenterToast(context, 'Failed to save: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final File? displayFile = _selectedImagePath != null 
        ? _resolveImageFile(_selectedImagePath) 
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _handleSave,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isLoading ? Colors.grey : const Color(0xFFFFCC1B),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: displayFile != null
                              ? Image.file(
                                  displayFile,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/user_default.webp',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/user_default.webp',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _isLoading ? null : _pickImage,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCC1B),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Color(0xFF5C5C5C)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFEAE2CE)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFFFCC1B), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1D1D1D),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFCC1B)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

