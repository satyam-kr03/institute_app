import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.size = 154,
    super.key,
  });

  final double size;

  static const _logo = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: SizedBox(
        width: size,
        height: size,
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(_logo),
        ),
      ),
    );
  }
}
