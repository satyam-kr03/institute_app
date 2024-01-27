part of 'organization_form_bloc.dart';

@freezed
abstract class OrganizationFormState with _$OrganizationFormState {
  const factory OrganizationFormState({
    required Organization organization,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<OrganizationFailure, Unit>>
        saveFailureOrSuccessOption,
  }) = _OrganizationFormState;

  factory OrganizationFormState.initial() => OrganizationFormState(
        organization: Organization.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
