import 'package:flutter/material.dart';
import 'package:frontend/src/core/validator.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/viewmodels/auth_view_model.dart';
import 'package:frontend/src/widgets/input_field.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber, _password;

  _submit(AuthViewModel authViewModel) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      bool success = await authViewModel.login(_phoneNumber, _password);
      if (success) {
        if (mounted) {
          Navigator.pushNamed(context, AppRouters.home);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(authViewModel.errorMessage!)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Welcome back",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Log in to your savings group",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              InputField(
                label: 'Phone number',
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
                label: 'Password',
                icon: Icons.key,
                isPassword: true,
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
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return RoundedButton(
                    action:
                        authViewModel.isLoading
                            ? () {}
                            : () => _submit(authViewModel),
                    text: authViewModel.isLoading ? 'Logging In...' : "Log In",
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Text("Dont't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouters.register);
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
