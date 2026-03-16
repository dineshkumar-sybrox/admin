import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class IncentiveDetailScreen extends StatelessWidget {
  IncentiveDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StatCardsSection(),
            SizedBox(height: 32),
            const _ActionSection(),
            SizedBox(height: 24),
            const _DriverListTable(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatCardsSection extends StatelessWidget {
  const _StatCardsSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'TOTAL PARTICIPATING',
            value: '1,248',
            subtitle: 'Drivers',
            isPrimary: true,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _StatCard(
            title: 'COMPLETED TARGET',
            value: '848',
            subtitle: 'Total Payout: ₹21,22,500',
            isPrimary: false,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _StatCard(
            title: 'PENDING PROGRESS',
            value: '400',
            subtitle: 'Focusing on high-probability completions',
            isPrimary: false,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool isPrimary;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isPrimary) Container(width: 3, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        value,
                        style: AppTypography.h1.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 300,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey.shade300),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by ID or Driver...',
                  hintStyle: AppTypography.bodyRegular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            _buildDropdownFilter('Achievement Badge'),
            SizedBox(width: 16),
            _buildDropdownFilter('All Status'),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.download, size: 20),
          label: Text('Export CSV'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppTypography.bodyRegular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter(String hint) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hint,
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _DriverListTable extends StatelessWidget {
  const _DriverListTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(bottom: BorderSide(color: AppColors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'DRIVER ID',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'DRIVER NAME',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'ACHIEVEMENT\nBADGE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'RIDE\nCOMPLETION',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'PROGRESS BAR',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'STATUS',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Table Rows
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildDriverRow(
                id: 'DRV-00281',
                name: 'Arjun\nSharma',
                tier: 'TIER 3',
                iconData: Icons.diamond_outlined,
                completionMain: '12 / 12',
                completionSub: 'GOAL REACHED',
                progressName: 'Tier 3 (Platinum)',
                progressPct: 100,
                progressColor: AppColors.primary,
                status: 'COMPLETED',
                statusColor: AppColors.primary,
                statusBgColor: AppColors.cFFE8F5E9,
              ),
              _buildDriverRow(
                id: 'DRV-00280',
                name: 'Arun\nSharma',
                tier: 'TIER 2',
                iconData: Icons.emoji_events_outlined,
                completionMain: '08 / 12',
                completionSub: '5 LEFT TO MILESTONE',
                progressName: 'Tier 3 (Gold)',
                progressPct: 60,
                progressColor: AppColors.amber.shade600,
                status: 'PENDING',
                statusColor: AppColors.amber.shade800,
                statusBgColor: AppColors.cFFFFF8E1,
              ),
              _buildDriverRow(
                id: 'DRV-00265',
                name: 'Karan\nSharma',
                tier: 'TIER 1',
                iconData: Icons.verified_outlined,
                completionMain: '04 / 12',
                completionSub: '7 LEFT TO MILESTONE',
                progressName: 'Tier 3 (Silver)',
                progressPct: 30,
                progressColor: AppColors.blue.shade500,
                status: 'PENDING',
                statusColor: AppColors.amber.shade800,
                statusBgColor: AppColors.cFFFFF8E1,
              ),
              _buildDriverRow(
                id: 'DRV-00232',
                name: 'Sam\nKumar',
                tier: 'TIER 3',
                iconData: Icons.diamond_outlined,
                completionMain: '11 / 12',
                completionSub: '1 LEFT TO MILESTONE',
                progressName: 'Tier 3 (Platinum)',
                progressPct: 90,
                progressColor: AppColors.primary,
                status: 'COMPLETED',
                statusColor: AppColors.primary,
                statusBgColor: AppColors.cFFE8F5E9,
              ),
              _buildDriverRow(
                id: 'DRV-00255',
                name: 'Arjun\nKumar',
                tier: 'TIER 3',
                iconData: Icons.diamond_outlined,
                completionMain: '09 / 12',
                completionSub: '3 LEFT TO MILESTONE',
                progressName: 'Tier 3 (Platinum)',
                progressPct: 70,
                progressColor: AppColors.primary,
                status: 'COMPLETED',
                statusColor: AppColors.primary,
                statusBgColor: AppColors.cFFE8F5E9,
              ),
            ],
          ),
          // Pagination Footer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing 5 of 1243 is there',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: AppColors.grey.shade400,
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '2',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '3',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.chevron_right, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverRow({
    required String id,
    required String name,
    required String tier,
    required IconData iconData,
    required String completionMain,
    required String completionSub,
    required String progressName,
    required int progressPct,
    required Color progressColor,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'ID: $id',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  tier,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 8),
                Icon(iconData, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  completionMain,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  completionSub,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        progressName,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '$progressPct%',
                        style: AppTypography.bodySmall.copyWith(
                          color: progressColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
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
                            width: constraints.maxWidth * (progressPct / 100),
                            decoration: BoxDecoration(
                              color: progressColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




