import 'package:flutter/material.dart';
import 'package:frontend/src/features/auth/login_screen.dart';
import 'package:frontend/src/features/auth/register_screen.dart';
import 'package:frontend/src/features/home/home_screen.dart';
import 'package:frontend/src/routes/app_routers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voamamy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
      routes: {
        AppRouters.home: (_) => const HomeScreen(),
        AppRouters.login: (_) => const LoginScreen(),
        AppRouters.register: (_) => const RegisterScreen(),
      },
    );
  }
}
