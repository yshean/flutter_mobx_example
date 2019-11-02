import 'dart:convert';

import 'package:flutter_mobx_example/stores/choice_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceListLocalStorableService {
  final String _attrName = "choices";

  ChoiceListLocalStorableService();

  Future<ChoiceList> loadData() async {
    print("loading data!");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final localStoreValue = prefs.getString(_attrName);
    ChoiceList decoded;
    if (localStoreValue != null) {
      decoded = ChoiceList.fromJson(
          Map<String, dynamic>.from(jsonDecode(localStoreValue)));
    }
    return decoded;
  }

  Future<void> saveData(ChoiceList list) async {
    print('saving list: ${list.toJson()}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_attrName, jsonEncode(list.toJson()));
  }
}
