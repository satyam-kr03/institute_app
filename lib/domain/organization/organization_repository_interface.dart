import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/organization/models/organization.dart';
import 'package:institute_app/domain/organization/models/organization_failure.dart';

abstract class OrganizationRepositoryInterface {
  Stream<Either<OrganizationFailure, IList<Organization>>>
      watchAllOrganizations();
  Future<Either<OrganizationFailure, Unit>> createOrganization(
    Organization organization,
  );
  Future<Either<OrganizationFailure, Unit>> createSubOrganization(
    Organization organization,
    UniqueId parentId,
  );
  Future<Either<OrganizationFailure, Unit>> updateOrganization(
    Organization organization,
  );
  Future<Either<OrganizationFailure, Unit>> deleteOrganization(UniqueId id);
  Future<Either<OrganizationFailure, Organization>> getOrganizationFromId(
    UniqueId id,
  );
}
