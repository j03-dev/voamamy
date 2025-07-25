import 'package:flutter/material.dart';

class GroupDashboardScreen extends StatefulWidget {
  const GroupDashboardScreen({super.key});

  @override
  State<GroupDashboardScreen> createState() => _GroupDashboardScreenState();
}

class _GroupDashboardScreenState extends State<GroupDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Group dashboard screen")),
    );
  }
}
