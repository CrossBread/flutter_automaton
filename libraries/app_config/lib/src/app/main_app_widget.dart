import 'package:flutter/material.dart';
import 'package:presentation/automaton/pages/automaton_page.dart';

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automaton',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: AutomatonPage(),
    );
  }
}
