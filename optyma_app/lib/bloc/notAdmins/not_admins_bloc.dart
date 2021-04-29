import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:optyma_app/models/user_model.dart';
import 'package:optyma_app/repository/authentication_repository.dart';
import 'package:optyma_app/repository/users_repository.dart';

part 'not_admins_event.dart';
part 'not_admins_state.dart';

class NotAdminsBloc extends Bloc<NotAdminsEvent, NotAdminsState> {

  final UsersRepository _usersRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription _notAdminsSubscription;

  NotAdminsBloc({@required UsersRepository usersRepository, @required AuthenticationRepository authenticationRepository})
    : assert(usersRepository != null),
      assert(authenticationRepository != null),
    _usersRepository = usersRepository,
    _authenticationRepository = authenticationRepository,
    super(NotAdminsLoadInProgress());

  @override
  Stream<NotAdminsState> mapEventToState(NotAdminsEvent event,) async* {
    if(event is NotAdminsLoaded){
      yield* _mapNotAdminLoadedToState();
    }
    if(event is NotAdminsUpdated){
      yield * _mapNotAdminUpdatedToState(event);
    }
  }


  Stream<NotAdminsState> _mapNotAdminLoadedToState() async *{
    yield NotAdminsLoadInProgress();
    _notAdminsSubscription?.cancel();
    try {
      _notAdminsSubscription = _usersRepository.getNotAdmins(_authenticationRepository.getUser().uid).listen((notAdmins) {
        add(NotAdminsUpdated(notAdmins));
       });
      // final List<LogroModel> notAdmins = await _usersRepository.getLogros().first;
      // yield NotAdminsLoaded(notAdmins);
    }
    catch (_) {
      yield NotAdminsLoadFailure();
    }
  }

  Stream<NotAdminsState> _mapNotAdminUpdatedToState(NotAdminsUpdated event) async *{
    yield NotAdminsLoadSuccess(event.notAdmins);
  }


  @override
  Future<void> close() {
    _notAdminsSubscription?.cancel();
    return super.close();
  }
}
