import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'theme.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';
import 'sections/hero_section.dart';
import 'sections/expertise_section.dart';
import 'sections/projets_section.dart';
import 'sections/stack_section.dart';
import 'sections/process_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const BladeCorp());
}

class BladeCorp extends StatelessWidget {
  const BladeCorp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLADE CORP — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PortfolioPage(),
      // scrollBehavior: WebScrollBehavior(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background ambient glow
          Positioned(
            top: -200,
            left: -100,
            child: Container(
              width: isMobile ? 400 : 600,
              height: isMobile ? 400 : 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.violet.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            right: -150,
            child: Container(
              width: isMobile ? 300 : 500,
              height: isMobile ? 300 : 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyan.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Sticky Navbar
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavbarDelegate(
                  scrollController: _scrollController,
                ),
              ),

              // Hero
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  key: accueilKey,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 72,
                  ),
                  child: const HeroSection(),
                ),
              ),

              // Divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              // Expertise
              const SliverToBoxAdapter(child: ExpertiseSection()),

              // Divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              // Projets
              const SliverToBoxAdapter(child: ProjetsSection()),

              // Divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              // Stack
              const SliverToBoxAdapter(child: StackSection()),

              // Divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              // Process
              const SliverToBoxAdapter(child: ProcessSection()),

              // Divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              // Contact
              const SliverToBoxAdapter(child: ContactSection()),

              // Footer
              const SliverToBoxAdapter(child: Footer()),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.border,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

// ─── NAVBAR PERSISTENT HEADER ─────────────────────────────────────
class _NavbarDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;

  _NavbarDelegate({required this.scrollController});

  @override
  double get minExtent => 72;
  @override
  double get maxExtent => 72;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Navbar(scrollController: scrollController);
  }

  @override
  bool shouldRebuild(_NavbarDelegate oldDelegate) => false;
}
