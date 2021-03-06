import 'package:Pesquisei/stores/pesquisa.store.dart';
import 'package:Pesquisei/views/pergunta.quiz.view.dart';
import 'package:flutter/material.dart';
import 'package:Pesquisei/views/home/home.view.dart';
import 'package:provider/provider.dart';

class FinishDialog {
  static Future show(
    BuildContext context, {
    //   @required int hitNumber,
    @required int questionNumber,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        var pesquisaStore = Provider.of<PesquisaStore>(context);

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: CircleAvatar(
            backgroundColor: Colors.blue,
            maxRadius: 35.0,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Você respondeu todas as perguntas!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Deseja realizar uma nova pesquisa?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('NOVA PESQUISA'),
              onPressed: () {
                pesquisaStore.setResumo(pesquisaStore.id, pesquisaStore.nome,
                    pesquisaStore.idbairro, pesquisaStore.idcidade);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PerguntaQuizView(pesquisaStore.id)),
                );
              },
            ),
            FlatButton(
              child: const Text('SAIR'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
