import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: [Text("Wellcome to home screen")]),
        ),
      ),
    );
  }
}
