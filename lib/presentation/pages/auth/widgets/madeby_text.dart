import 'package:flutter/material.dart';

class MadeByText extends StatelessWidget {
  const MadeByText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Made with ❤️ by SNTC, IIT Mandi',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
