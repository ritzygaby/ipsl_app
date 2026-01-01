import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_page.dart';

class IPSLApp extends StatelessWidget {
  const IPSLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPSL',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
