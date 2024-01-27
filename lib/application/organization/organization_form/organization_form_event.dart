part of 'organization_form_bloc.dart';

@freezed
sealed class OrganizationFormEvent with _$OrganizationFormEvent {
  const factory OrganizationFormEvent.initialized(
    Option<Organization> initialOrganizationOption,
  ) = _Initialized;
  const factory OrganizationFormEvent.nameChanged(String nameStr) =
      _NameChanged;
  const factory OrganizationFormEvent.aboutChanged(String aboutStr) =
      _AboutChanged;
  const factory OrganizationFormEvent.sortDescriptionChanged(
    String sortDescriptionStr,
  ) = _SortDescriptionChanged;
  const factory OrganizationFormEvent.logoChanged(String logoStr) =
      _LogoChanged;
  const factory OrganizationFormEvent.websiteChanged(String websiteStr) =
      _WebsiteChanged;
  const factory OrganizationFormEvent.emailChanged(String emailStr) =
      _EmailChanged;
  const factory OrganizationFormEvent.saved() = _Saved;
}
