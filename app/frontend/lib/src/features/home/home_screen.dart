import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Jean",
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
                      action: () {},
                    ),
                    FeatureCard(
                      icon: Icons.group,
                      label: "Join a Group",
                      action: () {},
                    ),
                    FeatureCard(
                      icon: Icons.show_chart,
                      label: "My Group Savings",
                      action: () {},
                    ),
                    FeatureCard(
                      icon: Icons.attach_money,
                      label: "Request a Loan",
                      action: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
