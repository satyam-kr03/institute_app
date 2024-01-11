part of 'user_cubit.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loadInProgress() = LoadInProgress;
  const factory UserState.loadSuccess(User user) = LoadSuccess;
  const factory UserState.loadFailure(UserFailure userFailure) =
      LoadFailure;
}
