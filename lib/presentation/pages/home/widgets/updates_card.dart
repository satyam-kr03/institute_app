import 'package:flutter/material.dart';

class UpdatesCard extends StatelessWidget {
  const UpdatesCard({
    this.height = 100,
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: height,
        child: const Center(
          child: Text(
            'No Upcoming Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
