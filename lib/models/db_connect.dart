import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_quesions_app/models/par_options_answers.dart';
import 'package:my_quesions_app/models/question_model.dart';


class DBconnect {
  final urlQuestionsCaD = Uri.parse('https://certificationproject-3dbf5-default-rtdb.firebaseio.com/questions/CAD.json');

  Future<List<Question>> fetchQuestions() async {
    final List<Question> questions = [];
    try {
      final response = await http.get(urlQuestionsCaD);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        data.forEach((key, value) {
          questions.add(Question(
            pergunta: value['pergunta'],
            explanation: value['explanation'],
            numCorrect: value['numCorrect'],
            listOpt: (value['listOpt'] as List).map((opt) => ParOptionsAnswers(
              option: opt['option'],
              answers: opt['answers'],
              selected: opt['selected'],
            )).toList(),
          ));
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    questions.shuffle();

    return questions.take(50).toList();
  }


}