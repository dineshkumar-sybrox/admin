import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:admin/features/dashboard/presentation/cubit/dashboard_state.dart';

class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StatCardsSection(),
            const SizedBox(height: 32),
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
                const SizedBox(width: 24),
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
        const SizedBox(width: 24),
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
        const SizedBox(width: 24),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
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
                      padding: const EdgeInsets.all(24),
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
                          const SizedBox(height: 16),
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
                              const SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      trendIcon,
                                      size: 16,
                                      color: trendColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      trend,
                                      style: AppTypography.bodySmall.copyWith(
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

class _SupportTicketsChartCard extends StatelessWidget {
  const _SupportTicketsChartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
                  const SizedBox(height: 4),
                  Text(
                    'Breakdown of user-reported reasons',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      'Today',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 32),
                    const Icon(Icons.expand_more, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildProgressRow('Driver Behavior Issue', 50, false),
          const SizedBox(height: 24),
          _buildProgressRow('Route Issue', 30, false),
          const SizedBox(height: 24),
          _buildProgressRow('Incorrect Fare', 18, true),
          const SizedBox(height: 24),
          _buildProgressRow('Technical Issue', 7, true),
          const SizedBox(height: 24),
          _buildProgressRow('Other Reasons', 5, true),
        ],
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
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Document Submissions', style: AppTypography.h3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
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
          const Padding(
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'VIEW FILE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'APPROVE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 6,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
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
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDone ? const Color(0xFFE8F5E9) : const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDone ? Colors.green.shade200 : Colors.amber.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isDone ? AppColors.primary : Colors.amber.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 9,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            isDone ? Icons.check : Icons.circle,
            size: 10,
            color: isDone ? AppColors.primary : Colors.amber.shade800,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Support Tickets', style: AppTypography.h3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '3 NEW',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
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
          const Divider(height: 1),
          _buildTicketRow(
            id: '#TK-8819',
            title: 'Sonia G. - Route issue',
            time: '12 mins ago',
          ),
          const Divider(height: 1),
          _buildTicketRow(
            id: '#TK-8819',
            title: 'Yogesh S - Driver behavior',
            time: '12 mins ago',
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
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
      padding: const EdgeInsets.all(24.0),
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
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'RESOLVE >',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 11,
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Document Status', style: AppTypography.h3),
          const SizedBox(height: 40),
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
                    color: Colors.grey.shade100,
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
                    color: Colors.amber.shade600,
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
          const SizedBox(height: 48),
          _buildLegendRow(
            color: AppColors.primary,
            label: 'Verified',
            pct: '75%',
          ),
          const SizedBox(height: 16),
          _buildLegendRow(
            color: Colors.amber.shade600,
            label: 'Pending Review',
            pct: '15%',
          ),
          const SizedBox(height: 16),
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
            Icon(Icons.circle, size: 8, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          pct,
          style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
