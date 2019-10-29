import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../stores/choice.dart';

abstract class StorableService<T> {
  T fromJson(String json);
  String toJson(T list);

  Future<T> loadData();
  void saveData(T list);
}

class LocalStorableService<T> implements StorableService<T> {
  final Function(String) _fromJson;
  final Function(T) _toJson;
  final String _attrName;

  LocalStorableService(this._fromJson, this._toJson, this._attrName);

  T fromJson(String json) => _fromJson(json);
  String toJson(T list) => _toJson(list);

  Future<T> loadData() async {
    print("loading data!");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final localStoreValue = prefs.getString(_attrName);
    T decoded;
    if (localStoreValue != null) {
      decoded = fromJson(localStoreValue);
    }
    return decoded;
  }

  void saveData(T list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_attrName, toJson(list));
  }
}

class ChoiceListLocalStorableService
    extends LocalStorableService<ObservableList<Choice>> {
  static final __fromJson = ChoiceList.fromJson;
  static final __toJson = ChoiceList.toJson;
  static final __attrName = "choices";

  ChoiceListLocalStorableService() : super(__fromJson, __toJson, __attrName);
}
