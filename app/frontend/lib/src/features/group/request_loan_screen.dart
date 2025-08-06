import 'package:flutter/material.dart';
import 'package:frontend/src/features/group/group_service.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class RequestLoanScreen extends StatefulWidget {
  const RequestLoanScreen({super.key});

  @override
  State<RequestLoanScreen> createState() => _RequestLoanScreenState();
}

class _RequestLoanScreenState extends State<RequestLoanScreen> {
  String? _amount;
  final _groupService = GroupService();
  final _formKey = GlobalKey<FormState>();

  void _requestLoan() async {
    try {
      await _groupService.requestLoan(amount: _amount);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Loan Requested")));
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have alredy laon that pending or not yet repaid."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request a loan")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                label: "Enter Amount",
                onSaved: (value) => _amount = value,
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: "Request Loan",
                action: _requestLoan,
                textColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
