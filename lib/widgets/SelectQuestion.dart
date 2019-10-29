import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';

class SelectQuestion extends StatelessWidget {
  const SelectQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = BlocProvider.getBloc<ChoiceList>();

    return Observer(
      builder: (_) => Expanded(
        child: DropdownButton(
            isExpanded: true,
            value: store.selectedCategory,
            items: List<DropdownMenuItem>.from(store.categoryList
                .map((String cat) =>
                    DropdownMenuItem(value: cat, child: Text(cat)))
                .toList()),
            onChanged: (value) => store.setSelectedCategory(value)),
      ),
    );
  }
}
