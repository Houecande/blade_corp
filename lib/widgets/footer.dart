import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildLogo(),
                const SizedBox(height: 20),
                _buildSocials(),
                const SizedBox(height: 20),
                _buildDevelopedWith(),
                const SizedBox(height: 20),
                _buildCopyright(),
              ],
            )
          : Row(
              children: [
                _buildLogo(),
                const SizedBox(width: 40),
                _buildDevelopedWith(),
                const Spacer(),
                _buildSocials(),
                const SizedBox(width: 40),
                _buildCopyright(),
              ],
            ),
    );
  }

  Widget _buildLogo() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.syne(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
          children: [
            const TextSpan(text: 'BLADE '),
            TextSpan(
              text: 'CORP',
              style: GoogleFonts.syne(
                  color: AppColors.cyan, fontSize: 16, fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: '.',
              style: GoogleFonts.syne(
                  color: AppColors.violet, fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevelopedWith() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Site entièrement développé avec ',
          style: TextStyle(color: AppColors.muted, fontSize: 12),
        ),
        const FlutterLogo(size: 16),
        const Text(
          ' Flutter',
          style: TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          url: 'https://www.linkedin.com/in/armand-biljoric-houecande-80769a366',
        ),
        const SizedBox(width: 16),
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/Houecande',
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© ${DateTime.now().year} — Armand Biljoric HOUECANDE',
      style: const TextStyle(color: AppColors.muted, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Icon(
          icon,
          color: AppColors.muted,
          size: 18,
        ),
      ),
    );
  }
}
