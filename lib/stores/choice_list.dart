// TODO: 1. Add state maangement with a list of choices

import 'dart:convert';
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
  // final ChoiceList initialChoiceList;

  // ChoiceList({ChoiceList choiceList}) : super();
  ChoiceList();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromMappedJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ChoiceList.fromJson(Map<String, dynamic> json) =>
      _$ChoiceListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ChoiceListToJson(this);

  // static fromJson(json) => _$ChoiceListFromJson(json);
  // static toJson(list) => _$ChoiceListToJson(list);
}

// @JsonSerializable()
// class ChoiceList = _ChoiceList with _$ChoiceList;

abstract class _ChoiceList extends BlocBase with Store {
  @_ObservableListJsonConverter()
  @observable
  ObservableList<Choice> choices = ObservableList<Choice>();

  @observable
  String selectedCategory;

  @action
  void loadFromLocal() {
    storable.loadData().then((res) {
      if (res != null) {
        choices = res.choices;
        selectedCategory = res.selectedCategory ?? choices.first.category;
      }
    });
  }

  // @action
  // void saveToLocal() {
  //   storable.saveData(this);
  // }

  // final ChoiceList initialChoiceList;

  // Future<ObservableList<Choice>> _loadDataFromLocal() async {
  //   var future = await storable.loadData();
  //   return future.choices;
  // }

  // _ChoiceList() {
  //   storable.loadData().then((res) {
  //     if (res != null) {
  //       choices = res.choices;
  //       selectedCategory = res.selectedCategory;
  //     }
  //   });
  //   // _loadDataFromLocal().then((ch) {
  //   //   choices = ch;
  //   // });
  // }

  // _ChoiceList({this.initialChoiceList}) {
  //   print('Initial choice list: ${this.initialChoiceList}');
  //   if (this.initialChoiceList != null) {
  //     choices = this.initialChoiceList.choices;
  //     selectedCategory = this.initialChoiceList.selectedCategory;
  //   }
  // }

  _ChoiceList() {
    reaction((_) => choices.toList(), (_) {
      print("saving data");
      storable.saveData(this).then((_) {
        print("here: saved!");
      });
    });

    reaction((_) => categoryList, (_) {
      if (!(categoryList.contains(selectedCategory)))
        setSelectedCategory(categoryList.first);
    });
  }

  @computed
  Map<String, ObservableList<Choice>> get choicesMap {
    final Map<String, ObservableList<Choice>> map = {};

    print("[get choicesMap] Choices: ${choices.length}");

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

  @computed
  bool get isEmpty => choices.length == 0;

  @computed
  List<String> get categoryList {
    print("[get categoryList] Choices: ${choices.length}");
    var something =
        Set<String>.from(choices.map<String>((v) => v.category)).toList();
    print(something);
    return List<String>.unmodifiable(
        Set<String>.from(choices.map<String>((v) => v.category)).toList());
  }
  // =>

  @action
  void setSelectedCategory(String category) {
    selectedCategory = category;
  }

  @action
  void addChoice(String answer, String category) {
    print("[addChoice.action] payload: {answer: $answer, category: $category}");
    final choice = Choice(id: uuid.v4(), category: category, answer: answer);
    choices.add(choice);
    // storable.saveData(this).then((_) {
    //   print("Saved!");
    // });
  }

  @action
  void removeChoice(Choice choice) {
    choices.removeWhere((x) => x == choice);
    // storable.saveData(this);
  }

  @action
  void editChoice(Choice choice) {
    final editIndex = choices.indexWhere((x) => x.id == choice.id);
    choices[editIndex] = choice;
    // storable.saveData(this);
  }

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
