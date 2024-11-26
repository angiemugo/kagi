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
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildArrowButton(
            context: context,
            icon: Icons.arrow_back_ios,
            onPressed: selectedTabIndex > 0
                ? () {
                    final previousIndex = selectedTabIndex - 1;
                    _updateSelection(
                      tabIndexNotifier: tabIndexNotifier,
                      categoryNotifier: categoryNotifier,
                      index: previousIndex,
                      categories: categories,
                    );
                  }
                : null,
          ),
          _buildDropdown(
            context: context,
            categories: categories,
            selectedCategory: selectedCategory,
            onChanged: (value) {
              if (value != null) {
                final index = categories.indexOf(value);
                _updateSelection(
                  tabIndexNotifier: tabIndexNotifier,
                  categoryNotifier: categoryNotifier,
                  index: index,
                  categories: categories,
                );
              }
            },
          ),
          _buildArrowButton(
            context: context,
            icon: Icons.arrow_forward_ios,
            onPressed: selectedTabIndex < categories.length - 1
                ? () {
                    final nextIndex = selectedTabIndex + 1;
                    _updateSelection(
                      tabIndexNotifier: tabIndexNotifier,
                      categoryNotifier: categoryNotifier,
                      index: nextIndex,
                      categories: categories,
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        iconSize: 16,
        icon: Icon(icon),
        onPressed: onPressed,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required List<Category> categories,
    required Category selectedCategory,
    required ValueChanged<Category?> onChanged,
  }) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary,
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
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  void _updateSelection({
    required StateController<int> tabIndexNotifier,
    required StateController<Category> categoryNotifier,
    required int index,
    required List<Category> categories,
  }) {
    tabIndexNotifier.state = index;
    categoryNotifier.state = categories[index];
  }
}

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
final selectedCategoryProvider = StateProvider<Category>(
    (ref) => Category(name: "World", color: Colors.black, itemNumber: 0));
