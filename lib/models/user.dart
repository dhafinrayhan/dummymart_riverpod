import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required Gender gender,
    required String image,
    required String token,
  }) = _User;

  String get fullName => '$firstName $lastName';

  const User._();

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

enum Gender {
  male,
  female,
}
