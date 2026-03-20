import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:admin/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:admin/features/auth/presentation/cubit/auth_state.dart';
import 'package:admin/features/auth/presentation/widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 900;

            return Row(
              children: [
                if (isLargeScreen)
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: AppColors.primary,
                      child: Center(
                        child: Image.asset(
                          'assets/images/reset.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLargeScreen ? 80 : 24,
                      vertical: 40,
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enter your email address and we\'ll send you a link to reset your password.',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textGrey,
                              ),
                            ),
                            const SizedBox(height: 48),
                            const ResetPasswordForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
