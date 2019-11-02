import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/screens/AddNewChoiceScreen.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:flutter_mobx_example/widgets/ChoiceListBody.dart';
import 'package:flutter_mobx_example/widgets/EmptyChoiceBody.dart';

class ChoiceListScreen extends StatelessWidget {
  final store = BlocProvider.getBloc<ChoiceList>();

  void _gotoAddScreen(BuildContext context) async {
    final Map data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddNewChoiceScreen(
          categoryList: store.categoryList,
        ),
      ),
    );

    if (data != null) {
      store.addChoice(data['answer'], data['category']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Choice List'),
        ),
        body: store.isEmpty ? EmptyChoiceBody() : ChoiceListBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _gotoAddScreen(context),
          tooltip: 'Add a choice',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
