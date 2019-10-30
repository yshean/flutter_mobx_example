import 'package:flutter/material.dart';
import 'package:flutter_mobx_example/stores/choice.dart';

class ChoiceRowWidget extends StatelessWidget {
  final Choice choiceEntry;

  const ChoiceRowWidget({Key key, this.choiceEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      color: Color(0xFFFFFF),
      height: 80,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                choiceEntry.answer,
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
