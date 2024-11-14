import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  final List<Map<String, dynamic>> sections;

  const DrawerView({super.key, required this.sections});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, sectionIndex) {
          final section = sections[sectionIndex];
          final sectionTitle = section['title'] as String;
          final sectionItems = section['data'] as List<dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sectionItems.length,
                separatorBuilder: (context, index) =>
                    const Divider(indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final item = sectionItems[index];
                  return ListTile(
                    dense: true,
                    title: Text(item.toString()),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
