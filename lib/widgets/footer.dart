import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                const SizedBox(height: 16),
                _buildCopyright(),
              ],
            )
          : Row(
              children: [
                _buildLogo(),
                const Spacer(),
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

  Widget _buildCopyright() {
    return Text(
      '© ${DateTime.now().year} — Design & Code by Armand Biljoric HOUECANDE',
      style: const TextStyle(color: AppColors.muted, fontSize: 13),
      textAlign: TextAlign.center,
    );
  }
}
