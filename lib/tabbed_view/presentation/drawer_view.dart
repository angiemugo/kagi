import 'package:flutter/material.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';

class DrawerView extends StatelessWidget {
  final List<String> settings;
  final List<Category> categories;

  const DrawerView({
    super.key,
    required this.settings,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final combinedItems = <Widget>[
      ...settings.map((setting) => ListTile(title: Text(setting))),
      const SizedBox(height: 32,),
      ...categories.map((category) {
        return ListTile(
          title: Row(
            children: [
              Text(category.name),
              const SizedBox(width: 4,),
              Text(
                "${category.itemNumber}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      }),
    ];

    return Drawer(
      child: ListView.separated(
        itemCount: combinedItems.length,
        separatorBuilder: (context, index) => const Divider(
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          return combinedItems[index];
        },
      ),
    );
  }
}
