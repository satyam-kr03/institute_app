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
        SliverAppBar(
          actions: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is LoadSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ProfilePhoto(
                      user: state.user,
                      onTap: () => context.push(const ProfileRoute().location),
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
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 200,
                child: PageView(
                  children: const [
                    CustomImageContainer(
                      imageUrl:
                          'https://i.pinimg.com/564x/e3/e3/11/e3e311f1f7a665f8b3877dcfa598cc90.jpg',
                      logoUrl:
                          'https://logogen.gdscasu.com/logos/gdsc-logo.png',
                      organizationName: 'GDSC IIT Mandi',
                      headline: 'KrackHack 2024',
                      description: '',
                    ),
                    CustomImageContainer(
                      imageUrl:
                          'https://example.com/second-image.jpg',
                      logoUrl:
                          'https://example.com/second-logo.png',
                      organizationName: 'Second Organization',
                      headline: 'Second Event', description: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    required this.imageUrl, required this.logoUrl,
    required this.organizationName,
    required this.headline, required this.description, super.key,
  });

  final String imageUrl;
  final String logoUrl;
  final String organizationName;
  final String headline;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              imageUrl: imageUrl,
              headline: headline,
              description: description,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.network(
                              logoUrl,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              organizationName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      headline,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.imageUrl,
    required this.headline,
    required this.description,
    super.key,
  });

  final String imageUrl;
  final String headline;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200, // Adjust as needed
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                headline,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
