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
  User? _currentUser;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    final fetchedUser = await _userService.me();
    setState(() {
      _currentUser = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lastName =
        _currentUser != null
            ? _currentUser!.full_name.split(" ").last
            : "Loading...";

    final double verticalSpacing = MediaQuery.of(context).size.height * 0.02;
    final double largeTextSize = MediaQuery.of(context).size.width * 0.09;
    final double mediumTextSize = MediaQuery.of(context).size.width * 0.055;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: verticalSpacing * 1.5),
              Text(
                "Hello, $lastName",
                style: TextStyle(
                  fontSize: largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: verticalSpacing),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(207, 245, 223, 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "You have contributed this weeek",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: mediumTextSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: verticalSpacing * 2.5),
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
          IconButton(icon: Icon(Icons.group, size: 32), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.person, size: 32),
            onPressed: () {
              Navigator.pushNamed(context, AppRouters.profile);
            },
          ),
        ],
      ),
    );
  }
}
