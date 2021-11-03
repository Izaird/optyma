import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_app/application/game_modes/endless_mode/endless_mode_bloc.dart';
import 'package:optyma_app/application/game_modes/timer/timer_bloc.dart';
import 'package:optyma_app/application/game_modes/pvp_mode/pvp_mode_bloc.dart';
import 'package:optyma_app/presentation/game_modes/PvPLocal/timer_text.dart';
class QuestionCard2 extends StatelessWidget {
  const QuestionCard2() : super();

  @override
  Widget build(BuildContext context) {
    final questionModel = BlocProvider.of<PvpModeBloc>(context).state.question;
    final selectedAnswer2 = BlocProvider.of<PvpModeBloc>(context).state.selectedAnswerj2;
    final answered2 = BlocProvider.of<PvpModeBloc>(context).state.answeredj2;
    int duration;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Text(questionModel.evalutedExpression,
          style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
          ),
          Column(
            children: questionModel.options.map((answer) => CreateOption(
              answer: answer,
              isSelected: answer == selectedAnswer2, 
              isCorrect: answer == questionModel.result, 
              isDisplayingAnswer: answered2 == true, 
              onTap: () => {
                duration = BlocProvider.of<TimerBloc>(context).state.duration,
                BlocProvider.of<PvpModeBloc>(context).add(PvpModeEvent.answer2Selected(answer, duration, 30)),
              }
            )).toList(),
          ),
          TimerText(),
        ],
      ),
    );
  }
}


class CreateOption extends StatelessWidget {
  final int answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const CreateOption({
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: boxShadow,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? isSelected 
                      ? Colors.green
                      : Colors.white
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
                  fontWeight: isDisplayingAnswer && isCorrect && isSelected
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect && isSelected
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
    required this.icon,
    required this.color,
  }) : super();

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