import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE5),
      appBar: AppBar(
        title: const Text('About Suger'),
        backgroundColor: const Color(0xFFFFE207),
        elevation: 0,
        foregroundColor: const Color(0xFF2A2A2A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(
              title: 'Art meets Intelligence',
              subtitle:
                  'Suger blends state-of-the-art AI models with delightful mobile craftsmanship so anyone can create breathtaking visuals effortlessly.',
            ),
            const SizedBox(height: 24),
            Text(
              'Our Mission',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Through intuitive tools and precise detail control, we make AI artistry playful yet reliable so every creator stays inspired and confident.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Core Capabilities',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
            ),
            const SizedBox(height: 16),
            const _CapabilityGrid(),
            const SizedBox(height: 24),
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
            ),
            const SizedBox(height: 12),
            const _ContactCard(
              title: 'Partnerships & Media',
              detail: 'hi@suger.app',
              icon: Icons.mail_outline,
            ),
            const SizedBox(height: 12),
            const _ContactCard(
              title: 'Community Support',
              detail: '@SugerOfficial',
              icon: Icons.chat_bubble_outline,
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '© ${DateTime.now().year} Suger Studio. All rights reserved.',
                style: const TextStyle(
                  color: Color(0xFF7A7A7A),
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE207),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/app_logo.webp',
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapabilityGrid extends StatelessWidget {
  const _CapabilityGrid();

  @override
  Widget build(BuildContext context) {
    final List<_CapabilityItemData> data = [
      const _CapabilityItemData(
        title: 'High-fidelity generation',
        desc: 'Hybrid inference pipeline that balances speed with photorealistic detail.',
        icon: Icons.auto_awesome,
      ),
      const _CapabilityItemData(
        title: 'Semantic controls',
        desc: 'Visual sliders for prompts, styles, lighting, and composition.',
        icon: Icons.tune,
      ),
      const _CapabilityItemData(
        title: 'Real-time co-creation',
        desc: 'Shared canvases let teams brainstorm and iterate together instantly.',
        icon: Icons.groups_2_outlined,
      ),
    ];

    return Column(
      children: data
          .map(
            (item) => _CapabilityCard(item: item),
          )
          .toList(),
    );
  }
}

class _CapabilityItemData {
  const _CapabilityItemData({
    required this.title,
    required this.desc,
    required this.icon,
  });

  final String title;
  final String desc;
  final IconData icon;
}

class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({required this.item});

  final _CapabilityItemData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFF2A3),
            ),
            child: Icon(
              item.icon,
              color: const Color(0xFF8A6A01),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.desc,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF626262),
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

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.title,
    required this.detail,
    required this.icon,
  });

  final String title;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE207),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF7A5800),
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
                        color: const Color(0xFF1A1A1A),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(
                    color: Color(0xFF5C5C5C),
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

