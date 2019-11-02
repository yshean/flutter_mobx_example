import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';

class SelectQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = BlocProvider.getBloc<ChoiceList>();
    print('selected category: ${store.selectedCategory}');

    return Observer(
      builder: (_) => Expanded(
        child: DropdownButton(
            isExpanded: true,
            value: store.selectedCategory,
            // value: store.categoryList.contains(store.selectedCategory)
            //     ? store.selectedCategory
            //     : store.categoryList.first,
            items: List<DropdownMenuItem>.from(store.categoryList
                .map((String cat) =>
                    DropdownMenuItem(value: cat, child: Text(cat)))
                .toList()),
            onChanged: (value) => store.setSelectedCategory(value)),
      ),
    );
  }
}
