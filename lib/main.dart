import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx_example/screens/DecideScreen.dart';
import 'package:flutter_mobx_example/services/storable_service.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _storable = ChoiceListLocalStorableService();
  ChoiceList _choiceList = ChoiceList();

  // _MyAppState() {
  //   _storable.loadData().then((res) {
  //     if (res != null) {
  //       print('res: ${res.choices.length}');
  //       setState(() {
  //         // _choiceList.choices = res.choices;
  //         _choiceList = res;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    _choiceList.loadFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('choiceList: ${_choiceList.choices.length}');
    // TODO: 2. Add provider for the list
    return BlocProvider(
      // blocs: [Bloc((i) => ChoiceList(choiceList: _choiceList))],
      blocs: [Bloc((i) => _choiceList)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.yellow,
        ),
        home: DecideScreen(),
      ),
    );
  }
}
