import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final pageControllerProvider =
    StateNotifierProvider<PageControllerNotifier, int>((ref) {
  return PageControllerNotifier();
});
class PageControllerNotifier extends StateNotifier<int> {
  final PageController controller;

  PageControllerNotifier() 
      : controller = PageController(),
        super(0);

  void setCurrentPage(int index) {
    state = index;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}