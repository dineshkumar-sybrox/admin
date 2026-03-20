import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'auth_text_field.dart';

class CreateNewPasswordForm extends StatefulWidget {
  const CreateNewPasswordForm({super.key});

  @override
  State<CreateNewPasswordForm> createState() => _CreateNewPasswordFormState();
}

class _CreateNewPasswordFormState extends State<CreateNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Security requirements states
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create New Password',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Enter your new password below to regain access to your administrative account.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          AuthTextField(
            label: 'New Password',
            hintText: 'Enter new password',
            prefixIcon: Icons.lock_outlined,
            isPassword: _obscurePassword,
            controller: _passwordController,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 24),
          AuthTextField(
            label: 'Confirm New Password',
            hintText: 'Confirm new password',
            prefixIcon: Icons.lock_outlined,
            isPassword: _obscureConfirmPassword,
            controller: _confirmPasswordController,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Security Requirements Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SECURITY REQUIREMENTS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 16),
                _buildRequirementRow('At least 8 characters', _hasMinLength),
                const SizedBox(height: 12),
                _buildRequirementRow('One uppercase letter', _hasUppercase),
                const SizedBox(height: 12),
                _buildRequirementRow('One special character', _hasSpecialChar),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement update password logic
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.activeGreen, // More vibrant green
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Update Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: const Text(
                'Back to Sign In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.activeGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isMet ? AppColors.activeTagBg : const Color(0xFFE5E7EB),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            size: 14,
            color: isMet ? AppColors.activeTagText : Colors.transparent,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isMet ? AppColors.textPrimary : AppColors.textGrey,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
