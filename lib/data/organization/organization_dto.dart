import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/organization/models/organization.dart';

part 'organization_dto.freezed.dart';
part 'organization_dto.g.dart';

@Collection<OrganizationDto>('organizations')
@freezed
class OrganizationDto with _$OrganizationDto {
  factory OrganizationDto({
    @Id() required String id,
    required String name,
    required String about,
    required String sortDescription,
    required String logo,
    required String website,
    required String email,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String creatorId,
    String? parentId,
    List<String>? childrenIds,
  }) = _OrganizationDto;
  const OrganizationDto._();

  factory OrganizationDto.fromJson(Map<String, Object?> json) =>
      _$OrganizationDtoFromJson(json);

  factory OrganizationDto.fromDomain(Organization organization) =>
      OrganizationDto(
        id: organization.id.getOrCrash(),
        name: organization.name.getOrCrash(),
        about: organization.about.getOrCrash(),
        sortDescription: organization.sortDescription.getOrCrash(),
        logo: organization.logo.getOrCrash(),
        website: organization.website.getOrCrash(),
        email: organization.email.getOrCrash(),
        createdAt: organization.createdAt.toUtc(),
        updatedAt: organization.updatedAt.toUtc(),
        creatorId: organization.creatorId.getOrCrash(),
        parentId: organization.parentId?.getOrCrash(),
        childrenIds:
            organization.childrenIds?.map((e) => e.getOrCrash()).toList(),
      );

  Organization toDomain() => Organization(
        id: UniqueId.fromUniqueString(id),
        name: StringSingleLine(name),
        about: StringMultiLine(about),
        sortDescription: StringMultiLine(sortDescription),
        logo: Url(logo),
        website: Url(website),
        email: EmailAddress(email),
        createdAt: createdAt.toLocal(),
        updatedAt: updatedAt.toLocal(),
        creatorId: UniqueId.fromUniqueString(creatorId),
        parentId:
            parentId != null ? UniqueId.fromUniqueString(parentId!) : null,
        childrenIds: childrenIds?.map(UniqueId.fromUniqueString).toList(),
      );
}
