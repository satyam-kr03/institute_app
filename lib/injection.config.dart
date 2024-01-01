// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:institute_app/application/auth/auth_bloc.dart' as _i7;
import 'package:institute_app/data/auth/firebase_auth_repo.dart' as _i6;
import 'package:institute_app/data/common/injectable_modules.dart' as _i8;
import 'package:institute_app/domain/auth/auth_interface.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModules = _$FirebaseModules();
    gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseModules.firebaseAuth);
    gh.lazySingleton<_i4.GoogleSignIn>(() => firebaseModules.googleSignIn);
    gh.lazySingleton<_i5.AuthInterface>(() => _i6.FirebaseAuthRepo(
          firebaseAuth: gh<_i3.FirebaseAuth>(),
          googleSignIn: gh<_i4.GoogleSignIn>(),
        ));
    gh.factory<_i7.AuthBloc>(
        () => _i7.AuthBloc(authInterface: gh<_i5.AuthInterface>()));
    return this;
  }
}

class _$FirebaseModules extends _i8.FirebaseModules {}
