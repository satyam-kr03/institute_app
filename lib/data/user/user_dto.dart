import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/user/models/user.dart';
import 'package:institute_app/domain/user/models/value_objects.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@Collection<UserDto>('users')
@freezed
class UserDto with _$UserDto {
  factory UserDto({
    @Id() required String id,
    required String name,
    required String email,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? photoUrl,
    String? bio,
  }) = _UserDto;
  const UserDto._();

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromDomain(User user) => UserDto(
        id: user.id.getOrCrash(),
        name: user.name.getOrCrash(),
        email: user.emailAddress.getOrCrash(),
        createdAt: user.createdAt.toUtc(),
        updatedAt: user.updatedAt.toUtc(),
        photoUrl: user.photoUrl?.getOrCrash(),
        bio: user.bio?.getOrCrash(),
      );

  User toDomain() => User(
        id: UniqueId.fromUniqueString(id),
        name: StringSingleLine(name),
        emailAddress: EmailAddress(email),
        createdAt: createdAt.toLocal(),
        updatedAt: updatedAt.toLocal(),
        photoUrl: photoUrl != null ? Url(photoUrl!) : null,
        bio: bio != null ? UserBio(bio!) : null,
      );
}

final userDtoRef = UserDtoCollectionReference();
