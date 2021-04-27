part of 'plantilla_cubit.dart';

class PlantillaState extends Equatable {

  final int difficulty;
  final String exp;
  final String sentence;
  final String subject;
  final int time1;
  final int time2;

  //      ---->>status<<----
  //  invalid               == 0 
  //  isValidated           == 1 
  //  submissionInProgress  == 2 
  //  submissionSuccess     == 3
  //  submissionFailure     == 4 
  final int status;


  const PlantillaState({
    this.difficulty,
    this.exp,
    this.sentence,
    this.subject,
    this.time1,
    this.time2,
    this.status = 0,
  });


  @override
  List<Object> get props => [difficulty, exp, sentence, subject, time1, time2, status];

  PlantillaState copyWith({
    int difficulty,
    String exp,
    String sentence,
    String subject,
    int time1,
    int time2,
    int status,
  }){
    return PlantillaState(
      difficulty    : difficulty ?? this.difficulty,  
      exp           : exp ?? this.exp,  
      sentence      : sentence ?? this.sentence,  
      subject       : subject ?? this.subject,  
      time1         : time1 ?? this.time1,  
      time2         : time2 ?? this.time2,  
      status        : status ?? this.status,  
    );

  }


}

