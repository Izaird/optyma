import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:optyma_app/models/user_model.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';

part 'admins_event.dart';
part 'admins_state.dart';

class AdminsBloc extends Bloc<AdminsEvent, AdminsState> {

  final UsersRepository _usersRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription _adminsSubscription;

  AdminsBloc({@required UsersRepository usersRepository, @required AuthenticationRepository authenticationRepository})
    : assert(usersRepository != null),
      assert(authenticationRepository != null),
    _usersRepository = usersRepository,
    _authenticationRepository = authenticationRepository,
    super(AdminsLoadInProgress());

  @override
  Stream<AdminsState> mapEventToState(AdminsEvent event,) async* {
    if(event is AdminsLoaded){
      yield* _mapAdminsLoadedToState();
    }
    if(event is AdminsUpdated){
      yield * _mapAdminsUpdatedToState(event);
    }
  }


  Stream<AdminsState> _mapAdminsLoadedToState() async *{
    yield AdminsLoadInProgress();
    _adminsSubscription?.cancel();
    try {
      _adminsSubscription = _usersRepository.getAdmins(_authenticationRepository.getUser().uid).listen((admins) {
        add(AdminsUpdated(admins));
       });
      // final List<LogroModel> admins = await _usersRepository.getLogros().first;
      // yield AdminsLoaded(admins);
    }
    catch (_) {
      yield AdminsLoadFailure();
    }
  }

  Stream<AdminsState> _mapAdminsUpdatedToState(AdminsUpdated event) async *{
    yield AdminsLoadSuccess(event.admins);
  }


  @override
  Future<void> close() {
    _adminsSubscription?.cancel();
    return super.close();
  }
}
