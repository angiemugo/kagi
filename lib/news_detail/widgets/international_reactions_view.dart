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

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, l10n),
          const SizedBox(height: 16),
          ..._buildReactionCards(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, AppLocalizations l10n) {
    return Text(
      l10n.international_title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
    );
  }

  List<Widget> _buildReactionCards(BuildContext context) {
    return reactions.map((reaction) {
      final splitReaction = reaction.splitOrExtract();
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _ReactionCard(
          title: splitReaction?['title'] ?? '',
          content: splitReaction?['content'] ?? '',
        ),
      );
    }).toList();
  }
}

class _ReactionCard extends StatelessWidget {
  final String title;
  final String content;

  const _ReactionCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
