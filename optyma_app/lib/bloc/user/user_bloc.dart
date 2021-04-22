import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:optyma_app/models/user.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/cloud_firestore_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationRepository _authenticationRepository;
  final CloudFirestoreRepository _cloudFirestoreRepository;
  UserBloc({
    @required AuthenticationRepository authenticationRepository,
    @required CloudFirestoreRepository cloudFirestoreRepository, 
  })
  : assert(authenticationRepository != null),
    assert(cloudFirestoreRepository != null),
    _authenticationRepository = authenticationRepository, 
    _cloudFirestoreRepository = cloudFirestoreRepository,
   super(UserUnitialized());

  @override
  Stream<UserState> mapEventToState(UserEvent event,) async* {
    if( event is UserLoggedIn){
      yield* _mapUserSignedToState();
    }
    if(event is UserLoggedOut){  
      yield* _mapUserLoggedOutToState();
    }
  }


  Stream<UserState> _mapUserSignedToState() async *{
    final userFirebase = _authenticationRepository.getUser();


    final User user = User(
      uid: userFirebase.uid, 
      admin: await _cloudFirestoreRepository.isAdmin(userFirebase.uid), 
      email: userFirebase.email,
      name: userFirebase.displayName
    );

    await _cloudFirestoreRepository.updateUserData(user);


    yield UserInitialized(
      admin : user.admin,
      email : user.email,
      name  : user.name,
      uId   : user.uid
    );
  }

  Stream<UserState> _mapUserLoggedOutToState() async* {
    yield UserUnitialized();
  }


}
