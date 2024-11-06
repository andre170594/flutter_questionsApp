import 'package:flutter/material.dart';
import 'package:my_quesions_app/constants.dart';
import 'package:my_quesions_app/models/par_options_answers.dart';
import 'package:my_quesions_app/models/question_model.dart';
import 'package:my_quesions_app/widgets/next_button.dart';
import 'package:my_quesions_app/widgets/option_card.dart';
import 'package:my_quesions_app/widgets/submit_button.dart';

import '../widgets/question_widget.dart';



class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  //demo questions
   final List<ParOptionsAnswers> listOpts = [
        ParOptionsAnswers(option: 'opt 1', answers: false, selected: false),
        ParOptionsAnswers(option: 'opt 2', answers: true,  selected: false),
        ParOptionsAnswers(option: 'opt 3', answers: false, selected: false),
        ParOptionsAnswers(option: 'opt 4', answers: false, selected: false)
  ];
   final List<ParOptionsAnswers> listOpts2 = [
     ParOptionsAnswers(option: 'opt 1', answers: false, selected: false),
     ParOptionsAnswers(option: 'opt 2', answers: true,  selected: false),
     ParOptionsAnswers(option: 'opt 3', answers: false, selected: false),
     ParOptionsAnswers(option: 'opt 4', answers: false, selected: false),
     ParOptionsAnswers(option: 'opt 5', answers: true, selected: false),
     ParOptionsAnswers(option: 'opt 6', answers: false, selected: false)
   ];
  late final List<Question>  questions = [
     Question(
         pergunta: 'pergunta exemplo bla bla bla bla',
         listOpt: listOpts,
         explanation: 'explicação',
         numCorrect: 1
     ),
    Question(
        pergunta: 'pergunta2 exemplo bla bla bla bla',
        listOpt: listOpts2,
        explanation: 'explicação2',
        numCorrect: 2
    ),
    Question(
        pergunta: 'pergunta3 exemplo bla bla bla bla',
        listOpt: listOpts,
        explanation: 'explicação3',
        numCorrect: 1
    )
  ];


  int index =0;

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
      body: Container(
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
            for(int i =0; i < questions[index].listOpt.length;i++)
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