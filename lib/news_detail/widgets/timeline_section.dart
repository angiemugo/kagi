import 'package:flutter/material.dart';

class TimelineSection extends StatelessWidget {
  final List<String> timeline;
  final String title;

  const TimelineSection(
      {super.key, required this.title, required this.timeline});

  List<Map<String, String>> _extractDate({required List<String> dates}) {
    final RegExp pattern = RegExp(r"([A-Za-z]+\s\d{1,2},\s\d{4})::\s*(.*)");
    List<Map<String, String>> group = [];

    for (var date in dates) {
      final RegExpMatch? match = pattern.firstMatch(date);
      if (match != null) {
        String extractedDate = match.group(1) ?? "";
        String sentence = match.group(2) ?? "";
        var dictionary = <String, String>{};
        dictionary["date"] = extractedDate;
        dictionary["description"] = sentence;
        group.add(dictionary);
      }
    }

    return group;
  }

  @override
  Widget build(BuildContext context) {
    final events = _extractDate(dates: timeline);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            events.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNumberWidget(index: index),
                    const SizedBox(width: 20),
                    _buildSeparator(index: index, event: events[index]),
                    const SizedBox(width: 20),
                    Expanded(
                        child:
                            _buildTimelineView(context, event: events[index]))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberWidget({required int index}) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Text(
        "${index + 1}",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSeparator(
      {required int index, required Map<String, String> event}) {
    return SizedBox(
      width: 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
              color: Colors.blue.withOpacity(0.5),
              height: _getTimelineHeight(event: event));
        },
      ),
    );
  }

  double _getTimelineHeight({required Map<String, String> event}) {
    final textLength = (event["description"] ?? "").length;
    return 60 + (textLength / 50) * 20;
  }

  Widget _buildTimelineView(BuildContext context,
      {required Map<String, String> event}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event["date"] ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.blue),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        const SizedBox(height: 4),
        Text(
          event["description"] ?? "",
          style: Theme.of(context).textTheme.bodyMedium,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
