import 'package:flutter/material.dart';
import 'package:kagi_task/util/string_splitter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InternationalReactionsView extends StatelessWidget {
  final List<String> reactions;

  const InternationalReactionsView({
    super.key,
    required this.reactions,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (reactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.international_title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            ...reactions.map((reaction) {
              final splitReaction = reaction.splitOrExtract();
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildCard(
                  context: context,
                  title: splitReaction!['title']!,
                  content: splitReaction['content']!,
                ),
              );
            }),
          ],
        ));
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
