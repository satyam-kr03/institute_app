import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/exceptions.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/organization/models/organization.dart';
import 'package:institute_app/domain/organization/models/organization_failure.dart';
import 'package:institute_app/domain/organization/organization_repository_interface.dart';
import 'package:institute_app/domain/user/user_repository_interface.dart';

part 'organization_form_bloc.freezed.dart';
part 'organization_form_event.dart';
part 'organization_form_state.dart';

class OrganizationFormBloc
    extends Bloc<OrganizationFormEvent, OrganizationFormState> {
  OrganizationFormBloc({
    required OrganizationRepositoryInterface organizationRepositoryInterface,
    required UserRepositoryInterface userRepositoryInterface,
  })  : _organizationRepositoryInterface = organizationRepositoryInterface,
        _userRepositoryInterface = userRepositoryInterface,
        super(OrganizationFormState.initial()) {
    on<OrganizationFormEvent>((event, emit) async {
      switch (event) {
        case _Initialized(:final initialOrganizationOption):
          initialOrganizationOption.fold(
            () async {
              final userOption =
                  await _userRepositoryInterface.getCurrentUser();
              final user = userOption.fold(
                () => throw NotAuthenticatedException('User not authenticated'),
                (user) => user,
              );
              emit(
                state.copyWith(
                  organization: state.organization.copyWith(
                    creatorId: user.id,
                  ),
                ),
              );
            },
            (initialOrganization) => emit(
              state.copyWith(
                organization: initialOrganization,
                isEditing: true,
              ),
            ),
          );
        case _NameChanged(:final nameStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                name: StringSingleLine(nameStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _AboutChanged(:final aboutStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                about: StringMultiLine(aboutStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _SortDescriptionChanged(:final sortDescriptionStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                sortDescription: StringMultiLine(sortDescriptionStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _LogoChanged(:final logoStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                logo: Url(logoStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _WebsiteChanged(:final websiteStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                website: Url(websiteStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _EmailChanged(:final emailStr):
          emit(
            state.copyWith(
              organization: state.organization.copyWith(
                email: EmailAddress(emailStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case _Saved():
          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );
          Either<OrganizationFailure, Unit> failureOrSuccess;
          if (state.organization.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _organizationRepositoryInterface.updateOrganization(
                    state.organization,
                  )
                : await _organizationRepositoryInterface.createOrganization(
                    state.organization,
                  );
          } else {
            failureOrSuccess = state.saveFailureOrSuccessOption.fold(
              () => right(unit),
              (a) => a,
            );
          }
          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
      }
    });
  }
  final OrganizationRepositoryInterface _organizationRepositoryInterface;
  final UserRepositoryInterface _userRepositoryInterface;
}
