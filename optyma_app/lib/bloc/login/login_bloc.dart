import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/login/form_submission_status.dart';
import 'package:optyma_app/repository/mysql_api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final MysqlApi authRepo;

  LoginBloc({this.authRepo}): super (LoginState());
  
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginEmailChanged){
      yield state.copyWith(email: event.email);
    } else if (event is LoginPasswordChanged){
      yield state.copyWith(password: event.password);
    } else if(event is LoginAdminFlagChanged) {
      yield state.copyWith(adminFlag: event.adminFlag);
    }
    else if (event is LoginSubmited){
      yield state.copyWith(formStatus: FormSubmitting());
      if(state.adminFlag){
        try {
          await authRepo.loginAdmin(state.email, state.password);
          yield state.copyWith(formStatus: SubmissionSuccess());
        }catch(e){
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }else {
        try {
          await authRepo.loginUser(state.email, state.password);
          yield state.copyWith(formStatus: SubmissionSuccess());
        }catch(e){
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }
      
    } 
  }
}