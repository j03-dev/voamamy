import 'package:flutter/material.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/services/user_service.dart';
import 'package:frontend/src/widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userService = UserService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    final fetchedUser = await _userService.me();
    setState(() {
      _currentUser = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _fullName = _currentUser != null ? _currentUser!.full_name : "";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Hello, $_fullName",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "You have contributed this weeek",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(207, 245, 223, 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    FeatureCard(
                      icon: Icons.create_new_folder,
                      label: "Create a Group",
                      action: () {
                        Navigator.pushNamed(context, AppRouters.create_group);
                      },
                    ),
                    FeatureCard(
                      icon: Icons.group,
                      label: "Join a Group",
                      action: () {
                        Navigator.pushNamed(context, AppRouters.join_group);
                      },
                    ),
                    FeatureCard(
                      icon: Icons.show_chart,
                      label: "My Group Savings",
                      action: () {
                        Navigator.pushNamed(
                          context,
                          AppRouters.group_dashboard,
                        );
                      },
                    ),
                    FeatureCard(
                      icon: Icons.attach_money,
                      label: "Request a Loan",
                      action: () {
                        Navigator.pushNamed(context, AppRouters.request_loan);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          IconButton(
            icon: Icon(Icons.home, size: 32),
            onPressed: () {
              Navigator.pushNamed(context, AppRouters.home);
            },
          ),
          IconButton(icon: Icon(Icons.groups, size: 32), onPressed: () {}),
          IconButton(icon: Icon(Icons.person, size: 32), onPressed: () {}),
        ],
      ),
    );
  }
}
