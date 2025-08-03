import 'package:flutter/material.dart';
import 'package:frontend/src/features/group/group_service.dart';
import 'package:frontend/src/models/group.dart';
import 'package:frontend/src/widgets/check_list.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class GroupDashboardScreen extends StatefulWidget {
  const GroupDashboardScreen({super.key});

  @override
  State<GroupDashboardScreen> createState() => _GroupDashboardScreenState();
}

class _GroupDashboardScreenState extends State<GroupDashboardScreen> {
  Group? _currentGroup;
  final _groupService = GroupService();

  @override
  void initState() {
    super.initState();
    _fetchGroup();
  }

  _fetchGroup() async {
    try {
      final fetchedGroup = await _groupService.my();
      setState(() {
        _currentGroup = fetchedGroup;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "May be you don't have group yet, so pls join group or create one!",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _currentGroup?.name ?? "Loading...",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Text(
              "Total Savings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              _currentGroup?.savings ?? "Loading...",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RoundedButton(
              text: 'Mark as Contributed',
              backgroundColor: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              action: () {},
            ),
            const SizedBox(height: 20),
            Text(
              "Adding Members",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            // TODO: Iter members from _currentGroup
            Column(
              spacing: 10,
              children: [
                CheckList(
                  leftItem: "Jean",
                  rightItem: "124 456 780",
                  status: Status.Checked,
                ),
                CheckList(
                  leftItem: "Marie",
                  rightItem: "123 456 780",
                  status: Status.Checked,
                ),
                CheckList(
                  leftItem: "Joseph",
                  rightItem: "123 456 780",
                  status: Status.Checked,
                ),
                CheckList(
                  leftItem: "Luc",
                  rightItem: "123 456 780",
                  status: Status.Pedding,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
