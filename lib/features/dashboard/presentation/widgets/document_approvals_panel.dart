import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class DocumentApprovalsPanel extends StatelessWidget {
  DocumentApprovalsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderBlack, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text('Document Approvals', style: AppTypography.h3),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.greenColour.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${state.pendingApprovals} PENDING',
                        style: AppTypography.bodyRegular.copyWith(
                          color: AppColors.greenColour,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.borderBlack, thickness: 1),

              ...state.driverApprovals.map(
                (driver) => _DriverApprovalCard(driver: driver),
              ),

              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'VIEW ALL PENDING',
                      style: AppTypography.bodyRegular.copyWith(
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DriverApprovalCard extends StatelessWidget {
  final DriverApproval driver;
  const _DriverApprovalCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderBlack.withAlpha(20),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.cFFE8F5FF,
                child: Icon(
                  Icons.person_outline,
                  size: 16,
                  color: AppColors.grey,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name,
                    style: AppTypography.bodyLarge.copyWith(
                      //color: AppColors.textGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                driver.driverId,
                style: AppTypography.bodyRegular.copyWith(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
                // style: AppTypography.base.copyWith(
                //   fontSize: 12,
                //   fontWeight: FontWeight.w500,
                //   color: AppColors.cFF8E9BAB,
                // ),
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Text(
                '${driver.documentCount} DOCUMENTS',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
                // style: AppTypography.base.copyWith(
                //   fontSize: 12,
                //   color: AppColors.cFF4F4F4F,
                //   fontWeight: FontWeight.w600,
                // ),
              ),
              Spacer(),
              Text(
                '${driver.progress}%',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                // style: AppTypography.base.copyWith(
                //   fontSize: 12,
                //   fontWeight: FontWeight.w600,
                //   color: AppColors.cFF1A2332,
                // ),
              ),
            ],
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: driver.progress / 100,
              minHeight: 6,
              backgroundColor: AppColors.cFFEEF0F4,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.greenColour,
              ),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ...driver.approvedDocs.map(
                (doc) => _DocTag(label: doc, isApproved: true),
              ),
              ...driver.pendingDocs.map(
                (doc) => _DocTag(label: doc, isApproved: false),
              ),
            ],
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.borderBlack.withAlpha(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'VIEW FILE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<DashboardCubit>().approveDriver(
                      driver.driverId,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenColour,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'APPROVE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocTag extends StatelessWidget {
  final String label;
  final bool isApproved;
  const _DocTag({required this.label, required this.isApproved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isApproved
            ? AppColors.greenColour.withAlpha(40)
            : AppColors.btnOrange.withAlpha(40),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isApproved ? '$label ✓' : '$label •',
        style: AppTypography.base.copyWith(
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          color: isApproved ? AppColors.greenColour : AppColors.btnOrange,
        ),
      ),
    );
  }
}



