import 'package:flutter/material.dart';

class EmptyChoiceBody extends StatelessWidget {
  const EmptyChoiceBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/no_entries.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Add at least a choice to the list to begin.',
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
