part of 'add_plantilla_bloc.dart';

class AddPlantillaState extends Equatable {

  final FormStatus status;
  final String expression;
  final String sentence;
  final int difficulty;
  final int subject;
  final int timeOpen;
  final int timeClose;

  AddPlantillaState({
    this.status, 
    this.expression, 
    this.sentence, 
    this.difficulty, 
    this.subject, 
    this.timeOpen, 
    this.timeClose
  });

  
  @override
  List<Object> get props => [
    status,
    expression,
    sentence,
    difficulty,
    subject,
    timeOpen,
    timeClose,
  ];

  AddPlantillaState copyWith({
    FormStatus status,
    String expression,
    String sentence,
    int difficulty,
    int subject,
    int timeOpen,
    int timeClose,
  }){
    return AddPlantillaState(
      status        : status ?? this.status,
      expression    : expression ?? this.expression,
      sentence      : sentence ?? this.sentence,
      difficulty    : difficulty ?? this.difficulty,
      subject       : subject ?? this.subject,
      timeOpen      : timeOpen ?? this.timeOpen,
      timeClose     : timeClose ?? this.timeClose,
    );
  }
}

