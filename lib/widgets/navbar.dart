import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  const Navbar({super.key, required this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final s = widget.scrollController.offset > 20;
      if (s != _scrolled) setState(() => _scrolled = s);
    });
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 72,
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.bg.withOpacity(0.92)
            : AppColors.bg.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.border : Colors.transparent,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48),
        child: Row(
          children: [
            // Logo
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.syne(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      const TextSpan(text: 'BLADE '),
                      TextSpan(
                        text: 'CORP',
                        style: GoogleFonts.syne(
                          color: AppColors.cyan,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: GoogleFonts.syne(
                          color: AppColors.violet,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (!isMobile) ...[
              _NavLink('Expertise', () => _scrollTo(expertiseKey)),
              _NavLink('Projets', () => _scrollTo(projetsKey)),
              _NavLink('Stack', () => _scrollTo(stackKey)),
              _NavLink('Process', () => _scrollTo(processKey)),
              _NavLink('Contact', () => _scrollTo(contactKey)),
              const SizedBox(width: 16),
              _DiscuterButton(onTap: () => _scrollTo(contactKey)),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.text),
                onPressed: () => _showMobileMenu(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            for (final item in ['Expertise', 'Projets', 'Stack', 'Process', 'Contact'])
              ListTile(
                title: Text(item,
                    style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.muted),
                onTap: () {
                  Navigator.pop(context);
                  final key = {
                    'Expertise': expertiseKey,
                    'Projets': projetsKey,
                    'Stack': stackKey,
                    'Process': processKey,
                    'Contact': contactKey,
                  }[item]!;
                  Future.delayed(const Duration(milliseconds: 300), () => _scrollTo(key));
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _hovered ? AppColors.text : AppColors.muted,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Space Grotesk',
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _DiscuterButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DiscuterButton({required this.onTap});

  @override
  State<_DiscuterButton> createState() => _DiscuterButtonState();
}

class _DiscuterButtonState extends State<_DiscuterButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.text : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.text.withOpacity(0.6)),
          ),
          child: Text(
            'Discuter',
            style: TextStyle(
              color: _hovered ? AppColors.bg : AppColors.text,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
