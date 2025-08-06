import 'package:flutter/material.dart';
import 'package:frontend/src/core/validator.dart';
import 'package:frontend/src/viewmodels/group_view_model.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String? _name;
  final _formKey = GlobalKey<FormState>();

  _submit(GroupViewModel groupViewModel) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      bool success = await groupViewModel.createGroup(_name);
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Group Created")));
          Navigator.pop(context);
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(groupViewModel.errorMessage!)));
      }
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
                validator: (value) {
                  return requiredValidation(
                    value,
                    "Please enter the group name",
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<GroupViewModel>(
                builder: (context, groupViewModel, child) {
                  return RoundedButton(
                    text:
                        groupViewModel.isLoading
                            ? 'Creating...'
                            : 'Create Group',
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    action:
                        groupViewModel.isLoading
                            ? () {}
                            : () => _submit(groupViewModel),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
