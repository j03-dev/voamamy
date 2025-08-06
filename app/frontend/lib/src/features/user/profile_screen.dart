import 'package:flutter/material.dart';
import 'package:frontend/src/core/validator.dart';
import 'package:frontend/src/viewmodels/auth_view_model.dart';
import 'package:frontend/src/viewmodels/user_view_model.dart';
import 'package:frontend/src/widgets/setting_item.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEdited = false;
  String? _fullName, _phoneNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchCurrentUser();
    });
  }

  _editProfile(UserViewModel userViewModel) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final currentUser = userViewModel.currentUser;
      final success = await userViewModel.updateCurrentUser(
        currentUser?.id,
        _fullName,
        _phoneNumber,
      );
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile updated successfully!")),
          );
        }
        setState(() {
          _isEdited = false;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(userViewModel.errorMessage!)));
        }
      }
    }
  }

  _logOut(AuthViewModel authViewModel, UserViewModel userViewModel) async {
    await authViewModel.logout();
    userViewModel.clearUserData();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouters.login,
        (route) => false,
      );
    }
  }

  Widget _buildProfileCard({required UserViewModel userViewModel}) {
    final fullName = userViewModel.currentUser?.full_name ?? "Loading...";
    final phoneNumber = userViewModel.currentUser?.phone_number ?? "Loading...";

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
                              Consumer<UserViewModel>(
                                builder: (context, userViewModel, child) {
                                  return TextButton(
                                    onPressed:
                                        userViewModel.isLoading
                                            ? null
                                            : () {
                                              _editProfile(userViewModel);
                                            },
                                    child:
                                        userViewModel.isLoading
                                            ? CircularProgressIndicator()
                                            : Text(
                                              "Save",
                                              style: TextStyle(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).primaryColor,
                                              ),
                                            ),
                                  );
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
            Consumer<UserViewModel>(
              builder: (context, userViewModel, child) {
                if (userViewModel.isLoading &&
                    userViewModel.currentUser == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (userViewModel.errorMessage != null) {
                  return Center(
                    child: Text('Error: ${userViewModel.errorMessage}'),
                  );
                }
                return _buildProfileCard(userViewModel: userViewModel);
              },
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
      bottomNavigationBar: Consumer2<AuthViewModel, UserViewModel>(
        builder: (context, authViewModel, userViewModel, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: RoundedButton(
              text: authViewModel.isLoading ? "Logging Out..." : "Log Out",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              action:
                  authViewModel.isLoading
                      ? () {}
                      : () => _logOut(authViewModel, userViewModel),
            ),
          );
        },
      ),
    );
  }
}
