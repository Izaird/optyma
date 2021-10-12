import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optyma_app/domain/auth/value_objects.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/users/user.dart';

part 'user_dtos.freezed.dart';
part 'user_dtos.g.dart';

@freezed
class UserDto with _$UserDto{

  const factory UserDto({
    @JsonKey(ignore: true) String? id,
    required String emailAddress,
    required bool admin,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromDomain(User user){
    return UserDto(
      emailAddress: user.emailAddress.getOrCrash(),
      admin: user.admin
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  factory UserDto.fromFirestore(DocumentSnapshot doc){
    return UserDto.fromJson(doc.data()! as Map<String, dynamic>)
      .copyWith(id: doc.id);
  }

  User toDomain(){
    return User(
      id: UniqueId.fromUniqueString(id!),
      emailAddress: EmailAddress(emailAddress),
      admin: admin
    );
  }
}



class ServerTimeStampConverter implements JsonConverter<FieldValue, Object>{
  const ServerTimeStampConverter();

  @override 
  FieldValue fromJson(Object json){
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}