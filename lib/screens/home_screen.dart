import 'package:flutter/material.dart';
import 'package:my_quesions_app/constants.dart';
import 'package:my_quesions_app/models/par_options_answers.dart';
import 'package:my_quesions_app/models/question_model.dart';
import 'package:my_quesions_app/widgets/next_button.dart';
import 'package:my_quesions_app/widgets/option_card.dart';
import 'package:my_quesions_app/widgets/submit_button.dart';

import '../widgets/question_widget.dart';
import 'package:my_quesions_app/models/db_connect.dart';



class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  List<Question> questions = [];
  int index =0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestionsFromDB();
  }

  Future<void> fetchQuestionsFromDB() async {
    DBconnect db = DBconnect();
    List<Question> fetchedQuestions = await db.fetchQuestions();

    setState(() {
      questions = fetchedQuestions;
      isLoading = false;
    });
  }


  void nextQuestion(){
    if(index == questions.length-1) {
      return;
    }else{
      setState(() {
        index++;
      });
    }
  }
  void selectChoice(ParOptionsAnswers option){
    setState(() {
      // Count the currently selected options
      int selectedCount = questions[index].listOpt.where((opt) => opt.selected).length;

      // Toggle the selection only if it's a deselect or under the limit
      if (option.selected == true || selectedCount < (questions[index].numCorrect ?? 1)) {
        option.selected = !(option.selected ?? false);
      }
    });
  }
  void submitQuestions(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: const Text('quiz app'),
        shadowColor: Colors.transparent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : questions.isEmpty
          ? const Center(child: Text('No questions available.'))
          : Container(
        color: background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: questions[index].pergunta.toString(),
              totalQuestions: questions.length,
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < questions[index].listOpt.length; i++)
              OptionCard(
                option: questions[index].listOpt[i].option.toString(),
                onTap: () => selectChoice(questions[index].listOpt[i]),
                isSelected: questions[index].listOpt[i].selected,
              )
          ],
        ),
      ),

      // BOTTOM BUTTONS
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:index == questions.length - 1 ?
             SubmitButton(
                 submitQuestions: submitQuestions,
                 listaQuestoes: questions
             )
            : NextButton(
                 nextQuestion: nextQuestion,
               ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}