// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceList _$ChoiceListFromJson(Map<String, dynamic> json) {
  return ChoiceList()
    ..choices = json['choices'] == null
        ? null
        : const _ObservableListJsonConverter()
            .fromJson(json['choices'] as List<Map<String, dynamic>>)
    ..selectedCategory = json['selectedCategory'] as String;
}

Map<String, dynamic> _$ChoiceListToJson(ChoiceList instance) =>
    <String, dynamic>{
      'choices': instance.choices == null
          ? null
          : const _ObservableListJsonConverter().toJson(instance.choices),
      'selectedCategory': instance.selectedCategory
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChoiceList on _ChoiceList, Store {
  Computed<Map<String, ObservableList<Choice>>> _$choicesMapComputed;

  @override
  Map<String, ObservableList<Choice>> get choicesMap =>
      (_$choicesMapComputed ??= Computed<Map<String, ObservableList<Choice>>>(
              () => super.choicesMap))
          .value;
  Computed<bool> _$isEmptyComputed;

  @override
  bool get isEmpty =>
      (_$isEmptyComputed ??= Computed<bool>(() => super.isEmpty)).value;
  Computed<List<String>> _$categoryListComputed;

  @override
  List<String> get categoryList => (_$categoryListComputed ??=
          Computed<List<String>>(() => super.categoryList))
      .value;

  final _$choicesAtom = Atom(name: '_ChoiceList.choices');

  @override
  ObservableList<Choice> get choices {
    _$choicesAtom.context.enforceReadPolicy(_$choicesAtom);
    _$choicesAtom.reportObserved();
    return super.choices;
  }

  @override
  set choices(ObservableList<Choice> value) {
    _$choicesAtom.context.conditionallyRunInAction(() {
      super.choices = value;
      _$choicesAtom.reportChanged();
    }, _$choicesAtom, name: '${_$choicesAtom.name}_set');
  }

  final _$selectedCategoryAtom = Atom(name: '_ChoiceList.selectedCategory');

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.context.enforceReadPolicy(_$selectedCategoryAtom);
    _$selectedCategoryAtom.reportObserved();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.context.conditionallyRunInAction(() {
      super.selectedCategory = value;
      _$selectedCategoryAtom.reportChanged();
    }, _$selectedCategoryAtom, name: '${_$selectedCategoryAtom.name}_set');
  }

  final _$_ChoiceListActionController = ActionController(name: '_ChoiceList');

  @override
  void setSelectedCategory(String category) {
    final _$actionInfo = _$_ChoiceListActionController.startAction();
    try {
      return super.setSelectedCategory(category);
    } finally {
      _$_ChoiceListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addChoice(String answer, String category) {
    final _$actionInfo = _$_ChoiceListActionController.startAction();
    try {
      return super.addChoice(answer, category);
    } finally {
      _$_ChoiceListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeChoice(Choice choice) {
    final _$actionInfo = _$_ChoiceListActionController.startAction();
    try {
      return super.removeChoice(choice);
    } finally {
      _$_ChoiceListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editChoice(Choice choice) {
    final _$actionInfo = _$_ChoiceListActionController.startAction();
    try {
      return super.editChoice(choice);
    } finally {
      _$_ChoiceListActionController.endAction(_$actionInfo);
    }
  }
}
