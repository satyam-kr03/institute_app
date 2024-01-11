part of 'user_form_bloc.dart';

@freezed
sealed class UserFormState with _$UserFormState {
  const factory UserFormState({
    required User user,
    required bool isEditing,
    required bool isSaving,
    required bool showErrorMessages,
    required Option<Either<UserFailure, Unit>>
        saveFailureOrSuccessOption,
  }) = _UserFormState;

  factory UserFormState.initial() => UserFormState(
        user: User.empty(),
        isEditing: false,
        isSaving: false,
        showErrorMessages: false,
        saveFailureOrSuccessOption: none(),
      );
}
