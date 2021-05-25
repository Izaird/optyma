part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {

  final int streak;
  final int score;
  QuizState({
    this.streak=0,
    this.score=0
  });

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}
