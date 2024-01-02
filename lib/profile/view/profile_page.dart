import 'package:flutter/material.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:institute_app/data/auth/firebase_auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_app/application/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  final GetData getData;
  ProfilePage({required this.getData});

  @override
  Widget build(BuildContext context) {
    //assuming user is signed in
    AuthUser authUser = getData._authRepo
        .getSignedInUser()
        .getOrElse(() => AuthUser(id: '', name: '', email: ''));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('User ID: ${authUser.id}'),
              Text('User Name: ${authUser.name}'),
              Text('User Email: ${authUser.email}'),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(const AuthEvent.signedOut());
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/');
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class GetData {
  final FirebaseAuthRepo _authRepo;
  GetData(this._authRepo);
  FirebaseAuthRepo get authRepo => _authRepo;

  void loggerMethod() {
    final fp.Option<AuthUser> signedInUser = _authRepo.getSignedInUser();
    signedInUser.fold(
      () {
        print('User is not signed in');
      },
      (authUser) {
        print('User ID: ${authUser.id}');
        print('User Name: ${authUser.name}');
        print('User Email: ${authUser.email}');
      },
    );
  }
}
