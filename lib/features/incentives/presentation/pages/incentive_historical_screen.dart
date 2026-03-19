import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../../../features/dashboard/presentation/cubit/dashboard_state.dart';

class IncentiveHistoricalScreen extends StatelessWidget {
  IncentiveHistoricalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('Ongoing Incentives', style: AppTypography.h3),
                  ],
                ),
                Row(
                  children: [
                    _buildNavButton(Icons.chevron_left),
                    SizedBox(width: 8),
                    _buildNavButton(Icons.chevron_right),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _OngoingIncentiveCard(
                    status: 'LIVE',
                    type: 'DAILY',
                    vehicle: 'BIKE/SCOOTER',
                    title: 'Morning Commute Rush',
                    targetPercentage: 68,
                    participation: '1,248',
                    remaining: '04h',
                    onTap: () {
                      context.read<DashboardCubit>().selectNav(
                        NavItem.incentiveDetail,
                      );
                    },
                  ),
                  SizedBox(width: 24),
                  _OngoingIncentiveCard(
                    status: 'LIVE',
                    type: 'WEEKLY',
                    vehicle: 'BIKE/SCOOTER',
                    title: 'Weekly Rider',
                    targetPercentage: 32,
                    participation: '856',
                    remaining: '12h 15m',
                    onTap: () {
                      context.read<DashboardCubit>().selectNav(
                        NavItem.incentiveDetail,
                      );
                    },
                  ),
                  SizedBox(width: 24),
                  _OngoingIncentiveCard(
                    status: 'LIVE',
                    type: 'BONAS',
                    vehicle: 'BIKE/SCOOTER',
                    title: 'Bonas Rider',
                    targetPercentage: 60,
                    participation: '412',
                    remaining: '24h',
                    onTap: () {
                      context.read<DashboardCubit>().selectNav(
                        NavItem.incentiveDetail,
                      );
                    },
                  ),
                  SizedBox(width: 24),
                  _OngoingIncentiveCard(
                    status: 'LIVE',
                    type: 'BONAS',
                    vehicle: 'CAB',
                    title: 'Holiday Special Rider',
                    targetPercentage: 45,
                    participation: '275',
                    remaining: '36h',
                    onTap: () {
                      context.read<DashboardCubit>().selectNav(
                        NavItem.incentiveDetail,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('New Incentive List', style: AppTypography.h3),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        //controller: _searchController,
                        onChanged: (value) {
                          //context.read<TotalDocumentsCubit>().searchDocuments(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Filter campaigns by name...',
                          hintStyle: AppTypography.base.copyWith(fontSize: 13),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          filled: true,
                          fillColor: AppColors.cFFF9FAFB,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.cFFEFEFEF),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.cFFEFEFEF),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 48,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cFFF9FAFB,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey.shade300),
                      ),
                      child: Icon(Icons.tune, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey.shade100),
              ),
              child: const _IncentiveListTable(),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cFFF8FAFC,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SHOWING 1-10 OF 142 RIDES',
                    style: AppTypography.base.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Row(
                    children: [
                      _buildPageButton('<', false),
                      SizedBox(width: 8),
                      _buildPageButton('1', true),
                      SizedBox(width: 8),
                      _buildPageButton('2', false),
                      SizedBox(width: 8),
                      _buildPageButton('3', false),
                      SizedBox(width: 8),
                      _buildPageButton('>', false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageButton(String text, bool isActive) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? AppColors.cFF00A86B : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE5E7EB),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.base.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: isActive ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Center(
        child: Icon(icon, size: 20, color: AppColors.textSecondary),
      ),
    );
  }
}

class _OngoingIncentiveCard extends StatelessWidget {
  final String status;
  final String type;
  final String vehicle;
  final String title;
  final int targetPercentage;
  final String participation;
  final String remaining;
  final VoidCallback? onTap;

