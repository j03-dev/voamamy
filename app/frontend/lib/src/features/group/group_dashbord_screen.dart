import 'package:flutter/material.dart';
import 'package:frontend/src/viewmodels/group_view_model.dart';
import 'package:frontend/src/widgets/check_list.dart';
import 'package:frontend/src/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class GroupDashboardScreen extends StatefulWidget {
  const GroupDashboardScreen({super.key});

  @override
  State<GroupDashboardScreen> createState() => _GroupDashboardScreenState();
}

class _GroupDashboardScreenState extends State<GroupDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupViewModel>(context, listen: false).fetchMyGroup();
    });
  }

  void _markAsContributed(GroupViewModel groupViewModel) async {
    bool success = await groupViewModel.markAsContributed();
    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Contribution marked sucessfully!")),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(groupViewModel.errorMessage!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<GroupViewModel>(
        builder: (context, groupViewModel, child) {
          if (groupViewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (groupViewModel.errorMessage != null) {
            return Center(child: Text('Error: ${groupViewModel.errorMessage}'));
          } else if (groupViewModel.currentGroup == null) {
            return Center(child: Text('No Group data available.'));
          }

          final currentGroup = groupViewModel.currentGroup!;

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentGroup.name,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Text(
                  "Total Savings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  currentGroup.savings.toString(),
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  text:
                      groupViewModel.isLoading
                          ? 'Marking'
                          : 'Mark as Contributed',
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  textColor: Colors.white,
                  action:
                      groupViewModel.isLoading
                          ? () {}
                          : () => _markAsContributed(groupViewModel),
                ),
                const SizedBox(height: 20),
                Text(
                  "Adding Members",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Column(
                  spacing: 10,
                  children:
                      currentGroup.members
                          .map(
                            (member) => CheckList(
                              leftItem: member.user.full_name,
                              rightItem: member.user.phone_number,
                              status: member.has_contributed_this_week,
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
