part of 'logro_cubit.dart';

class LogroState extends Equatable {

  final String name;
  final String description;

  //      ---->>status<<----
  //  invalid               == 0 
  //  isValidated           == 1 
  //  submissionInProgress  == 2 
  //  submissionSuccess     == 3
  //  submissionFailure     == 4 
  final int status;


  const LogroState({
    this.name,
    this.description,
    this.status = 0,
  });


  @override
  List<Object> get props => [name ,description , status];

  LogroState copyWith({
    String name,
    String description,
    int status,
  }){
    return LogroState(
      name      : name ?? this.name,  
      description : description ?? this.description,  
      status      : status ?? this.status,  
    );

  }


}

