part of 'organizations_watcher_cubit.dart';

@freezed
sealed class OrganizationsWatcherState with _$OrganizationsWatcherState {
  const factory OrganizationsWatcherState.initial() = Initial;
  const factory OrganizationsWatcherState.loadInProgress() = LoadInProgress;
  const factory OrganizationsWatcherState.loadSuccess(
    IList<Organization> organizations,
  ) = LoadSuccess;
  const factory OrganizationsWatcherState.loadFailure(
    OrganizationFailure organizationFailure,
  ) = LoadFailure;
}
