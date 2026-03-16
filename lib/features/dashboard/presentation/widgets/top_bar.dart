import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  final String title;
  TopBar({super.key, this.title = 'Dashboard'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.cFFE8ECF0, width: 1)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.cFF1A2332,
            ),
          ),
          Spacer(),

          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 16,
                  color: AppColors.cFF6B7A8D,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.cFFFF4757,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Container(width: 1, height: 24, color: AppColors.cFFDDE2E8),
          SizedBox(width: 10),

          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(
                  0xFF00A86B,
                ).withValues(alpha: 0.15),
                child: Text(
                  'AS',
                  style: AppTypography.base.copyWith(
                    color: AppColors.cFF00A86B,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aryan Sharma',
                    style: AppTypography.base.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF1A2332,
                    ),
                  ),
                  Text(
                    'Super Admin',
                    style: AppTypography.base.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cFF6B7A8D,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}




