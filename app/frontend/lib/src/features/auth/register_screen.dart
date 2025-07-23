import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/core/validator.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:frontend/src/widgets/separator.dart';

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
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        await _authService.register(_phoneNumber, _fullName, _password);
        Navigator.pushNamed(context, AppRouters.login);
      }
    } catch (_) {
      final message = "Make sure all of your information is correct";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 60),
              InputField(
                label: "Full Name",
                initialValue: _fullName,
                icon: Icons.person,
                onSaved: (value) => _fullName = value,
                validator: (value) {
                  return requiredValidation(
                    value,
                    "Please enter your full name",
                  );
                },
              ),
              const SizedBox(height: 20),
              InputField(
                label: "Phone Number",
                initialValue: _phoneNumber,
                icon: Icons.phone,
                onSaved: (value) => _phoneNumber = value,
                validator: (value) {
                  return requiredValidation(
                    value,
                    "Please enter your phone number",
                  );
                },
              ),
              const SizedBox(height: 20),
              InputField(
                label: "Password",
                initialValue: _password,
                isPassword: true,
                icon: Icons.key,
                onSaved: (value) => _password = value,
                validator: (value) {
                  final error = requiredValidation(
                    value,
                    "Please enter your password",
                  );
                  if (error != null) return error;
                  return passwordValidation(value);
                },
              ),
              const SizedBox(height: 50),
              RoundedButton(
                text: "Register",
                action: _submit,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              const SizedBox(height: 10),
              const Separator(),
              const SizedBox(height: 10),
              RoundedButton(
                text: "Login",
                action: () => Navigator.pushNamed(context, AppRouters.login),
                backgroundColor: Colors.white,
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
