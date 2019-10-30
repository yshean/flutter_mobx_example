import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/screens/ChoiceListScreen.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:flutter_mobx_example/widgets/DecideScreenBody.dart';
import 'package:flutter_mobx_example/widgets/EmptyChoiceBody.dart';

class DecideScreen extends StatelessWidget {
  void _gotoListScreen(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => ChoiceListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final store = BlocProvider.getBloc<ChoiceList>();
    print(store.isEmpty);

    return Observer(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Make a Choice'),
              ),
              body: store.isEmpty ? EmptyChoiceBody() : DecideScreenBody(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _gotoListScreen(context),
                tooltip: 'Add a choice',
                child: Icon(Icons.list),
              ),
            ));
  }
}
