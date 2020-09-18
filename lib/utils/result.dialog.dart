import 'package:flutter/material.dart';
import 'package:flutter_crud/models/pesquisa.quiz.dart';

class ResultDialog {
  static Future show(
    BuildContext context, {
    @required PerguntaQuiz question,
    @required String resp,
    @required Function onNext,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.check,
              color: Colors.grey.shade900,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                question.descricao,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Voto recebido!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Resposta Escolhida: " + resp,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('PRÓXIMO'),
              onPressed: () {
                Navigator.of(context).pop();
                onNext();
              },
            )
          ],
        );
      },
    );
  }
}
