import 'package:flutter/material.dart';
import 'package:kagi_task/kite_theme.dart';
import 'package:kagi_task/presentation/tabbed_news_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: KiteTheme.light,
      darkTheme: KiteTheme.dark,
      home: const TabbedNewsScreen(),
    );
  }
}
