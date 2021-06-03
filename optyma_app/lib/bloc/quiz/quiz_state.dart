part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizUninitialized extends QuizState {}

class QuizInitialized extends QuizState{
  final int streak;
  final int score;
  final List<PlantillaModel> plantillas;

  QuizInitialized({
    this.streak = 0, 
    this.score = 0, 
    this.plantillas
  });

  QuizInitialized copyWith({
    int streak,
    int score,
    List<PlantillaModel> plantillas,
  }){
    return QuizInitialized(
      streak        : streak ?? this.streak,
      score         : score ?? this.score,
      plantillas    : plantillas ?? this.plantillas,
    );
  }

}