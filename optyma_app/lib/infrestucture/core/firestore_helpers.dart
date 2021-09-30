import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optyma_app/domain/auth/i_auth_facade.dart';
import 'package:optyma_app/domain/core/errors.dart';
import 'package:optyma_app/injection.dart';

extension FirestoreX on FirebaseFirestore{
  Future<DocumentReference> userDocument() async{
    final userIdOption = await getIt<IAuthFacade>().getSignedInUserId();
    final userId = userIdOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance
      .collection('users')
      .doc(userId.getOrCrash());
  }

  Future<CollectionReference> userReference() async{
    return FirebaseFirestore.instance
      .collection('users');
  }
}

// extension DocumentReferenceX on DocumentReference{
//   CollectionReference get usersCollection => collection('users');
// }