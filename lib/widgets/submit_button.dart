
import 'package:flutter/material.dart';
import 'package:my_quesions_app/models/question_model.dart';

import '../constants.dart';


class SubmitButton extends StatelessWidget {

  final VoidCallback submitQuestions;
  final List<Question> listaQuestoes;


  const SubmitButton({
    super.key,req,
    required this.submitQuestions,
    required this.listaQuestoes
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submitQuestions,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: const Text(
          'Submit',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
