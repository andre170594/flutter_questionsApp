

import 'package:my_quesions_app/models/par_options_answers.dart';

class Question {
  final String? pergunta;
  final List<ParOptionsAnswers> listOpt;
  final String? explanation;
  final int? numCorrect;

  Question({
    this.pergunta,
    required this.listOpt,
    this.explanation,
    this.numCorrect,
  });
}


