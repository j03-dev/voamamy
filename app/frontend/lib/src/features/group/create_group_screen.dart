import 'package:flutter/material.dart';
import 'package:frontend/src/features/group/group_service.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupService = GroupService();

  String? _name;
  final _formKey = GlobalKey<FormState>();

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      await _groupService.create(_name);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Group Created")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Create Savings Group",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              InputField(
                label: "Group Name",
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: 'Create Group',
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                action: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
