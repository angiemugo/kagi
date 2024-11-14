import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewControllerProvider =
    Provider.autoDispose.family<WebViewController, String>((ref, link) {
  final controller = WebViewController();
  controller.loadRequest(Uri.parse(link));
  ref.onDispose(() {
    controller.clearCache();
  });
  return controller;
});

class Webview extends ConsumerWidget {
  final String link;

  const Webview({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(webViewControllerProvider(link));

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
