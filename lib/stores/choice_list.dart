// TODO: 1. Add state maangement with a list of choices

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

  /// A necessary factory constructor for creating a new ChoiceList instance
  /// from a map. Pass the map to the generated `_$ChoiceListFromJson()` constructor.
  /// The constructor is named after the source class, in this case, ChoiceList.
  factory ChoiceList.fromJson(Map<String, dynamic> json) =>
      _$ChoiceListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ChoiceListToJson`.
  Map<String, dynamic> toJson() => _$ChoiceListToJson(this);
}

enum Status { IDLE, LOADING, ERROR }

abstract class _ChoiceList extends BlocBase with Store {
  @_ObservableListJsonConverter()
  @observable
  ObservableList<Choice> choices = ObservableList<Choice>();

  @observable
  String selectedCategory;

  @observable
  Status status = Status.IDLE;

  @observable
  Status savingStatus = Status.IDLE;

  @action
  void loadFromLocal() {
    print("[loadFromLocal.action]");
    status = Status.LOADING;

    storable.loadData().then((res) {
      runInAction(() {
        if (res != null) {
          choices = res.choices;
          selectedCategory = res.selectedCategory ?? choices.first.category;
        }
        status = Status.IDLE;
      });
      // throw Exception();
    }).catchError((_) {
      runInAction(() {
        status = Status.ERROR;
      });
    });
  }

  @action
  Future<void> loadFromLocal2() async {
    print("[loadFromLocal2.action]");
    ChoiceList res;
    status = Status.LOADING;
    try {
      res = await storable.loadData();
      if (res != null) {
        choices = res.choices;
        selectedCategory = res.selectedCategory ?? choices.first.category;
      }
      status = Status.IDLE;
      // throw Exception();
    } catch (_) {
      status = Status.ERROR;
    }

    // storable.loadData().then((res) {
    //   if (res != null) {
    //     choices = res.choices;
    //     selectedCategory = res.selectedCategory ?? choices.first.category;
    //   }
    //   status = Status.IDLE;
    // }).catchError((err) {
    //   status = Status.ERROR;
    // });
  }

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
      loadFromLocal();
    }

    // storable.saveData(this).then((_) {
    //   runInAction(() {
    //     savingStatus = Status.IDLE;
    //   });
    //   // throw Exception();
    // }).catchError((_) {
    //   runInAction(() {
    //     savingStatus = Status.ERROR;
    //   });
    // });
  }

  _ChoiceList() {
    // autosave entries when choices is changed
    // reaction((_) => choices.toList(), (_) {
    //   storable.saveData(this);
    // });

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

  @computed
  bool get isEmpty => choices.length == 0;

  @computed
  List<String> get categoryList => List<String>.unmodifiable(
      Set<String>.from(choices.map<String>((v) => v.category)).toList());

  @action
  void setSelectedCategory(String category) {
    print("[setSelectedCategory.action] payload: {category: $category}");
    selectedCategory = category;
  }

  @action
  void addChoice(String answer, String category) {
    print("[addChoice.action] payload: {answer: $answer, category: $category}");
    final choice = Choice(id: uuid.v4(), category: category, answer: answer);
    choices.add(choice);
  }

  @action
  void removeChoice(Choice choice) {
    print("[removeChoice.action] payload: $choice");
    choices.removeWhere((x) => x == choice);
  }

  @action
  void editChoice(Choice choice) {
    print("[editChoice.action] payload: $choice");
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
    implements JsonConverter<ObservableList<Choice>, List<dynamic>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<Choice> fromJson(List<dynamic> json) => ObservableList.of(
      json.map((i) => Choice.fromJson(Map<String, dynamic>.from(i))));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Choice> list) =>
      list.map(Choice.toJson).toList();
}
