import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? _fullName, _phoneNumber, _password;

  _submit() async {
    try {
      if (_formKey.currentState!.validate()) _formKey.currentState?.save();
      await _authService.login(_phoneNumber, _password);
    } on DioException catch (e) {
      String message = e.response?.data["message"];
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InputField(
                label: 'Full name',
                icon: Icons.person,
                initialValue: _fullName,
                onSaved: (value) => _fullName = value,
              ),
              InputField(
                label: 'Phone number',
                icon: Icons.phone,
                initialValue: _phoneNumber,
                onSaved: (value) => _phoneNumber = value,
              ),
              InputField(
                label: 'Password',
                icon: Icons.key,
                isPassword: true,
                initialValue: _password,
                onSaved: (value) => _password = value,
              ),
              RoundedButton(
                action: _submit,
                text: 'Login',
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
