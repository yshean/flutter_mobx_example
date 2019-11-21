import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_mobx_example/services/storable_service.dart';
import 'package:flutter_mobx_example/stores/choice.dart';
import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'choice_list.g.dart';
// Run this command to generate:
// flutter packages pub run build_runner watch --delete-conflicting-outputs

var uuid = Uuid();

var storable = ChoiceListLocalStorableService();

@JsonSerializable()
class ChoiceList extends _ChoiceList with _$ChoiceList {
  ChoiceList();

  factory ChoiceList.fromJson(Map<String, dynamic> json) =>
      _$ChoiceListFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceListToJson(this);
}

enum Status { IDLE, LOADING, ERROR }

abstract class _ChoiceList extends BlocBase with Store {
  // TODO: 2. Add state management with a list of choices

  @_ObservableListJsonConverter()
  @observable
  ObservableList<Choice> choices = ObservableList<Choice>();

  @observable
  String selectedCategory;

  @observable
  Status status = Status.IDLE;

  @observable
  Status savingStatus = Status.IDLE;

  Choice _lastRemovedChoice;

  _ChoiceList() {
    // TODO: 11. Set selected category to other value if the selected category has been removed/edited away
    reaction((_) => categoryList, (_) {
      if (!(categoryList.contains(selectedCategory)))
        setSelectedCategory(categoryList.first);
    });

    reaction((_) => status, (s) {
      print('Status: $s');
    });

    reaction((_) => savingStatus, (s) {
      print('Saving Status: $s');
    });
  }

  // TODO: 5c. Compute the choice map (map from category to list of choice)
  // you need to group choices of same category/question together to display in ChoiceListBody
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

    return Map.unmodifiable(map);
  }

  // TODO: 5d. Compute if it is empty to handle empty scenario
  @computed
  bool get isEmpty => choices.length == 0;

  // TODO: 5b. Compute/derive the categoryList from list of choices
  @computed
  List<String> get categoryList => List<String>.unmodifiable(
      Set<String>.from(choices.map<String>((v) => v.category)).toList());

  // TODO: 10b. Make the loadFromLocal function
  @action
  Future<void> loadFromLocal() async {
    print("[loadFromLocal.action]");
    ChoiceList res;
    status = Status.LOADING;
    try {
      res = await storable.loadData();
      if (res != null) {
        choices = res.choices;
        selectedCategory = res.selectedCategory ??
            (choices.isNotEmpty ? choices.first.category : null);
      }
      status = Status.IDLE;
      // throw Exception();
    } catch (error) {
      print(error);
      status = Status.ERROR;
    }
  }

  // TODO: 9b. Make the saveToLocal function
  @action
  Future<void> saveToLocal() async {
    print("[saveToLocal.action]");
    savingStatus = Status.LOADING;

    try {
      await storable.saveData(this);
      savingStatus = Status.IDLE;
      // throw Exception();
    } catch (_) {
      savingStatus = Status.ERROR;
      undoDelete();
    }
  }

  @action
  void undoDelete() {
    if (_lastRemovedChoice != null) choices.add(_lastRemovedChoice);
  }

  // TODO: 10c. Set selected category
  @action
  void setSelectedCategory(String category) {
    print("[setSelectedCategory.action] payload: {category: $category}");
    selectedCategory = category;
  }

  // TODO: 4b. Make the addChoice function
  @action
  void addChoice(String answer, String category) {
    print("[addChoice.action] payload: {answer: $answer, category: $category}");
    final choice = Choice(id: uuid.v4(), category: category, answer: answer);
    choices.add(choice);
  }

  // TODO: 7b. Make the deleteChoice function
  @action
  void removeChoice(Choice choice) {
    print("[removeChoice.action] payload: $choice");
    _lastRemovedChoice = choice;
    choices.removeWhere((x) => x == choice);
  }

  // TODO: 6b. Make the editChoice function
  @action
  void editChoice(Choice choice) {
    print("[editChoice.action] payload: $choice");
    final editIndex = choices.indexWhere((x) => x.id == choice.id);
    choices[editIndex] = choice;
  }

  // TODO: 8c. Get random choice from list of choice
  Choice randomChoice({String category}) {
    final random = Random();
    final ObservableList<Choice> currCatItems = choicesMap[category];

    return currCatItems[random.nextInt(currCatItems.length)];
  }
}

class _ObservableListJsonConverter
    implements JsonConverter<ObservableList<Choice>, List<dynamic>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<Choice> fromJson(List<dynamic> json) => ObservableList.of(
      json.map((i) => Choice.fromJson(Map<String, dynamic>.from(i))));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Choice> list) =>
      list.map(Choice.toJson).toList();
}
