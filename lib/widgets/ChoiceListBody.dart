import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/screens/AddNewChoiceScreen.dart';
import 'package:flutter_mobx_example/stores/choice.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:flutter_mobx_example/widgets/ChoiceRowWidget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ChoiceListBody extends StatelessWidget {
  final store = BlocProvider.getBloc<ChoiceList>();

  void btnEditTouched(BuildContext context, Choice choice) async {
    final Choice data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddNewChoiceScreen(
          choice: choice,
          categoryList: store.categoryList,
        ),
      ),
    );
    if (data != null) {
      store.editChoice(data);
    }
  }

  void btnDeleteTouched(Choice choice) {
    store.removeChoice(choice);
  }

  List<Widget> _buildList(BuildContext context, List<Choice> choices) {
    List<Widget> arr = List<Widget>();

    for (Choice choice in choices) {
      arr.add(GestureDetector(
          child: Slidable(
        key: ValueKey(choice.id),
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.indigo,
            icon: Icons.edit,
            onTap: () => btnEditTouched(context, choice),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => btnDeleteTouched(choice),
          ),
        ],
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
        ),
        child: ChoiceRowWidget(
          choiceEntry: choice,
        ),
      )));
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Center(
        child: ListView.builder(
            itemCount: store.isEmpty ? 0 : store.categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              final category = store.categoryList[index];
              final catItems = store.choicesMap[category];
              if (catItems.length == 0) {
                return SizedBox.shrink();
              }
              return StickyHeader(
                header: Container(
                  height: 40.0,
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                content: Column(children: _buildList(context, catItems)),
              );
            }),
      ),
    );
  }
}
