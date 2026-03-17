import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:admin/features/dashboard/presentation/cubit/dashboard_state.dart';

class ComplianceScreen extends StatelessWidget {
  ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StatCardsSection(),
            SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 13,
                  child: Column(
                    children: const [
                      _SupportTicketsChartCard(),
                      SizedBox(height: 24),
                      _RecentDocumentSubmissionsCard(),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: const [
                      _RecentSupportTicketsCard(),
                      SizedBox(height: 24),
                      _GlobalDocumentStatusCard(),
                    ],
                  ),
                ),
              ],
            ),
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
            title: 'TOTAL DOCUMENTS',
            value: '5.2k',
            trend: '-5.2%',
            isPositive: false,
            isPrimary: true,
            onTap: () {
              context.read<DashboardCubit>().selectNav(NavItem.totalDocuments);
            },
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _StatCard(
            title: 'TOTAL TICKETS',
            value: '1.1k',
            trend: '-2.1%',
            isPositive: false,
            isPrimary: false,
            onTap: () {
              context.read<DashboardCubit>().selectNav(NavItem.totalTickets);
            },
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _StatCard(
            title: 'COMPLAIANCE SCORE',
            value: '97%',
            trend: 'High',
            isPositive: true,
            isPrimary: false,
            onTap: () {
              context.read<DashboardCubit>().selectNav(
                NavItem.complianceScoreDetails,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.isPrimary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppColors.primary : AppColors.error;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: isPrimary
                    ? AppColors.primary
                    : AppColors.transparent, // 👈 Hide when not selected
                width: 4, // Thickness of left border
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                value,
                                style: AppTypography.h1.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(width: 12),
                              Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      trendIcon,
                                      size: 18,
                                      color: trendColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      trend,
                                      style: AppTypography.bodyRegular.copyWith(
                                        color: trendColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportTicketsChartCard extends StatefulWidget {
  const _SupportTicketsChartCard();

  @override
  State<_SupportTicketsChartCard> createState() =>
      _SupportTicketsChartCardState();
}

class _SupportTicketsChartCardState extends State<_SupportTicketsChartCard> {
  @override
  Widget build(BuildContext context) {
    String _selectedFilter = 'Today';
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Support Tickets', style: AppTypography.h3),
                  SizedBox(height: 4),
                  Text(
                    'Breakdown of user-reported reasons',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.cFFEFEFEF),
                  ),
                  color: AppColors.white,
                  elevation: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedFilter,
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cFF1A1D1F,
                        ),
                      ),
                      SizedBox(width: 32),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.cFF6F767E,
                      ),
                    ],
                  ),
                  onSelected: (val) {
                    setState(() {
                      _selectedFilter = val;
                    });
                  },
                  itemBuilder: (context) => [
                    _buildPopupItem('Hourly', _selectedFilter == 'Hourly'),
                    _buildPopupItem('Today', _selectedFilter == 'Today'),
                    _buildPopupItem(
                      'Last Week',
                      _selectedFilter == 'Last Week',
                    ),
                    _buildPopupItem(
                      'Last 30 Months',
                      _selectedFilter == 'Last 30 Months',
                    ),
                    _buildPopupItem(
                      'Last 6 Months',
                      _selectedFilter == 'Last 6 Months',
                    ),
                    _buildPopupItem(
                      'Last 1 Year',
                      _selectedFilter == 'Last 1 Year',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          _buildProgressRow('Driver Behavior Issue', 50, true),
          SizedBox(height: 24),
          _buildProgressRow('Route Issue', 30, true),
          SizedBox(height: 24),
          _buildProgressRow('Incorrect Fare', 18, true),
          SizedBox(height: 24),
          _buildProgressRow('Technical Issue', 7, true),
          SizedBox(height: 24),
          _buildProgressRow('Other Reasons', 5, true),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? AppColors.cFFF4FDF8 : AppColors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.cFF00A86B,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(String title, int pct, bool showPctText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showPctText)
              Text(
                '$pct%',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
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
                  height: 8,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.cFFF3F4F6,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 8,
                  width: constraints.maxWidth * (pct / 100),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: pct > 20 ? 1 : 0.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _RecentDocumentSubmissionsCard extends StatelessWidget {
  const _RecentDocumentSubmissionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Document Submissions', style: AppTypography.h3),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.cFFE0F2F1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '12 PENDING',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDriverSubmission(
            name: 'Arun Kumar',
            id: 'D-4421',
            time: '12m ago',
            progress: 80,
            badges: [
              _Badg('ID', true),
              _Badg('LICENSE', true),
              _Badg('RC', true),
              _Badg('INSURANCE', true),
              _Badg('BANK', false),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 1),
          ),
          _buildDriverSubmission(
            name: 'Sam Yogi',
            id: 'D-4421',
            time: '45m ago',
            progress: 80,
            badges: [
              _Badg('ID', true),
              _Badg('LICENSE', true),
              _Badg('RC', true),
              _Badg('INSURANCE', true),
              _Badg('BANK', false),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.grey.shade200)),
            ),
            child: Center(
              child: Text(
                'VIEW ALL PENDING SUBMISSIONS',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverSubmission({
    required String name,
    required String id,
    required String time,
    required int progress,
    required List<_Badg> badges,
  }) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cFFF9FAFB,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.grey.shade300,
                  child: Icon(Icons.person, color: AppColors.grey.shade600),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.h4.copyWith(
                          fontWeight: FontWeight.bold,
                          // fontSize: 14,
                        ),
                      ),
                      Text(
                        'ID: # $id • Submitted $time',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    'VIEW FILE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                      // fontSize: 11,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    'APPROVE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      // fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '5 DOCUMENTS',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '$progress% COMPLETE',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 11,
                    letterSpacing: 0.5,
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
                        color: AppColors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Container(
                      height: 6,
                      width: constraints.maxWidth * (progress / 100),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              
              children: badges
                  .map((b) => _buildStatusChip(b.name, b.isDone))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isDone) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDone ? AppColors.cFFE8F5E9 : AppColors.cFFFFF8E1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDone ? AppColors.green.shade300 : AppColors.amber.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isDone ? AppColors.primary : AppColors.amber.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 9,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            isDone ? Icons.check : Icons.circle,
            size: 10,
            color: isDone ? AppColors.primary : AppColors.amber.shade800,
          ),
        ],
      ),
    );
  }
}

