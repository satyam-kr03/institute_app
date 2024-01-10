part of 'user_form_bloc.dart';

@freezed
sealed class UserFormEvent with _$UserFormEvent {
  const factory UserFormEvent.initialized({
    required bool isEditing,
    User? user,
  }) = Initialized;
  const factory UserFormEvent.nameChanged(String nameStr) = NameChanged;
  const factory UserFormEvent.photoUrlChanged(String photoUrlStr) =
      PhotoUrlChanged;
  const factory UserFormEvent.bioChanged(String bioStr) = BioChanged;
  const factory UserFormEvent.saved() = Saved;
}
