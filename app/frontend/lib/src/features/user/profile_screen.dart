import 'package:flutter/material.dart';
import 'package:frontend/src/core/validator.dart';
import 'package:frontend/src/features/auth/auth_service.dart';
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
  bool _isEdited = false;
  final _userService = UserService();

  String? _fullName, _phoneNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  _fetchUser() async {
    final fetchedUser = await _userService.me();
    setState(() {
      _currentUser = fetchedUser;
    });
  }

  _editProfile() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        final newUser = await _userService.update(
          _currentUser?.id,
          _fullName,
          _phoneNumber,
        );
        setState(() {
          _currentUser = newUser;
        });
      }
    } catch (_) {
      String message = "Failed to update the user profile";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  _logOut() async {
    await AuthService().logout();
    if (mounted) {
      Navigator.pushNamed(context, AppRouters.login);
    }
  }

  Widget _buildProfileCard({fullName, phoneNumber}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Icon(Icons.person, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child:
                (!_isEdited)
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          phoneNumber,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    )
                    : Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: fullName,
                            onSaved: (value) => _fullName = value,
                            validator: (value) {
                              return requiredValidation(
                                value,
                                "Please enter your full name",
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: phoneNumber,
                            onSaved: (value) => _phoneNumber = value,
                            validator: (value) {
                              final error = requiredValidation(
                                value,
                                "Please enter your password",
                              );
                              if (error != null) return error;
                              return passwordValidation(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              TextButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isEdited = false;
                                  });
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  _editProfile();
                                  setState(() {
                                    _isEdited = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
          ),
          if (!_isEdited)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEdited = true;
                });
              },
              child: Icon(Icons.edit, color: Colors.grey, size: 20),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            Center(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileCard(
              fullName: _currentUser?.full_name ?? 'Loading...',
              phoneNumber: _currentUser?.phone_number ?? 'Loading...',
            ),
            const SizedBox(height: 40),
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
