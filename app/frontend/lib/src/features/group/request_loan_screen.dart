import 'package:flutter/material.dart';

class RequestLoanScreen extends StatefulWidget {
  const RequestLoanScreen({super.key});

  @override
  State<RequestLoanScreen> createState() => _RequestLoanScreenState();
}

class _RequestLoanScreenState extends State<RequestLoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Request a loan")));
  }
}
