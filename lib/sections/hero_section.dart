import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late AnimationController _rotateCtrl;
  late AnimationController _entryCtrl;

  late Animation<double> _floatAnim;
  late Animation<double> _rotateAnim;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // Float animation for photo
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    // Slow rotation for dashed circle
    _rotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _rotateAnim = Tween<double>(begin: 0, end: 2 * pi).animate(_rotateCtrl);

    // Entry animation
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entryCtrl, curve: const Interval(0, 0.7, curve: Curves.easeOut)),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _rotateCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 0,
      ),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _buildPhoto(),
                const SizedBox(height: 40),
                _buildTextContent(isMobile),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 5, child: _buildTextContent(isMobile)),
                Expanded(flex: 4, child: _buildPhoto()),
              ],
            ),
    );
  }

  Widget _buildTextContent(bool isMobile) {
    return FadeTransition(
      opacity: _opacityAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge freelance
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
                color: AppColors.cyan.withOpacity(0.07),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BlinkingDot(),
                  const SizedBox(width: 8),
                  Text(
                    'Available for freelance',
                    style: TextStyle(
                      color: AppColors.cyan,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Title
            Text(
              "L'alliance du",
              style: GoogleFonts.syne(
                fontSize: isMobile ? 36 : 52,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
                height: 1.1,
              ),
            ),
            Wrap(
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              runSpacing: 0,
              children: [
                GradientText(
                  'Design ',
                  gradient: const LinearGradient(
                    colors: [AppColors.cyan, Color(0xFF60A5FA)],
                  ),
                  style: GoogleFonts.syne(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                Text(
                  'et du ',
                  style: GoogleFonts.syne(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                    height: 1.1,
                  ),
                ),
                GradientText(
                  'Code',
                  gradient: const LinearGradient(
                    colors: [AppColors.violet, Color(0xFFA78BFA)],
                  ),
                  style: GoogleFonts.syne(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Subtitle
            Text(
              'Je conçois des expériences numériques esthétiques et performantes. Une approche hybride pour des produits qui marquent les esprits.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 15,
                height: 1.7,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 36),

            // CTA Buttons
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment:
                  isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: [
                GradientButton(
                  label: 'Découvrir mes projets',
                  icon: Icons.arrow_forward,
                  onTap: () {
                    final ctx = projetsKey.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(ctx,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
                GradientButton(
                  label: 'Me contacter',
                  outlined: true,
                  onTap: () {
                    final ctx = contactKey.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(ctx,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatAnim, _rotateAnim, _opacityAnim]),
      builder: (_, __) {
        return Opacity(
          opacity: _opacityAnim.value,
          child: Transform.translate(
            offset: Offset(0, _floatAnim.value),
            child: SizedBox(
              width: 340,
              height: 380,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating dashed circle
                  Transform.rotate(
                    angle: _rotateAnim.value,
                    child: CustomPaint(
                      size: const Size(310, 310),
                      painter: _DashedCirclePainter(),
                    ),
                  ),

                  // Glow behind photo
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.violet.withOpacity(0.3),
                          blurRadius: 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),

                  // Photo circle
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.bg2,
                        width: 4,
                      ),
                      gradient: const LinearGradient(
                        colors: [AppColors.bg2, AppColors.bg3],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    // Replace ClipOval > Image.asset('assets/images/profile.jpg')
                    // when you add your photo
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        width: 240,
                        height: 240,
                      ),
                    ),
                  ),

                  // Badge UI/UX — top right
                  Positioned(
                    top: 20,
                    right: 10,
                    child: _FloatingBadge(
                      icon: Icons.dashboard_customize_outlined,
                      label: 'UI/UX',
                      color: AppColors.violet,
                    ),
                  ),

                  // Badge Dev — bottom left
                  Positioned(
                    bottom: 30,
                    left: 0,
                    child: _FloatingBadge(
                      icon: Icons.code,
                      label: 'Dev',
                      color: AppColors.cyan,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── DASHED CIRCLE PAINTER ────────────────────────────────────────
class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.violet.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const dashCount = 30;
    const dashAngle = 2 * pi / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle * 0.5,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── FLOATING BADGE ───────────────────────────────────────────────
class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FloatingBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
