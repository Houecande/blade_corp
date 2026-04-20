import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  static const steps = [
    _ProcessStep(
      icon: Icons.search,
      title: 'Recherche',
      description: 'Analyse des besoins, benchmark et définition de l\'expérience utilisateur cible.',
      color: AppColors.cyan,
    ),
    _ProcessStep(
      icon: Icons.space_dashboard_outlined,
      title: 'Maquettage',
      description: 'Création de wireframes basse fidélité pour valider la structure et les flux.',
      color: AppColors.violet,
    ),
    _ProcessStep(
      icon: Icons.touch_app_outlined,
      title: 'Prototypage',
      description: 'Design UI haute fidélité et prototypes interactifs testables.',
      color: AppColors.pink,
    ),
    _ProcessStep(
      icon: Icons.code,
      title: 'Développement',
      description: 'Intégration clean code, responsive et optimisation des performances.',
      color: Color(0xFF10B981),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      key: processKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
      ),
      child: Column(
        children: [
          FadeInSection(
            child: SectionTitle(
              title: 'Mon Processus',
              subtitle: 'Une méthodologie rigoureuse pour des résultats prévisibles et qualitatifs.',
            ),
          ),
          const SizedBox(height: 80),
          isMobile
              ? Column(
                  children: steps
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: FadeInSection(
                              delayMs: e.key * 120,
                              child: _ProcessCard(step: e.value, index: e.key),
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: steps.asMap().entries.map((e) {
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: FadeInSection(
                              delayMs: e.key * 120,
                              child: _ProcessCard(step: e.value, index: e.key),
                            ),
                          ),
                          // Connector arrow between steps
                          if (e.key < steps.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Icon(
                                Icons.arrow_forward,
                                color: AppColors.border,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _ProcessStep {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ProcessStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _ProcessCard extends StatefulWidget {
  final _ProcessStep step;
  final int index;
  const _ProcessCard({required this.step, required this.index});

  @override
  State<_ProcessCard> createState() => _ProcessCardState();
}

class _ProcessCardState extends State<_ProcessCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.card : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.step.color.withValues(alpha: 0.3)
                : AppColors.border.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          children: [
            // Step number
            Text(
              '0${widget.index + 1}',
              style: GoogleFonts.syne(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: widget.step.color.withValues(alpha: 0.5),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),

            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: widget.step.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: widget.step.color.withValues(alpha: 0.2)),
              ),
              child: Icon(widget.step.icon, color: widget.step.color, size: 28),
            ),
            const SizedBox(height: 20),

            Text(
              widget.step.title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.step.description,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 13,
                height: 1.65,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
