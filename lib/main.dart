import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'config/routes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DS-Fact',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
