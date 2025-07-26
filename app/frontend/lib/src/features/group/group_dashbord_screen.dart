import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/check_list.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class GroupDashboardScreen extends StatefulWidget {
  const GroupDashboardScreen({super.key});

  @override
  State<GroupDashboardScreen> createState() => _GroupDashboardScreenState();
}

class _GroupDashboardScreenState extends State<GroupDashboardScreen> {
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
              "My Savings Group",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Text(
              "Total Savings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "1,200,000 MGA",
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
