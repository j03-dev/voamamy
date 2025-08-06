import 'package:flutter/material.dart';
import 'package:frontend/src/services/auth_service.dart';
import 'package:frontend/src/features/auth/login_screen.dart';
import 'package:frontend/src/features/auth/register_screen.dart';
import 'package:frontend/src/features/group/create_group_screen.dart';
import 'package:frontend/src/features/group/group_dashbord_screen.dart';
import 'package:frontend/src/services/group_service.dart';
import 'package:frontend/src/features/group/join_group_screen.dart';
import 'package:frontend/src/features/group/request_loan_screen.dart';
import 'package:frontend/src/features/home/home_screen.dart';
import 'package:frontend/src/features/user/profile_screen.dart';
import 'package:frontend/src/routes/app_routers.dart';
import 'package:frontend/src/services/user_service.dart';
import 'package:frontend/src/viewmodels/auth_view_model.dart';
import 'package:frontend/src/viewmodels/group_view_model.dart';
import 'package:frontend/src/viewmodels/user_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<UserService>(create: (_) => UserService()),
        Provider<GroupService>(create: (_) => GroupService()),

        ChangeNotifierProvider<AuthViewModel>(
          create:
              (context) => AuthViewModel(
                Provider.of<AuthService>(context, listen: false),
              ),
        ),
        ChangeNotifierProvider<UserViewModel>(
          create:
              (context) => UserViewModel(
                Provider.of<UserService>(context, listen: false),
              ),
        ),
        ChangeNotifierProvider<GroupViewModel>(
          create:
              (context) => GroupViewModel(
                Provider.of<GroupService>(context, listen: false),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Voamamy',
        theme: ThemeData(
          appBarTheme: AppBarTheme(centerTitle: true),
          primaryColor: Color.fromRGBO(25, 158, 91, 1.0),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(52, 152, 219, 1.0),
            outline: const Color.fromRGBO(217, 217, 217, 1.0),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          AppRouters.home: (_) => const HomeScreen(),
          AppRouters.login: (_) => const LoginScreen(),
          AppRouters.register: (_) => const RegisterScreen(),
          AppRouters.profile: (_) => const ProfileScreen(),
          AppRouters.create_group: (_) => const CreateGroupScreen(),
          AppRouters.join_group: (_) => const JoinGroupScreen(),
          AppRouters.group_dashboard: (_) => const GroupDashboardScreen(),
          AppRouters.request_loan: (_) => const RequestLoanScreen(),
        },
      ),
    );
  }
}
