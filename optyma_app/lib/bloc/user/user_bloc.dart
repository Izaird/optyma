import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:optyma_app/models/user.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {


  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _cloudFirestoreRepository;

  UserBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UsersRepository cloudFirestoreRepository, 
  })
  : assert(authenticationRepository != null),
    assert(cloudFirestoreRepository != null),
    _authenticationRepository = authenticationRepository, 
    _cloudFirestoreRepository = cloudFirestoreRepository,
   super(UserUnitialized());

  @override
  Stream<UserState> mapEventToState(UserEvent event,) async* {
    if( event is UserLoggedIn){
      yield* _mapUserLoggedInToState();
    }
    if(event is UserSignedUp){
      yield* _mapUserSignedUpToState(event.name);
    }
    if(event is UserLoggedOut){  
      yield* _mapUserLoggedOutToState();
    }
  }


  Stream<UserState> _mapUserLoggedInToState() async *{
    final userFirebase = _authenticationRepository.getUser();

    User user;

    // If the user registered with an email the "displayName" 
    // parameter will be null so we will read from the database 
    // where we have previously inserted the user's name
    if (userFirebase.displayName != null){
      user = User(
        uid: userFirebase.uid, 
        admin: await _cloudFirestoreRepository.isAdmin(userFirebase.uid), 
        email: userFirebase.email,
        name: userFirebase.displayName
      );
    }

    else{
      user = User(
        uid: userFirebase.uid, 
        admin: await _cloudFirestoreRepository.isAdmin(userFirebase.uid), 
        email: userFirebase.email,
        name: await _cloudFirestoreRepository.getUserName(userFirebase.uid)
      );
    }


    await _cloudFirestoreRepository.updateUserData(user);


    yield UserInitialized(
      admin : user.admin,
      email : user.email,
      name  : user.name,
      uId   : user.uid
    );
  }

  Stream<UserState> _mapUserSignedUpToState(String name)async* {
    final userFirebase = _authenticationRepository.getUser();
    final userId = userFirebase.uid; 

    await _cloudFirestoreRepository.updateUserName(name, userId);
  }

  Stream<UserState> _mapUserLoggedOutToState() async* {
    yield UserUnitialized();
  }


}
