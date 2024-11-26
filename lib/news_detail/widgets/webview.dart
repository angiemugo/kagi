import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewControllerProvider =
    Provider.autoDispose.family<WebViewControllerWithLoading, String>((ref, link) {
  final controller = WebViewControllerWithLoading(link: link);
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class WebViewControllerWithLoading {
  final WebViewController controller = WebViewController();
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  WebViewControllerWithLoading({required String link}) {
    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => isLoading.value = true,
          onPageFinished: (_) => isLoading.value = false,
        ),
      )
      ..loadRequest(Uri.parse(link));
  }

  void dispose() {
    isLoading.dispose();
    controller.clearCache();
  }
}

class Webview extends ConsumerWidget {
  final String link;

  const Webview({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewController = ref.watch(webViewControllerProvider(link));
    final isLoading = webViewController.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController.controller),
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              if (loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
