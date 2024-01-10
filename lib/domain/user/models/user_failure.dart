import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_failure.freezed.dart';

@freezed
abstract class UserFailure with _$UserFailure {
  const factory UserFailure.unexpected() = Unexpected;
  const factory UserFailure.insufficientPermission() =
      InsufficientPermission;
  const factory UserFailure.notFound() = NotFound;
  const factory UserFailure.unableToUpdate() = UnableToUpdate;
  const factory UserFailure.unableToCreate() = UnableToCreate;
  const factory UserFailure.unableToDelete() = UnableToDelete;
}