  const _OngoingIncentiveCard({
    required this.status,
    required this.type,
    required this.vehicle,
    required this.title,
    required this.targetPercentage,
    required this.participation,
    required this.remaining,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cFFE8F5E9,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: AppColors.primary, size: 8),
                          SizedBox(width: 4),
                          Text(
                            status,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      type,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cFFE8F5E9,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    vehicle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              title,
              style: AppTypography.h3_5.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TARGET COMPLETION',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '$targetPercentage%',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 6,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: AppColors.cFFF3F4F6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Container(
                      height: 6,
                      width: constraints.maxWidth * (targetPercentage / 100),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    // Tick marks
                    Positioned(
                      left: constraints.maxWidth * 0.33,
                      top: 0,
                      bottom: 0,
                      child: Container(width: 2, color: AppColors.white),
                    ),
                    Positioned(
                      left: constraints.maxWidth * 0.66,
                      top: 0,
                      bottom: 0,
                      child: Container(width: 2, color: AppColors.white),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PARTICIPATION',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          participation,
                          style: AppTypography.bodyRegular.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Drivers',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'REMAINING',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          remaining,
                          style: AppTypography.bodyRegular.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IncentiveListTable extends StatelessWidget {
  const _IncentiveListTable();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width > 1200
              ? MediaQuery.of(context).size.width - 320
              : 1000,
        ),
        child: DataTable(
          showCheckboxColumn: false,
          headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
          headingTextStyle: AppTypography.base.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
          dataTextStyle: AppTypography.base.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          horizontalMargin: 24,
          columnSpacing: 24,
          headingRowHeight: 56,
          dataRowMaxHeight: 72,
          dataRowMinHeight: 72,
          columns: const [
            DataColumn(label: Text('PROGRAM NAME')),
            DataColumn(label: Text('TIMELINE SCHEDULE')),
            DataColumn(label: Text('TARGET VEHICLE')),
            DataColumn(label: Text('TOTAL INCENTIVE AMOUNT')),
            DataColumn(label: Text('STATUS')),
          ],
          rows: [
            _buildTableRow(
              title: 'AfterNoon commute rush',
              type: 'Daily',
              date: 'Feb 27',
              time: '06:00 AM - 11:00 PM',
              vehicle: 'AUTO',
              vehicleColor: AppColors.cFFE3F2FD,
              vehicleTextColor: AppColors.blue.shade700,
              amount: '450.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'Pongal Special Rush',
              type: 'Bonus',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'CAB',
              vehicleColor: AppColors.cFFFFF8E1,
              vehicleTextColor: AppColors.amber.shade800,
              amount: '5,200.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'weekly Rush',
              type: 'Weekly',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'BIKE',
              vehicleColor: AppColors.cFFE8F5E9,
              vehicleTextColor: AppColors.primary,
              amount: '1,500.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'AfterNoon commute rush',
              type: 'Daily',
              date: 'Feb 27',
              time: '06:00 AM - 11:00 PM',
              vehicle: 'AUTO',
              vehicleColor: AppColors.cFFE3F2FD,
              vehicleTextColor: AppColors.blue.shade700,
              amount: '450.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'Pongal Special Rush',
              type: 'Bonus',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'CAB',
              vehicleColor: AppColors.cFFFFF8E1,
              vehicleTextColor: AppColors.amber.shade800,
              amount: '5,200.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'weekly Rush',
              type: 'Weekly',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'BIKE',
              vehicleColor: AppColors.cFFE8F5E9,
              vehicleTextColor: AppColors.primary,
              amount: '1,500.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'AfterNoon commute rush',
              type: 'Daily',
              date: 'Feb 27',
              time: '06:00 AM - 11:00 PM',
              vehicle: 'AUTO',
              vehicleColor: AppColors.cFFE3F2FD,
              vehicleTextColor: AppColors.blue.shade700,
              amount: '450.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'Pongal Special Rush',
              type: 'Bonus',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'CAB',
              vehicleColor: AppColors.cFFFFF8E1,
              vehicleTextColor: AppColors.amber.shade800,
              amount: '5,200.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'weekly Rush',
              type: 'Weekly',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'BIKE',
              vehicleColor: AppColors.cFFE8F5E9,
              vehicleTextColor: AppColors.primary,
              amount: '1,500.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'AfterNoon commute rush',
              type: 'Daily',
              date: 'Feb 27',
              time: '06:00 AM - 11:00 PM',
              vehicle: 'AUTO',
              vehicleColor: AppColors.cFFE3F2FD,
              vehicleTextColor: AppColors.blue.shade700,
              amount: '450.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'Pongal Special Rush',
              type: 'Bonus',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'CAB',
              vehicleColor: AppColors.cFFFFF8E1,
              vehicleTextColor: AppColors.amber.shade800,
              amount: '5,200.00',
              status: 'SCHEDULED',
            ),
            _buildTableRow(
              title: 'weekly Rush',
              type: 'Weekly',
              date: 'Mar 2 — Mar 9',
              time: 'Full Week',
              vehicle: 'BIKE',
              vehicleColor: AppColors.cFFE8F5E9,
              vehicleTextColor: AppColors.primary,
              amount: '1,500.00',
              status: 'SCHEDULED',
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildTableRow({
    required String title,
    required String type,
    required String date,
    required String time,
    required String vehicle,
    required Color vehicleColor,
    required Color vehicleTextColor,
    required String amount,
    required String status,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTypography.bodyRegular.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '($type)',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        DataCell(
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.cFFF9FAFB,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: AppTypography.bodyRegular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: vehicleColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              vehicle,
              style: AppTypography.bodySmall.copyWith(
                color: vehicleTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ),

        DataCell(
          Text(
            '₹$amount',
            style: AppTypography.bodyRegular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
