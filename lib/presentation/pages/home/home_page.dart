import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:institute_app/application/user/user_cubit.dart';
import 'package:institute_app/presentation/pages/home/widgets/resources_grid.dart';
import 'package:institute_app/presentation/pages/home/widgets/updates_card.dart';
import 'package:institute_app/presentation/routes/router.dart';
import 'package:institute_app/presentation/widgets/profile_photo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.medium(
          actions: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is LoadSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ProfilePhoto(
                      user: state.user,
                      onTap: () =>
                          context.push(const ProfileRoute().location),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
          title: const Text(
            'Welcome User',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        const SliverToBoxAdapter(
          child: UpdatesCard(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        const ResourcesGrid(),
      ],
    );
  }
}
