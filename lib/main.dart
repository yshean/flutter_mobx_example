import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx_example/screens/DecideScreen.dart';
import 'package:flutter_mobx_example/stores/choice_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ChoiceList store = ChoiceList();

  @override
  void initState() {
    // TODO: 10a. Call the loadFromLocal function
    store.loadFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 3. Add provider for the choice list
    return BlocProvider(
      blocs: [Bloc((i) => store)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: DecideScreen(),
      ),
    );
  }
}
