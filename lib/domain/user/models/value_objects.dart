import 'package:fpdart/fpdart.dart';
import 'package:institute_app/domain/core/failures.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/core/value_validators.dart';

class UserBio extends ValueObject<String> {
  factory UserBio(String input) {
    return UserBio._(validateMaxStringLength(input, 150));
  }

  factory UserBio.empty() => UserBio('');

  const UserBio._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
