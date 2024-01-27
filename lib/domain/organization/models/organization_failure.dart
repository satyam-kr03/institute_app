import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_failure.freezed.dart';

@freezed
abstract class OrganizationFailure with _$OrganizationFailure {
  const factory OrganizationFailure.unexpected() = Unexpected;
  const factory OrganizationFailure.insufficientPermission() =
      InsufficientPermission;
  const factory OrganizationFailure.notFound() = NotFound;
  const factory OrganizationFailure.unableToUpdate() = UnableToUpdate;
  const factory OrganizationFailure.unableToCreate() = UnableToCreate;
  const factory OrganizationFailure.unableToDelete() = UnableToDelete;
}
