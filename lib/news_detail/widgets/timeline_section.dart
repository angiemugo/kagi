import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/util/string_splitter.dart';

class TimelineSection extends StatelessWidget {
  final List<String> timeline;
  final String title;

  const TimelineSection({
    super.key,
    required this.title,
    required this.timeline,
  });

  List<Map<String, String>> _extractEvents(List<String> dates) {
    final RegExp pattern = RegExp(r"([A-Za-z]+\s\d{1,2},\s\d{4})::\s*(.*)");
    return dates
        .map((date) {
          return date.splitOrExtract(pattern: pattern);
        })
        .where((event) => event != null)
        .cast<Map<String, String>>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final events = _extractEvents(timeline);
    
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
          Column(
            children: List.generate(events.length, (index) {
              final event = events[index];
              return _buildTimelineRow(
                context,
                index,
                event,
                isLast: index == events.length - 1,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineRow(
    BuildContext context,
    int index,
    Map<String, String> event, {
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _buildNumberWidget(index, context),
            const SizedBox(
              height: 8.0,
            ),
            if (!isLast) _buildLineSegment(),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimelineDetails(context, event),
        ),
      ],
    );
  }

  Widget _buildNumberWidget(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: linkBlue,
        shape: BoxShape.circle,
      ),
      child: Text(
        "${index + 1}",
        style: Theme.of(context).textTheme.bodyMedium
      ),
    );
  }

  Widget _buildLineSegment() {
    return Container(
      width: 1,
      height: 30,
      color: linkBlue,
    );
  }

  Widget _buildTimelineDetails(
      BuildContext context, Map<String, String> event) {
    final eventDate = event["date"]!;
    final eventDescription = event["description"]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                eventDate,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: linkBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (eventDescription.isNotEmpty)
          Text(
            eventDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
