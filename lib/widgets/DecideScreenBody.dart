import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:flutter_mobx_example/widgets/EmptyChoiceBody.dart';
import 'package:flutter_mobx_example/widgets/SelectQuestion.dart';

class DecideScreenBody extends StatelessWidget {
  void _showDialog(context, store) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('You should go for...'),
            content: Text(
                // TODO: 8b. Get random choice from list of choice
                store.randomChoice(category: store.selectedCategory).answer),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final store = BlocProvider.getBloc<ChoiceList>();
    return Observer(
      builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 32.0),
            Row(
              children: <Widget>[
                Container(width: 32.0),
                SelectQuestion(),
                Container(width: 32.0),
              ],
            ),
            Container(height: MediaQuery.of(context).size.height / 4),
            store.choicesMap[store.selectedCategory] == null
                ? EmptyChoiceBody()
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: RaisedButton(
                            child: Text('Decide!',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w600)),
                            onPressed: () {
                              _showDialog(context, store);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ]),
    );
  }
}
