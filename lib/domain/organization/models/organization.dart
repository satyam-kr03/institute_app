import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/failures.dart';
import 'package:institute_app/domain/core/value_objects.dart';

part 'organization.freezed.dart';

@freezed
abstract class Organization with _$Organization {
  const factory Organization({
    required UniqueId id,
    required StringSingleLine name,
    required StringMultiLine about,
    required StringMultiLine sortDescription,
    required Url logo,
    required Url website,
    required EmailAddress email,
    required DateTime createdAt,
    required DateTime updatedAt,
    required UniqueId creatorId,
    UniqueId? parentId,
    List<UniqueId>? childrenIds,
  }) = _Organization;

  factory Organization.empty() => Organization(
        id: UniqueId(),
        name: StringSingleLine(''),
        about: StringMultiLine(' '),
        sortDescription: StringMultiLine(' '),
        logo: Url('https://example.com'),
        website: Url('https://example.com'),
        email: EmailAddress('email@iitmandi.ac.in'),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        creatorId: UniqueId(),
      );
}

extension OrganizationX on Organization {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(() => about.failureOrUnit)
        .andThen(() => sortDescription.failureOrUnit)
        .andThen(() => logo.failureOrUnit)
        .andThen(() => website.failureOrUnit)
        .andThen(() => email.failureOrUnit)
        .fold(
          some,
          (_) => none(),
        );
  }
}
