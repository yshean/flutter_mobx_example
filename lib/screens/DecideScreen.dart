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

  _getBody(store) {
    if (store.status == Status.IDLE) {
      if (store.isEmpty) return EmptyChoiceBody();
      return DecideScreenBody();
    }

    if (store.status == Status.LOADING)
      return Center(child: CircularProgressIndicator());

    return Text('Some error occurred');
  }

  @override
  Widget build(BuildContext context) {
    final store = BlocProvider.getBloc<ChoiceList>();
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Make a Choice'),
        ),
        body: _getBody(store),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _gotoListScreen(context),
          tooltip: 'Add a choice',
          child: Icon(Icons.list),
        ),
      ),
    );
  }
}
