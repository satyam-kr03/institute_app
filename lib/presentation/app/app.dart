import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';
import 'package:institute_app/home/view/homepage.dart';
import 'package:institute_app/injection.dart';
import 'package:institute_app/presentation/app/splash_page.dart';

class InstituteApp extends StatelessWidget {
  const InstituteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()
            ..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Institute App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigate to HomePage when authenticated
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
          child: const SplashPage(),
        ),
      ),
    );
  }
}
