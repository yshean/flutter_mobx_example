// TODO: 1. Add state maangement with a list of choices

import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'choice.dart';
import '../services/storable_service.dart';

part 'choice_list.g.dart';
// Run this command to generate:
// flutter packages pub run build_runner watch --delete-conflicting-outputs

var uuid = Uuid();

var storable = ChoiceListLocalStorableService();

@JsonSerializable()
class ChoiceList extends _ChoiceList with _$ChoiceList {
  ChoiceList();

  static fromJson(json) => _$ChoiceListFromJson(json);
  static toJson(list) => _$ChoiceListToJson(list);
}

abstract class _ChoiceList extends BlocBase with Store {
  @_ObservableListJsonConverter()
  @observable
  ObservableList<Choice> choices = ObservableList<Choice>();

  @observable
  String selectedCategory;

  _ChoiceList() {
    storable.loadData().then((res) {
      if (res != null) choices = res;
    });

    reaction((_) => categoryList.length, (length) {
      if (!(categoryList.contains(selectedCategory)))
        setSelectedCategory(categoryList.first);
    });

    reaction((_) => choices.toList(), (List<Choice> list) {
      print("storing data!");
      storable.saveData(ObservableList<Choice>.of(list));
    });
  }

  @computed
  Map<String, ObservableList<Choice>> get choicesMap {
    final Map<String, ObservableList<Choice>> map = {};

    if (choices.length == 0) {
      return map;
    }

    // Create a set of (unique) categories
    Set categories = Set.from(choices.map((v) => v.category));

    List<Choice> normalList = choices.toList();

    for (var cat in categories) {
      map[cat] = ObservableList<Choice>.of(
          normalList.where((entry) => (entry.category == cat)));
    }

    return map;
  }

  @computed
  bool get isEmpty => choices.length == 0;

  @computed
  List<String> get categoryList =>
      Set<String>.from(choices.map<String>((v) => v.category)).toList();

  @action
  void setSelectedCategory(String category) {
    selectedCategory = category;
  }

  @action
  void addChoice(String answer, String category) {
    final choice = Choice(id: uuid.v4(), category: category, answer: answer);
    choices.add(choice);
  }

  @action
  void removeChoice(Choice choice) {
    choices.removeWhere((x) => x == choice);
  }

  @action
  void editChoice(Choice choice) {
    final editIndex = choices.indexWhere((x) => x.id == choice.id);
    choices[editIndex] = choice;
  }

  Choice randomChoice({String category}) {
    final random = Random();
    final ObservableList<Choice> currCatItems = choicesMap[category];

    return currCatItems[random.nextInt(currCatItems.length)];
  }
}

class _ObservableListJsonConverter
    implements
        JsonConverter<ObservableList<Choice>, List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<Choice> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map<Choice>(Choice.fromJson));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Choice> list) =>
      list.map(Choice.toJson).toList();
}
