import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:optyma_app/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User{
  UniqueId toDomain() {
    return UniqueId.fromUniqueString(uid);
  }
}