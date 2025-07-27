import 'package:flutter/material.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
import 'package:frontend/src/widgets/profile_card.dart';
import 'package:frontend/src/widgets/setting_item.dart';
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
    if (mounted) {
      Navigator.pushNamed(context, AppRouters.login);
    }
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
            ProfileCard(
              icon: Icons.person,
              label: _currentUser?.full_name ?? 'Loading...',
              subtitle: _currentUser?.phone_number ?? 'Loading...',
              action: () {},
            ),
            const SizedBox(height: 40),
            Text(
              "Settings:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SettingItem(
              icon: Icons.notifications,
              label: "Notifications",
              action: () {},
            ),
            const SizedBox(height: 10),
            SettingItem(
              icon: Icons.language,
              label: "Change Language",
              action: () {},
            ),
            const SizedBox(height: 10),
            SettingItem(
              icon: Icons.help,
              label: "Help & Support",
              action: () {},
            ),
            const SizedBox(height: 10),
            SettingItem(
              icon: Icons.privacy_tip,
              label: "Privacy Policy",
              action: () {},
            ),
            const SizedBox(height: 10),
            SettingItem(
              icon: Icons.info_outline,
              label: "About",
              action: () {},
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
