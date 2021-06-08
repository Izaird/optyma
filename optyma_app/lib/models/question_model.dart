
class QuestionModel{
  QuestionModel({
    this.options,
    this.question,
    this.correctAnswer,
    this.time
  });
  String question;
  List<double> options;
  double correctAnswer;
  int time;
}