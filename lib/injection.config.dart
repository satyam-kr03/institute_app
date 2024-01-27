// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:institute_app/application/auth/auth_bloc.dart' as _i12;
import 'package:institute_app/application/user/user_cubit.dart' as _i13;
import 'package:institute_app/application/user/user_form/user_form_bloc.dart'
    as _i14;
import 'package:institute_app/data/auth/firebase_auth_repo.dart' as _i9;
import 'package:institute_app/data/common/injectable_modules.dart' as _i15;
import 'package:institute_app/data/organization/organization_repository.dart'
    as _i7;
import 'package:institute_app/data/user/user_repository.dart' as _i11;
import 'package:institute_app/domain/auth/auth_interface.dart' as _i8;
import 'package:institute_app/domain/organization/organization_repository_interface.dart'
    as _i6;
import 'package:institute_app/domain/user/user_repository_interface.dart'
    as _i10;

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
    gh.lazySingleton<_i4.FirebaseFirestore>(() => firebaseModules.firestore);
    gh.lazySingleton<_i5.GoogleSignIn>(() => firebaseModules.googleSignIn);
    gh.lazySingleton<_i6.OrganizationRepositoryInterface>(() =>
        _i7.OrganizationRepository(firestore: gh<_i4.FirebaseFirestore>()));
    gh.lazySingleton<_i8.AuthInterface>(() => _i9.FirebaseAuthRepo(
          firebaseAuth: gh<_i3.FirebaseAuth>(),
          googleSignIn: gh<_i5.GoogleSignIn>(),
        ));
    gh.lazySingleton<_i10.UserRepositoryInterface>(() => _i11.UserRepository(
          authRepo: gh<_i8.AuthInterface>(),
          firestore: gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i12.AuthBloc>(
        () => _i12.AuthBloc(authInterface: gh<_i8.AuthInterface>()));
    gh.factory<_i13.UserCubit>(
        () => _i13.UserCubit(gh<_i10.UserRepositoryInterface>()));
    gh.factory<_i14.UserFormBloc>(
        () => _i14.UserFormBloc(gh<_i10.UserRepositoryInterface>()));
    return this;
  }
}

class _$FirebaseModules extends _i15.FirebaseModules {}
