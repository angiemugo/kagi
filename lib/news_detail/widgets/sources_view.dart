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
        _buildHeader(context, l10n),
        _buildDomainList(displayedDomains),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
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
          if (widget.domains.length > 8) _buildExpandButton(l10n),
        ],
      ),
    );
  }

  Widget _buildExpandButton(AppLocalizations l10n) {
    return TextButton(
      onPressed: _toggleExpanded,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      child: Row(
        children: [
          Text(
            _isExpanded ? l10n.show_less : l10n.show_all, style: Theme.of(context).textTheme.bodySmall,
          ),
          Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: Theme.of(context).iconTheme.color,),
        ],
      ),
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildDomainList(List<Domain> displayedDomains) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: displayedDomains
          .map(
            (entry) => WebButton(
              name: entry.name,
              favIcon: entry.favIcon,
            ),
          )
          .toList(),
    );
  }
}
