import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/organization/models/organization.dart';
import 'package:institute_app/domain/organization/models/organization_failure.dart';
import 'package:institute_app/domain/organization/organization_repository_interface.dart';

part 'organizations_watcher_cubit.freezed.dart';
part 'organizations_watcher_state.dart';

class OrganizationsWatcherCubit extends Cubit<OrganizationsWatcherState> {
  OrganizationsWatcherCubit(this._organizationRepositoryInterface)
      : super(const OrganizationsWatcherState.initial());
  final OrganizationRepositoryInterface _organizationRepositoryInterface;

  Stream<void> watchAllOrganizations() async* {
    emit(const OrganizationsWatcherState.loadInProgress());
    _organizationRepositoryInterface.watchAllOrganizations().listen(
      (failureOrOrganizations) {
        failureOrOrganizations.fold(
          (failure) => emit(OrganizationsWatcherState.loadFailure(failure)),
          (organizations) =>
              emit(OrganizationsWatcherState.loadSuccess(organizations)),
        );
      },
    );
  }
}
