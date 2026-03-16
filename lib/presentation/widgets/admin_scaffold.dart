import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../core/theme/app_colors.dart';
import 'sidebar.dart';

class AdminScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;

  AdminScaffold({
    super.key,
    required this.body,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1100;

        if (isDesktop) {
          return Scaffold(
            body: Row(
              children: [
                Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context, showMenuButton: false),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: body,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Mobile / Tablet Layout
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(
              title,
              style: AppTypography.base.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              if (actions != null) ...actions!,
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_outlined),
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.warning,
                child: Text(
                  'AS',
                  style: AppTypography.base.copyWith(fontSize: 12, color: AppColors.white),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          drawer: Drawer(width: 250, child: Sidebar()),
          body: body,
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, {required bool showMenuButton}) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (showMenuButton) ...[
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            ),
            SizedBox(width: 16),
          ],
          Text(
            title,
            style: AppTypography.base.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          // Actions
          if (actions != null) ...actions!,

          // Default Actions (Notification & Profile)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
            color: AppColors.textSecondary,
          ),
          SizedBox(width: 16),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.divider)),
            ),
            child: Row(
              children: [
                SizedBox(width: 16),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.warning, // Placeholder color
                  // backgroundImage: NetworkImage('...'),
                  child: Text(
                    'AS',
                    style: AppTypography.base.copyWith(fontSize: 12, color: AppColors.white),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aryan Sharma',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Super Admin',
                      style: AppTypography.base.copyWith(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



