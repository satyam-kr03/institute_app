import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/domain/user/models/user.dart';
import 'package:institute_app/domain/user/models/user_failure.dart';
import 'package:institute_app/domain/user/user_repository_interface.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepositoryInterface)
      : super(const UserState.initial());
  final UserRepositoryInterface _userRepositoryInterface;

  Future<void> fetchUser() async {
    emit(const UserState.loadInProgress());
    final userOption = await _userRepositoryInterface.getCurrentUser();
    userOption.fold(
      () => emit(const UserState.loadFailure(UserFailure.notFound())),
      (user) => emit(UserState.loadSuccess(user)),
    );
  }
}
