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
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 46, 204, 113),
        secondaryHeaderColor: Color.fromARGB(255, 52, 152, 219),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          labelLarge: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(46, 204, 113, 1.0),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 204, 113, 1.0),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromRGBO(52, 152, 219, 1.0),
        ),
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
