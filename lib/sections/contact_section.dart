import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: AppColors.violet,
        ),
      );
      return;
    }

    setState(() => _sending = true);

    final uri = Uri(
      scheme: 'mailto',
      path: 'armandhouecande92@gmail.com',
      query: 'subject=Portfolio Contact - $name&body=$message\n\nDe: $name ($email)',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }

    setState(() => _sending = false);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      key: contactKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 100,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeft(),
                const SizedBox(height: 48),
                _buildForm(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: _buildLeft()),
                const SizedBox(width: 60),
                Expanded(flex: 5, child: _buildForm()),
              ],
            ),
    );
  }

  Widget _buildLeft() {
    return FadeInSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parlons de votre',
            style: GoogleFonts.syne(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
              height: 1.1,
            ),
          ),
          GradientText(
            'projet',
            gradient: AppColors.gradCyan,
            style: GoogleFonts.syne(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Que vous ayez une idée précise ou juste un début de concept, je serais ravi d\'échanger avec vous.',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 15,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 36),

          _ContactItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'armandhouecande92@gmail.com',
            onTap: () => _launch('mailto:armandhouecande92@gmail.com'),
          ),
          const SizedBox(height: 16),
          _ContactItem(
            icon: Icons.phone_outlined,
            label: 'Téléphone',
            value: '+229 01 91 43 51 31',
            onTap: () => _launch('tel:+22901914351'),
          ),
          const SizedBox(height: 16),
          _ContactItem(
            icon: Icons.location_on_outlined,
            label: 'Localisation',
            value: 'Abomey-Calavi, Bénin',
          ),
          const SizedBox(height: 28),

          // Social links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _SocialButton(
                icon: Icons.work_outlined,
                label: 'LinkedIn',
                url: 'https://www.linkedin.com/in/armand-biljoric-houecande-80769a366',
              ),
              _SocialButton(
                icon: Icons.code,
                label: 'GitHub',
                url: 'https://github.com/Houecande',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return FadeInSection(
      delayMs: 200,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 20 : 32),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobile) ...[
              _InputField(controller: _nameCtrl, label: 'Nom', hint: 'Votre nom'),
              const SizedBox(height: 16),
              _InputField(controller: _emailCtrl, label: 'Email', hint: 'hello@exemple.com'),
            ] else
              Row(
                children: [
                  Expanded(child: _InputField(controller: _nameCtrl, label: 'Nom', hint: 'Votre nom')),
                  const SizedBox(width: 16),
                  Expanded(child: _InputField(controller: _emailCtrl, label: 'Email', hint: 'hello@exemple.com')),
                ],
              ),
            const SizedBox(height: 16),
            _InputField(
              controller: _messageCtrl,
              label: 'Message',
              hint: 'Parlez-moi de votre projet…',
              maxLines: 5,
            ),
            const SizedBox(height: 20),

            // Send button
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _sending ? null : _sendEmail,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppColors.gradCyan,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_sending)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      else ...[
                        const Text(
                          'Envoyer le message',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.send_outlined, color: Colors.white, size: 18),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: AppColors.text, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
            filled: true,
            fillColor: AppColors.bg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.bg3,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: AppColors.cyan, size: 18),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: onTap != null ? AppColors.text : AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: onTap != null ? TextDecoration.underline : null,
                  decorationColor: AppColors.cyan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) launchUrl(uri);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.cyan.withOpacity(0.1) : AppColors.bg3,
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered ? AppColors.cyan.withOpacity(0.4) : AppColors.border,
            ),
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: _hovered ? AppColors.cyan : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
