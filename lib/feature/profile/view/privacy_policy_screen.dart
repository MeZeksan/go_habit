import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/locale_extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.privacy_policy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.privacy_policy,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.privacy_policy_last_updated('29 марта 2025'),
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            _PolicySection(
              title: context.l10n.privacy_policy_section1_title,
              content: context.l10n.privacy_policy_section1_content,
            ),
            _PolicySection(
              title: context.l10n.privacy_policy_section2_title,
              content: context.l10n.privacy_policy_section2_content,
            ),
            _PolicySection(
              title: context.l10n.privacy_policy_section3_title,
              content: context.l10n.privacy_policy_section3_content,
            ),
            _PolicySection(
              title: context.l10n.privacy_policy_section4_title,
              content: context.l10n.privacy_policy_section4_content,
            ),
            _PolicySection(
              title: context.l10n.privacy_policy_section5_title,
              content: context.l10n.privacy_policy_section5_content,
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                context.l10n
                    .privacy_policy_copyright(DateTime.now().year.toString()),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
