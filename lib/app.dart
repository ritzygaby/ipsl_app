import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'main_scaffold.dart';

class IPSLApp extends StatelessWidget {
  const IPSLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPSL',
      theme: AppTheme.lightTheme,
      home: const MainScaffold(),
    );
  }
}
