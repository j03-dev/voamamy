import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authService = AuthService();
  String? _fullName, _phoneNumber, _password;
  final _formKey = GlobalKey<FormState>();

  _submit() async {
    try {
      if (_formKey.currentState!.validate()) _formKey.currentState?.save();
      await _authService.register(_phoneNumber, _fullName, _password);
      Navigator.pushNamed(context, AppRouters.login);
    } on DioException catch (e) {
      String message = e.response?.data["response"];
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
            children: [
              InputField(
                label: "Full Name",
                initialValue: _fullName,
                icon: Icons.person,
                onSaved: (value) => _fullName = value,
              ),
              InputField(
                label: "Phone Number",
                initialValue: _phoneNumber,
                icon: Icons.phone,
                onSaved: (value) => _phoneNumber = value,
              ),
              InputField(
                label: "Password",
                initialValue: _password,
                isPassword: true,
                icon: Icons.key,
                onSaved: (value) => _password = value,
              ),
              RoundedButton(
                text: "Register",
                action: _submit,
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
