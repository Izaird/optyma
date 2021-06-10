import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/bloc/quiz/quiz_bloc.dart';
import 'package:optyma_app/bloc/timer/timer_bloc.dart';
import 'package:optyma_app/models/quiz_model.dart';

import 'package:optyma_app/repository/questions_repository.dart';
import 'package:optyma_app/repository/ticker.dart';



class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizData = ModalRoute.of(context).settings.arguments as QuizModel;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuizBloc(questionsRepository: RepositoryProvider.of<QuestionsRepository>(context))
          ..add(QuizStarted(difficulty: quizData.dificultad, subject: quizData.tema)),
        ),
        BlocProvider(
          create: (context) => TimerBloc(ticker: Ticker()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: QuizPageBody(),
          ),
        ),
      ),
    );
  }
}

class QuizPageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if(state.status == QuizStatus.waitingAnswer){
          BlocProvider.of<TimerBloc>(context).add(TimerStarted(
            duration: state.questions[state.currentIndex].time));
        }
        if(state.status == QuizStatus.answered){
          BlocProvider.of<TimerBloc>(context).add(TimerPaused());
        }

      },
      builder: (context, state) {
        if(state.status == QuizStatus.loading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state.status == QuizStatus.waitingAnswer || state.status == QuizStatus.answered){
          return Column(
            children: <Widget>[
              TopBar(state: state),
              TimerText(),
              QuizCard(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionModel = context.select((QuizBloc bloc) => bloc.state.questions[bloc.state.currentIndex]);
    final selectedAnswer = context.select((QuizBloc bloc) => bloc.state.selectedAnswer);
    final status = context.select((QuizBloc bloc) => bloc.state.status);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Text(questionModel.question,
          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
          ),
          Column(
            children: questionModel.options.map((answer) => CreateOption(
              answer: answer, 
              isSelected: answer == selectedAnswer, 
              isCorrect: answer == questionModel.correctAnswer, 
              isDisplayingAnswer: status == QuizStatus.answered, 
              // isDisplayingAnswer: true, 
              onTap: () => BlocProvider.of<QuizBloc>(context).add(QuizAnswerSelected(answer)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final QuizState state;
  const TopBar({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(Icons.local_fire_department_outlined),
        Text('${state.streak}'),
        Spacer(),
        Text('${state.score}')
      ],
    );
  }
}

class TimerText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2,'0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if(state is TimerRunComplete){
          BlocProvider.of<QuizBloc>(context).add(QuizTimeOver());
        }
      },
      child:  Text('$minuteStr:$secondsStr',
      style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}



class CreateOption extends StatelessWidget {
  final double answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const CreateOption({
    Key key,
    @required this.answer,
    @required this.isSelected,
    @required this.isCorrect,
    @required this.isDisplayingAnswer,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: boxShadow,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '$answer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

}


class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key key,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        // boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
