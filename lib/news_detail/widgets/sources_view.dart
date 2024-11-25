import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/widgets/web_button.dart';
import 'package:kagi_task/tabbed_view/domain/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SourcesView extends StatefulWidget {
  final List<Domain> domains;
  final String title;

  const SourcesView({super.key, required this.title, required this.domains});

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final displayedDomains =
        _isExpanded ? widget.domains : widget.domains.take(8).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (widget.domains.length > 8)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _isExpanded ? l10n.show_less : l10n.show_all,
                      ),
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: displayedDomains.map(
            (entry) {
              return WebButton(
                url: entry.name,
                favIcon: entry.favIcon,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
