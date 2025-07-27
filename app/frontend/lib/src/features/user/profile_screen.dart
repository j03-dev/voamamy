import 'package:flutter/material.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/services/user_service.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  final _userService = UserService();

  @override
  initState() {
    super.initState();
    _fetchUser();
  }

  _fetchUser() async {
    final fetchedUser = await _userService.me();
    setState(() {
      _currentUser = fetchedUser;
    });
  }

  _logOut() async {
    await AuthService().logout();
    Navigator.pushNamed(context, AppRouters.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            Text(
              "Profile",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(
              _currentUser?.full_name ?? "",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              _currentUser?.phone_number ?? "",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Text(
              "Settings:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              child: Row(
                spacing: 5,
                children: [Icon(Icons.edit), Text("Edit Profile")],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            GestureDetector(
              child: Row(
                spacing: 5,
                children: [Icon(Icons.message), Text("Notifications")],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            GestureDetector(
              child: Row(
                spacing: 5,
                children: [Icon(Icons.language), Text("Change Language")],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            GestureDetector(
              child: Row(
                spacing: 5,
                children: [Icon(Icons.help), Text("Help")],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: RoundedButton(
          text: "Log Out",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          action: _logOut,
        ),
      ),
    );
  }
}
