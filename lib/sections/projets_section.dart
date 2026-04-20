import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/data.dart';

class ProjetsSection extends StatelessWidget {
  const ProjetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final crossCount = isMobile ? 1 : (MediaQuery.of(context).size.width < 1100 ? 2 : 3);

    return Container(
      key: projetsKey,
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
              title: 'Mes Projets',
              subtitle: 'Des applications concrètes alliant design soigné et code robuste.',
            ),
          ),
          const SizedBox(height: 16),

          // Dev projects grid
          const SizedBox(height: 48),
          FadeInSection(
            delayMs: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _SectionLabel(label: '⟨/⟩  Projets Dev & Mobile'),
            ),
          ),
          const SizedBox(height: 24),
          _buildGrid(context, projects, crossCount),

          const SizedBox(height: 60),
          // Design projects
          FadeInSection(
            delayMs: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _SectionLabel(label: '✦  Projets UI/UX Design'),
            ),
          ),
          const SizedBox(height: 24),
          isMobile
              ? Column(
                  children: designProjects
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _DesignProjectCard(project: p),
                          ))
                      .toList(),
                )
              : Row(
                  children: designProjects
                      .asMap()
                      .entries
                      .map((e) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: e.key == 0 ? 12 : 0,
                                left: e.key == 1 ? 12 : 0,
                              ),
                              child: _DesignProjectCard(project: e.value),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<ProjectModel> items, int crossCount) {
    if (crossCount == 1) {
      return Column(
        children: items
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FadeInSection(
                    delayMs: e.key * 100,
                    child: _ProjectCard(project: e.value),
                  ),
                ))
            .toList(),
      );
    }

    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += crossCount) {
      final rowItems = items.skip(i).take(crossCount).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: rowItems.asMap().entries.map((e) {
              final globalIndex = i + e.key;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: e.key > 0 ? 8 : 0,
                    right: e.key < rowItems.length - 1 ? 8 : 0,
                  ),
                  child: FadeInSection(
                    delayMs: globalIndex * 80,
                    child: _ProjectCard(project: e.value),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── DEV PROJECT CARD ─────────────────────────────────────────────
class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _launch(widget.project.githubUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? AppColors.cyan.withValues(alpha: 0.3)
                  : AppColors.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.07),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: widget.project.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.project.icon, color: Colors.white, size: 20),
                  ),
                  const Spacer(),
                  if (widget.project.inProgress)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.violet.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.violet.withValues(alpha: 0.3)),
                      ),
                      child: const Text(
                        'En cours',
                        style: TextStyle(
                          color: AppColors.violet,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: _hovered ? AppColors.cyan : AppColors.muted,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.project.title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.project.description,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  PillTag(widget.project.tech),
                  if (widget.project.liveUrl != null) ...[
                    GestureDetector(
                      onTap: () => _launch(widget.project.liveUrl!),
                      child: PillTag('🔗 Live'),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }
}

// ─── DESIGN PROJECT CARD ──────────────────────────────────────────
class _DesignProjectCard extends StatefulWidget {
  final DesignProjectModel project;
  const _DesignProjectCard({required this.project});

  @override
  State<_DesignProjectCard> createState() => _DesignProjectCardState();
}

class _DesignProjectCardState extends State<_DesignProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _launch(widget.project.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? AppColors.violet.withValues(alpha: 0.4)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.gradViolet,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.project.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runSpacing: 4,
                      children: [
                        Text(
                          widget.project.title,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        PillTag(widget.project.tool),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.project.description,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    if (widget.project.secondUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () => _launch(widget.project.secondUrl!),
                          child: const Text(
                            'Voir sur LinkedIn →',
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new,
                size: 16,
                color: _hovered ? AppColors.violet : AppColors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }
}
