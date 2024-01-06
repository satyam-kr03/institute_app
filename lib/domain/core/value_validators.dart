import 'package:fpdart/fpdart.dart';
import 'package:institute_app/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(
  String input,
) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    if (input.endsWith('iitmandi.ac.in')) {
      return right(input);
    } else {
      return left(ValueFailure.nonInstituteEmail(failedValue: input));
    }
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(
  String input,
) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateStringSingleLine(
  String input,
) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(ValueFailure.multiline(failedValue: input));
  }
}
