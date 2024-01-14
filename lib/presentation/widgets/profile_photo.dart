import 'package:flutter/material.dart';
import 'package:institute_app/domain/user/models/user.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    required this.user,
    this.size = 100,
    this.onTap,
    super.key,
  });

  final User user;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          image: user.photoUrl != null && user.photoUrl!.isValid()
              ? DecorationImage(
                  image: NetworkImage(
                    user.photoUrl!.value.fold(
                      (l) => '',
                      (r) => r,
                    ),
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Center(
          child: user.photoUrl == null || !user.photoUrl!.isValid()
              ? Text(
                  user.name.getOrCrash().substring(0, 1),
                  style: TextStyle(
                    fontSize: size / 2,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
