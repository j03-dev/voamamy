import 'package:flutter/material.dart';
import 'package:frontend/src/viewmodels/group_view_model.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class RequestLoanScreen extends StatefulWidget {
  const RequestLoanScreen({super.key});

  @override
  State<RequestLoanScreen> createState() => _RequestLoanScreenState();
}

class _RequestLoanScreenState extends State<RequestLoanScreen> {
  String? _amount;
  final _formKey = GlobalKey<FormState>();

  void _requestLoan(GroupViewModel groupViewModel) async {
    bool success = await groupViewModel.requestLoan(amount: _amount);
    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Loan Requested")));
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
      appBar: AppBar(title: const Text("Request a loan")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                label: "Enter Amount",
                icon: Icons.attach_money,
                onSaved: (value) => _amount = value,
                suffixWidget: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("MGA"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<GroupViewModel>(
                builder: (context, groupViewModel, child) {
                  return RoundedButton(
                    text:
                        groupViewModel.isLoading
                            ? 'Requesting..'
                            : "Request Loan",
                    action:
                        groupViewModel.isLoading
                            ? () {}
                            : () => _requestLoan(groupViewModel),
                    textColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
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
