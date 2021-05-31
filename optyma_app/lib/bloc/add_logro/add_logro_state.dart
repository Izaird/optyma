part of 'add_logro_bloc.dart';
Map<int,String> difficultys = {
  0: 'cualquier dificultad', 
  1: 'la dificultad fácil', 
  2: 'la dificultad medio', 
  3: 'la dificultad difícil'
};
Map<int,String> subjects = {
  0: 'cualquier tema',
  1: 'aritmética', 
  2: 'álgebra', 
  3: 'diferencial', 
  4: 'optimización',
};

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
  final FormStatus status;

  AddLogroState({
    this.logroType,
    this.name, 
    this.description, 
    this.numberOfAnswers, 
    this.numberOfDays, 
    this.numberOfExercises, 
    this.difficulty, 
    this.subject, 
    this.status = FormStatus.notValidated,
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
    FormStatus status,
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
