import 'dart:convert';

import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceListLocalStorableService {
  // final Function(Map<String, dynamic>) _fromJson;
  // final Function(T) _toJson;
  final String _attrName = "choices";

  // LocalStorableService(this._fromJson, this._toJson, this._attrName);
  ChoiceListLocalStorableService();

  // T fromJson(Map<String, dynamic> json) => _fromJson(json);
  // Map<String, dynamic> toJson(T list) => _toJson(list);

  Future<ChoiceList> loadData() async {
    print("loading data!");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final localStoreValue = prefs.getString(_attrName);
    ChoiceList decoded;
    if (localStoreValue != null) {
      print(localStoreValue);
      // Map<String, dynamic> json =
      //     Map<String, dynamic>.from(jsonDecode(localStoreValue));
      // print('JSON: $json');
      // print('Runtime type: ${json.runtimeType}');
      decoded = ChoiceList.fromJson(
          Map<String, dynamic>.from(jsonDecode(localStoreValue)));
      print(decoded.choices[0].answer);
      print(decoded.selectedCategory);
    }
    return decoded;
  }

  Future<void> saveData(ChoiceList list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_attrName, jsonEncode(list.toJson()));
  }
}
