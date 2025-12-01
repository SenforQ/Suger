import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'about_us_page.dart';
import 'edit_page.dart';
import 'suger_privacy_page.dart';
import 'suger_terms_page.dart';
import 'vip_page.dart';
import 'wallet_page.dart';
import '../utils/preference_helper.dart';

class TabFourPage extends StatefulWidget {
  const TabFourPage({super.key});

  @override
  State<TabFourPage> createState() => _TabFourPageState();
}

class _TabFourPageState extends State<TabFourPage> {
  String? _userName;
  String? _avatarPath;
  String? _documentsDirPath;

  @override
  void initState() {
    super.initState();
    _initDocumentsDir();
    _loadUserData();
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
    setState(() {
      _userName = name;
      _avatarPath = avatarPath;
    });
  }

  File? _resolveImageFile(String? relativePath) {
    if (relativePath == null || _documentsDirPath == null) {
      return null;
    }
    final file = File(p.join(_documentsDirPath!, relativePath));
    return file.existsSync() ? file : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double bottomPadding = MediaQuery.of(context).padding.bottom + 102;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF4),
      body: Stack(
        children: [
          
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopWaveSection(
                    avatarPath: _avatarPath,
                    documentsDirPath: _documentsDirPath,
                    onEdit: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EditPage(),
                        ),
                      );
                      if (result == true && mounted) {
                        await _loadUserData();
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, bottomPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName ?? 'Vivoc',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1D1D1D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Expert in generating AI artworks, specializing in creating realistic AI portraits.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF5C5C5C),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const VipPage(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/btn_profile_vip.webp',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const WalletPage(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/btn_profile_wallet.webp',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        _ProfileMenuItem(
                          icon: Icons.assignment_turned_in_rounded,
                          iconColor: const Color(0xFFFFBD00),
                          title: 'User Contract',
                          subtitle: 'Read the latest service terms',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SugerTermsPage(),
                              ),
                            );
                          },
                        ),
                        _ProfileMenuItem(
                          icon: Icons.privacy_tip_outlined,
                          iconColor: const Color(0xFFFFC542),
                          title: 'Privacy Policy',
                          subtitle: 'Understand how data is protected',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SugerPrivacyPage(),
                              ),
                            );
                          },
                        ),
                        _ProfileMenuItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: const Color(0xFFFFD966),
                          title: 'About us',
                          subtitle: 'Learn more about the team',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const AboutUsPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 36),
                      ],
                    ),
                  ),
                ],
              ),
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
        ],
      ),
    );
  }
}

class _TopWaveSection extends StatelessWidget {
  const _TopWaveSection({
    required this.avatarPath,
    required this.documentsDirPath,
    required this.onEdit,
  });

  final String? avatarPath;
  final String? documentsDirPath;
  final VoidCallback onEdit;

  File? _resolveImageFile(String? relativePath) {
    if (relativePath == null || documentsDirPath == null) {
      return null;
    }
    final file = File(p.join(documentsDirPath!, relativePath));
    return file.existsSync() ? file : null;
  }

  @override
  Widget build(BuildContext context) {
    final File? displayFile = avatarPath != null ? _resolveImageFile(avatarPath) : null;

    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: _WaveClipper(),
              child: Image.asset(
                'assets/mine_top_bg.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 24,
            bottom: 16,
            child: Stack(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
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
                    borderRadius: BorderRadius.circular(24),
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
                    onTap: onEdit,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC1B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 16,
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

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _QuickActionCard(
          icon: Icons.wallet_rounded,
          label: 'Subscription',
        ),
        SizedBox(width: 16),
        _QuickActionCard(
          icon: Icons.emoji_events_rounded,
          label: 'Membership',
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE5E1D4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFFFFB800),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4C4C4C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFEAE2CE)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.18),
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F1F),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB3B3B3),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height,
        size.width * 0.5,
        size.height - 30,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height - 60,
        size.width,
        size.height - 10,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}