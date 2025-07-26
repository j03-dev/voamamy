import 'package:flutter/material.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/services/user_service.dart';
import 'package:frontend/src/widgets/rounded_button.dart';

class ProfileSecreen extends StatefulWidget {
  const ProfileSecreen({super.key});

  @override
  State<ProfileSecreen> createState() => _ProfileSecreenState();
}

class _ProfileSecreenState extends State<ProfileSecreen> {
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
          children: [
            const SizedBox(width: 40),
            Text(
              "Profile",
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
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
            SizedBox(height: MediaQuery.of(context).size.height * .57),
            RoundedButton(
              text: "Log Out",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              action: _logOut,
            ),
          ],
        ),
      ),
    );
  }
}