class _Badg {
  final String name;
  final bool isDone;
  _Badg(this.name, this.isDone);
}

class _RecentSupportTicketsCard extends StatelessWidget {
  const _RecentSupportTicketsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Support Tickets', style: AppTypography.h3),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFEBEE,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '3 NEW',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      // fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildTicketRow(
            id: '#TK-8821',
            title: 'Amit Shah - Payment Failed',
            time: '3 mins ago',
          ),
          Divider(height: 1),
          _buildTicketRow(
            id: '#TK-8819',
            title: 'Sonia G. - Route issue',
            time: '12 mins ago',
          ),
          Divider(height: 1),
          _buildTicketRow(
            id: '#TK-8819',
            title: 'Yogesh S - Driver behavior',
            time: '12 mins ago',
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.grey.shade200)),
            ),
            child: Center(
              child: Text(
                'VIEW ALL TICKETS',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketRow({
    required String id,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        // fontSize: 11,
                      ),
                    ),
                    Text(
                      'RESOLVE >',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        // fontSize: 11,
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

class _GlobalDocumentStatusCard extends StatelessWidget {
  const _GlobalDocumentStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Document Status', style: AppTypography.h3),
          SizedBox(height: 40),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 16,
                    color: AppColors.grey.shade100,
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: 0.9,
                    strokeWidth: 16,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: 0.15,
                    strokeWidth: 16,
                    color: AppColors.amber.shade600,
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: 0.1,
                    strokeWidth: 16,
                    color: AppColors.error,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '2.4k',
                      style: AppTypography.h1.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'TOTAL DOCS',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          _buildLegendRow(
            color: AppColors.primary,
            label: 'Verified',
            pct: '75%',
          ),
          SizedBox(height: 16),
          _buildLegendRow(
            color: AppColors.amber.shade600,
            label: 'Pending Review',
            pct: '15%',
          ),
          SizedBox(height: 16),
          _buildLegendRow(
            color: AppColors.error,
            label: 'Expired/Rejected',
            pct: '10%',
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow({
    required Color color,
    required String label,
    required String pct,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 12, color: color),
            SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          pct,
          style: AppTypography.bodyRegular.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
