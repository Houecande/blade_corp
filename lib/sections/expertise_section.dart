import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final crossCount = isMobile ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 3);

    final expertises = [
      _ExpertiseData(
        gradient: const LinearGradient(
          colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.palette_outlined,
        title: 'Conception UX/UI',
        description:
            "Création d'interfaces centrées utilisateur, de wireframes et de prototypes interactifs. Je transforme des idées complexes en designs intuitifs.",
        tags: ['Figma', 'Prototyping', 'Balsamiq', 'Design Systems'],
      ),
      _ExpertiseData(
        gradient: AppColors.gradBlue,
        icon: Icons.code,
        title: 'Développement Mobile & Web',
        description:
            "Développement d'applications mobiles et web modernes avec Flutter/Dart. Code propre, modulaire et performant pour donner vie aux designs.",
        tags: ['Flutter', 'Dart', 'Firebase', 'HTML/CSS/JS'],
      ),
      _ExpertiseData(
        gradient: AppColors.gradViolet,
        icon: Icons.memory_outlined,
        title: 'Intégration Technique',
        description:
            "Pont entre le design et la technique. Backend Python/FastAPI, intégration pixel-perfect tout en optimisant les performances.",
        tags: ['Python', 'FastAPI', 'Java', 'VB.NET'],
      ),
    ];

    return Container(
      key: expertiseKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          FadeInSection(
            child: SectionTitle(
              title: "Mes Domaines d'Expertise",
              subtitle:
                  "Une approche multidisciplinaire pour créer des produits numériques complets, de la conception à la mise en production.",
            ),
          ),
          const SizedBox(height: 64),
          isMobile
              ? Column(
                  children: expertises
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FadeInSection(
                              delayMs: e.key * 150,
                              child: _ExpertiseCard(data: e.value),
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: expertises
                      .asMap()
                      .entries
                      .map((e) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: e.key == 0 ? 0 : 12,
                                right: e.key == expertises.length - 1 ? 0 : 12,
                              ),
                              child: FadeInSection(
                                delayMs: e.key * 150,
                                child: _ExpertiseCard(data: e.value),
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _ExpertiseData {
  final Gradient gradient;
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;

  const _ExpertiseData({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
  });
}

class _ExpertiseCard extends StatefulWidget {
  final _ExpertiseData data;
  const _ExpertiseCard({required this.data});

  @override
  State<_ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<_ExpertiseCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.cyan.withValues(alpha: 0.25)
                : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.06),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with gradient background
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: widget.data.gradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(widget.data.icon, color: Colors.white, size: 28),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.data.title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.description,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 14,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.data.tags.map((t) => PillTag(t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
