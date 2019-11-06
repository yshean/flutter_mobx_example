// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceList _$ChoiceListFromJson(Map<String, dynamic> json) {
  return ChoiceList()
    ..choices = json['choices'] == null
        ? null
        : const _ObservableListJsonConverter().fromJson(json['choices'] as List)
    ..selectedCategory = json['selectedCategory'] as String
    ..status = _$enumDecodeNullable(_$StatusEnumMap, json['status'])
    ..savingStatus =
        _$enumDecodeNullable(_$StatusEnumMap, json['savingStatus']);
}

Map<String, dynamic> _$ChoiceListToJson(ChoiceList instance) =>
    <String, dynamic>{
      'choices': instance.choices == null
          ? null
          : const _ObservableListJsonConverter().toJson(instance.choices),
      'selectedCategory': instance.selectedCategory,
      'status': _$StatusEnumMap[instance.status],
      'savingStatus': _$StatusEnumMap[instance.savingStatus]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$StatusEnumMap = <Status, dynamic>{
  Status.IDLE: 'IDLE',
  Status.LOADING: 'LOADING',
  Status.ERROR: 'ERROR'
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

  final _$statusAtom = Atom(name: '_ChoiceList.status');

  @override
  Status get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$savingStatusAtom = Atom(name: '_ChoiceList.savingStatus');

  @override
  Status get savingStatus {
    _$savingStatusAtom.context.enforceReadPolicy(_$savingStatusAtom);
    _$savingStatusAtom.reportObserved();
    return super.savingStatus;
  }

  @override
  set savingStatus(Status value) {
    _$savingStatusAtom.context.conditionallyRunInAction(() {
      super.savingStatus = value;
      _$savingStatusAtom.reportChanged();
    }, _$savingStatusAtom, name: '${_$savingStatusAtom.name}_set');
  }

  final _$loadFromLocalAsyncAction = AsyncAction('loadFromLocal');

  @override
  Future<void> loadFromLocal() {
    return _$loadFromLocalAsyncAction.run(() => super.loadFromLocal());
  }

  final _$saveToLocalAsyncAction = AsyncAction('saveToLocal');

  @override
  Future<void> saveToLocal() {
    return _$saveToLocalAsyncAction.run(() => super.saveToLocal());
  }

  final _$_ChoiceListActionController = ActionController(name: '_ChoiceList');

  @override
  void undoDelete() {
    final _$actionInfo = _$_ChoiceListActionController.startAction();
    try {
      return super.undoDelete();
    } finally {
      _$_ChoiceListActionController.endAction(_$actionInfo);
    }
  }

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
