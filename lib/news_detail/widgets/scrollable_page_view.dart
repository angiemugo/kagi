import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:kagi_task/news_detail/presentation/page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollablePageView extends ConsumerWidget {
  final List<Widget> views;
  final String location;

  const ScrollablePageView(
      {super.key, required this.views, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageControllerProvider);

    final decorator = DotsDecorator(
      size: const Size.square(10.0),
      activeSize: const Size.square(10.0),
      color: Colors.grey.shade300,
      activeColor: Colors.grey.shade800,
      spacing: const EdgeInsets.all(4.0),
    );

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: ref.read(pageControllerProvider.notifier).controller,
              itemCount: views.length,
              itemBuilder: (context, index) {
                return views[index];
              },
              onPageChanged: (index) {
                ref.read(pageControllerProvider.notifier).setCurrentPage(index);
              },
            ),
          ),
          const SizedBox(height: 8),
          DotsIndicator(
            dotsCount: views.length,
            position: currentPage,
            axis: Axis.horizontal,
            decorator: decorator,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.place_outlined,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
