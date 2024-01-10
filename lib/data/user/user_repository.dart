import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/data/user/user_dto.dart';
import 'package:institute_app/domain/auth/auth_interface.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/user/models/user.dart';
import 'package:institute_app/domain/user/models/user_failure.dart';
import 'package:institute_app/domain/user/user_repository_interface.dart';

@LazySingleton(as: UserRepositoryInterface)
class UserRepository implements UserRepositoryInterface {
  UserRepository({
    required AuthInterface authRepo,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _authRepo = authRepo;

  final AuthInterface _authRepo;
  final FirebaseFirestore _firestore;

  @override
  Future<Either<UserFailure, Unit>> createUser(User user) {
    try {
      final userCollection = UserDtoCollectionReference(_firestore);
      final userDto = UserDto.fromDomain(user);
      userCollection.doc(userDto.id).set(userDto);

      return Future.value(right(unit));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Future.value(
          left(const UserFailure.insufficientPermission()),
        );
      } else {
        return Future.value(left(const UserFailure.unexpected()));
      }
    }
  }

  @override
  Future<Either<UserFailure, Unit>> deleteUser(UniqueId id) {
    try {
      final userCollection = UserDtoCollectionReference(_firestore);
      userCollection.doc(id.getOrCrash()).delete();

      return Future.value(right(unit));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Future.value(
          left(const UserFailure.insufficientPermission()),
        );
      } else if (e.code == 'not-found') {
        return Future.value(
          left(const UserFailure.notFound()),
        );
      } else {
        return Future.value(left(const UserFailure.unexpected()));
      }
    }
  }

  @override
  Future<Option<User>> getCurrentUser() async {
    try {
      final userCollection = UserDtoCollectionReference(_firestore);
      final authUserOption = _authRepo.getSignedInUser();
      final userSnapshot = await userCollection
          .doc(authUserOption.toNullable()!.id.getOrCrash())
          .get();

      if (userSnapshot.exists) {
        return optionOf(userSnapshot.data?.toDomain());
      } else {
        return none();
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        log('Error getting current user: ${e.message}');
      }
      return none();
    }
  }

  @override
  Future<Either<UserFailure, User>> getUserFromId(UniqueId id) async {
    try {
      final userCollection = UserDtoCollectionReference(_firestore);
      final userSnapshot =
          await userCollection.doc(id.getOrCrash()).get();

      if (userSnapshot.exists) {
        return Future.value(
          right(userSnapshot.data!.toDomain()),
        );
      } else {
        return Future.value(
          left(const UserFailure.notFound()),
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Future.value(
          left(const UserFailure.insufficientPermission()),
        );
      } else if (e.code == 'not-found') {
        return Future.value(
          left(const UserFailure.notFound()),
        );
      } else {
        return Future.value(left(const UserFailure.unexpected()));
      }
    }
  }

  @override
  Future<Either<UserFailure, Unit>> updateUser(User user) {
    try {
      final userCollection = UserDtoCollectionReference(_firestore);
      final userDto = UserDto.fromDomain(user);
      userCollection.doc(userDto.id).update();

      return Future.value(right(unit));
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return Future.value(
          left(const UserFailure.insufficientPermission()),
        );
      } else if (e.code == 'not-found') {
        return Future.value(
          left(const UserFailure.notFound()),
        );
      } else {
        return Future.value(left(const UserFailure.unexpected()));
      }
    }
  }

  @override
  Future<Option<User>> getInitialUserFromAuth() async {
    try {
      final authUser = _authRepo.getSignedInUser().toNullable();

      if (authUser == null) {
        return none();
      }
      final user = User.fromAuthUser(authUser);

      return some(user);
    } on Exception catch (e) {
      if (kDebugMode) {
        log('Error getting current user: $e');
      }
      return none();
    }
  }
}
