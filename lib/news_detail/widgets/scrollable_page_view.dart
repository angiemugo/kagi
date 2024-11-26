import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:kagi_task/news_detail/presentation/page_controller.dart';

class ScrollablePageView extends ConsumerWidget {
  final List<Widget> views;
  final String location;

  const ScrollablePageView({
    super.key,
    required this.views,
    required this.location,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageControllerProvider);
    final controller = ref.read(pageControllerProvider.notifier).controller;

    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          _buildPageView(controller, ref),
          const SizedBox(height: 8),
          _buildDotsIndicator(context, currentPage),
          const SizedBox(height: 8),
                  if (location.isNotEmpty)
          _buildLocationRow(location),
        ],
      ),
    );
  }

  Widget _buildPageView(PageController controller, WidgetRef ref) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: views.length,
        itemBuilder: (context, index) => views[index],
        onPageChanged: (index) {
          ref.read(pageControllerProvider.notifier).setCurrentPage(index);
        },
      ),
    );
  }

  Widget _buildDotsIndicator(BuildContext context, int currentPage) {
    final decorator = DotsDecorator(
      size: const Size.square(10.0),
      activeSize: const Size.square(10.0),
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      activeColor: Theme.of(context).colorScheme.onSurface,
      spacing: const EdgeInsets.all(4.0),
    );

    return DotsIndicator(
      dotsCount: views.length,
      position: currentPage,
      axis: Axis.horizontal,
      decorator: decorator,
    );
  }

  Widget _buildLocationRow(String location) {
    return Row(
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
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
