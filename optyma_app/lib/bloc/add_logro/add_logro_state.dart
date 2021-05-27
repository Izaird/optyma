part of 'add_logro_bloc.dart';
Map<int,String> difficultys = {1: "facil", 2:"medio", 3:'dificil'};
Map<int,String> subjects = {1: "aritmetica", 2:"algebra", 3:'diferencial', 4:'optimizacion'};

//  --->  LogroType  <---
//  nive == niveles
//  rDia == racha de dias
//  rRes == racha de respuestas
//  lead == leaderboard

class AddLogroState extends Equatable {
  final LogroType logroType; 
  final String name;
  final String description;
  final int numberOfAnswers;
  final int numberOfDays;
  final int numberOfExercises;

  //  --->  difficulty  <---
  // 0 == any 
  // 1 == easy 
  // 2 == medium 
  // 3 == hard 
  final int difficulty;

  //  --->  subject  <---
  // 0 == any 
  // 1 == aritmetica
  // 2 == algebra 
  // 3 == diferencial 
  // 4 == optimizacion 
  final int subject;

  //  --->  status  <---
  // 0 == invalid
  // 1 == isValidated
  // 2 == submissionInProgress 
  // 3 == submissionSuccess 
  // 4 == submissionFailure
  final int status;

  AddLogroState({
    this.logroType,
    this.name, 
    this.description, 
    this.numberOfAnswers, 
    this.numberOfDays, 
    this.numberOfExercises, 
    this.difficulty, 
    this.subject, 
    this.status = 0,
  });

  @override
  List<Object> get props => [
    logroType, 
    name, 
    description, 
    numberOfAnswers, 
    numberOfDays, 
    numberOfExercises,
    difficulty,
    subject,
    status,
  ];


  AddLogroState copyWith({
    LogroType logroType,
    String name,
    String description,
    int numberOfAnswers, 
    int numberOfDays, 
    int numberOfExercises,
    int difficulty,
    int subject,
    int status,
  }){
    return AddLogroState(
      logroType           : logroType ?? this.logroType,  
      name                : name ?? this.name,  
      description         : description ?? this.description,  
      numberOfAnswers     : numberOfAnswers ?? this.numberOfAnswers,  
      numberOfDays        : numberOfDays ?? this.numberOfDays,  
      numberOfExercises   : numberOfExercises ?? this.numberOfExercises,  
      difficulty          : difficulty ?? this.difficulty,  
      subject             : subject ?? this.subject,  
      status              : status ?? this.status,  
    );

  }

}
