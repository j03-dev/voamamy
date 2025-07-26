import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Create Savings Group",
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            InputField(label: "Group Name"),
            const SizedBox(height: 20),
            RoundedButton(
              text: 'Create Group',
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              action: () {},
            ),
          ],
        ),
      ),
    );
  }
}
