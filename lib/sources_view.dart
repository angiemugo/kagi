import 'package:flutter/material.dart';
import 'package:kagi_task/domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'kite_theme.dart';

class SourcesView extends StatelessWidget {
  final List<Domain> domains;
  final String title;

  const SourcesView({super.key, required this.title, required this.domains});

  @override
  Widget build(BuildContext context) {
    final groupedDomains = groupDomainsByLink(domains);
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final decorations = Theme.of(context).extension<AppDecorations>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            l10n.sources_title,
          ),
        ),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: groupedDomains.entries.map((entry) {
            final count = entry.value.length;

            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: decorations?.quoteBox,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    entry.value.first.favIcon,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.value.first.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        l10n.sources_count(count),
                      )
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Map<String, List<Domain>> groupDomainsByLink(List<Domain> domains) {
    final Map<String, List<Domain>> grouped = {};
    for (final domain in domains) {
      if (!grouped.containsKey(domain.name)) {
        grouped[domain.name] = [];
      }
      grouped[domain.name]!.add(domain);
    }
    return grouped;
  }
}
