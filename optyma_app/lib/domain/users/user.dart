import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/auth/value_objects.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required UniqueId id,
    required EmailAddress emailAddress,
    @Default(false) bool admin,
  }) = _User;

  factory User.empty() => User(
    id: UniqueId.fromUniqueString(''), 
    emailAddress: EmailAddress(''),
  );
}