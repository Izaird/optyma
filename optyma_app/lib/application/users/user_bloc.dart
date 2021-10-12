import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:optyma_app/domain/auth/i_auth_facade.dart';
import 'package:optyma_app/domain/auth/value_objects.dart';
import 'package:optyma_app/domain/core/errors.dart';
import 'package:optyma_app/domain/core/value_objects.dart';
import 'package:optyma_app/domain/users/i_user_repository.dart';
import 'package:optyma_app/domain/users/user.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {

  final IAuthFacade _authFacade;
  final IUserRepository _userRepository;
  
  UserBloc(this._authFacade, this._userRepository) : super(const UserState.loggedOut()); 
  
  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    yield* event.map(
      loggedIn: (e) async* {
        final userIdOption = await _authFacade.getSignedInUserId();
        final userId = userIdOption.getOrElse(() => throw NotAuthenticatedError());
        final user = await _userRepository.getUser(userId.getOrCrash());
        yield user.fold(
          () {
            final firebaseUser = _authFacade.getFirebaseUser();
            final user = User(
              id: UniqueId.fromUniqueString(firebaseUser!.uid),
              emailAddress: EmailAddress(firebaseUser.email ?? ''),
              admin: false
            );
            _userRepository.create(user);
            return UserState.playerLogged(user);
          }, 
          (user) => user.admin ? UserState.adminLogged(user) : UserState.playerLogged(user),
        );
      }, loggedOut: (e) async* {
        yield const UserState.loggedOut();
      },
      signedUp: (e) async* {
        _userRepository.create(e.user);
        yield UserState.playerLogged(e.user);
      },
   
   
    );
  }
}
