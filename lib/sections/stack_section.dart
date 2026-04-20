import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/data.dart';

class StackSection extends StatelessWidget {
  const StackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      key: stackKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          FadeInSection(
            child: SectionTitle(
              title: 'Ma Stack Technique',
              subtitle: 'Les outils et technologies que j\'utilise pour construire des produits robustes et performants.',
            ),
          ),
          const SizedBox(height: 64),
          isMobile
              ? Column(
                  children: stackCategories
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FadeInSection(
                              delayMs: e.key * 100,
                              child: _StackCard(category: e.value),
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: FadeInSection(delayMs: 0, child: _StackCard(category: stackCategories[0])))),
                        Expanded(child: Padding(padding: const EdgeInsets.only(left: 12), child: FadeInSection(delayMs: 100, child: _StackCard(category: stackCategories[1])))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: FadeInSection(delayMs: 200, child: _StackCard(category: stackCategories[2])))),
                        Expanded(child: Padding(padding: const EdgeInsets.only(left: 12), child: FadeInSection(delayMs: 300, child: _StackCard(category: stackCategories[3])))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: FadeInSection(delayMs: 400, child: _StackCard(category: stackCategories[4])))),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _StackCard extends StatefulWidget {
  final StackCategory category;
  const _StackCard({required this.category});

  @override
  State<_StackCard> createState() => _StackCardState();
}

class _StackCardState extends State<_StackCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? AppColors.cyan.withValues(alpha: 0.2) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient line
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: widget.category.gradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.category.name,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.category.items
                  .map((item) => _StackChip(item: item, gradient: widget.category.gradient))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StackChip extends StatefulWidget {
  final StackItem item;
  final Gradient gradient;
  const _StackChip({required this.item, required this.gradient});

  @override
  State<_StackChip> createState() => _StackChipState();
}

class _StackChipState extends State<_StackChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.bg3 : AppColors.bg,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered ? AppColors.cyan.withValues(alpha: 0.3) : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.item.icon,
              size: 15,
              color: _hovered ? AppColors.cyan : AppColors.muted,
            ),
            const SizedBox(width: 7),
            Text(
              widget.item.name,
              style: TextStyle(
                color: _hovered ? AppColors.text : AppColors.muted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
