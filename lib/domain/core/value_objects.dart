import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:institute_app/domain/core/errors.dart';
import 'package:institute_app/domain/core/failures.dart';
import 'package:institute_app/domain/core/value_validators.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    return value.fold(
      (f) => throw UnexpectedValueError(f),
      (r) => r,
    );
  }

  /// Either returns the failure or the unit value
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      left,
      (r) => right(unit),
    );
  }

  // Returns the value if it's valid or a default value otherwise
  T getOr(T defaultValue) {
    return value.fold(
      (f) => defaultValue,
      (r) => r,
    );
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class UniqueId extends ValueObject<String> {
  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class StringSingleLine extends ValueObject<String> {
  factory StringSingleLine(String input) {
    return StringSingleLine._(
      validateStringSingleLine(input),
    );
  }

  const StringSingleLine._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class StringMultiLine extends ValueObject<String> {
  factory StringMultiLine(String input) {
    return StringMultiLine._(
      validateMaxStringLength(input, 1000).flatMap(validateStringNotEmpty),
    );
  }

  const StringMultiLine._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Url extends ValueObject<String> {
  factory Url(String input) {
    return Url._(
      validateUrl(input),
    );
  }

  const Url._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
