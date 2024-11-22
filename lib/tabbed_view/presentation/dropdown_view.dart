import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_task/tabbed_view/presentation/tabbed_news_controller.dart';

class DropdownView extends ConsumerWidget {
  final List<Category> categories;

  const DropdownView({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedTabIndex = ref.watch(selectedTabIndexProvider);
    final tabIndexNotifier = ref.read(selectedTabIndexProvider.notifier);
    final categoryNotifier = ref.read(selectedCategoryProvider.notifier);

    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              iconSize: 16,
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                if (selectedTabIndex > 0) {
                  tabIndexNotifier.state = selectedTabIndex - 1;
                  categoryNotifier.state = categories[selectedTabIndex - 1];
                }
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: DropdownButton<Category>(
                  padding: EdgeInsets.zero,
                  value: selectedCategory,
                  underline: const SizedBox.shrink(),
                  items: categories
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final index = categories.indexOf(value);
                      categoryNotifier.state = value;
                      tabIndexNotifier.state = index;
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              iconSize: 16,
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
              onPressed: () {
                if (selectedTabIndex < categories.length - 1) {
                  tabIndexNotifier.state = selectedTabIndex + 1;
                  categoryNotifier.state = categories[selectedTabIndex + 1];
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
final selectedCategoryProvider = StateProvider<Category>(
    (ref) => Category(name: "World", color: Colors.black));
