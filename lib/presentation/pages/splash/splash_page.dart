import 'package:flutter/material.dart';
import 'package:institute_app/presentation/widgets/logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLogo(),
      ),
    );
  }
}
