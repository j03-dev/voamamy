import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/core/validator.dart';
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Create an account",
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    label: "Full Name",
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
                  const SizedBox(height: 40),
                  RoundedButton(
                    text: "Register",
                    action: _submit,
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouters.login);
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
