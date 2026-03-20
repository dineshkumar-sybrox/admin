import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'features/auth/presentation/pages/signup_screen.dart';

void main() {
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit()..loadDashboard(),
      child: MaterialApp(
        title: 'GoAPP Admin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SignupScreen(),
      ),
    );
  }
}
