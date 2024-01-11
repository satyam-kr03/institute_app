import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/user/user_cubit.dart';
import 'package:institute_app/application/user/user_form/user_form_bloc.dart';
import 'package:institute_app/domain/user/models/user_failure.dart';
import 'package:institute_app/injection.dart';
import 'package:institute_app/presentation/pages/profile/widgets/profile_form.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      bloc: getIt<UserCubit>()..fetchUser(),
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
        );
      },
      builder: (context, state) {
        switch (state) {
          case LoadFailure(:final userFailure):
            if (userFailure is NotFound) {
              return BlocProvider(
                create: (context) => getIt<UserFormBloc>()
                  ..add(
                    const Initialized(
                      isEditing: false,
                    ),
                  ),
                child: const ProfileForm(isEditing: false),
              );
            }
          case Initial():
          case LoadInProgress():
            return ColoredBox(
              color: Theme.of(context).canvasColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoadSuccess(:final user):
            return BlocProvider(
              create: (context) => getIt<UserFormBloc>()
                ..add(
                  Initialized(
                    isEditing: true,
                    user: user,
                  ),
                ),
              child: const ProfileForm(isEditing: true),
            );
        }
        return Container();
      },
    );
  }
}
