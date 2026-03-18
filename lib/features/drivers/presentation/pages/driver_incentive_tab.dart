import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class DriverIncentiveTab extends StatelessWidget {
  const DriverIncentiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _IncentiveSummaryRow(),
          const SizedBox(height: 24),
          _IncentiveHistoryCard(),
        ],
      ),
    );
  }
}

class _IncentiveSummaryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _IncentiveStatCard(
            title: 'TOTAL INCENTIVES EARNED',
            value: '₹15,400.00',
            subtitle: '+12% from last month',
            icon: Icons.credit_card,
            iconBg: AppColors.success.withAlpha(20),
            iconColor: AppColors.success,
            subtitleColor: AppColors.success,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _IncentiveStatCard(
            title: 'COMPLETED QUESTS',
            value: '24',
            subtitle: 'Lifetime quest achievement',
            icon: Icons.check_circle_outline,
            iconBg: AppColors.blue.withAlpha(20),
            iconColor: AppColors.blue,
            subtitleColor: AppColors.textSecondary,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _IncentiveStatCard(
            title: 'ONGOING TARGETS',
            value: '1',
            subtitle: 'Active campaigns currently tracked',
            icon: Icons.bolt_outlined,
            iconBg: AppColors.cFFF59E0B.withAlpha(20),
            iconColor: AppColors.cFFF59E0B,
            subtitleColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _IncentiveStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color subtitleColor;

  const _IncentiveStatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cFFE5E7EB),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 25),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            value,
            style: AppTypography.h2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTypography.base.copyWith(
              fontSize: 13,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _IncentiveHistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cFFE5E7EB),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      "Amit's Incentive History",
                      style: AppTypography.h3.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    Container(
                      width: 240,
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cFFF1F5F9,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.cFFE5E7EB),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Search quests...',
                            style: AppTypography.base.copyWith(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.file_download_outlined, size: 16),
                      label: Text(
                        'EXPORT',
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.cFFE5E7EB),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: _IncentiveHistoryTable(),
                ),
              ),
              const Divider(height: 1, color: AppColors.cFFE5E7EB),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHOWING 1-4 OF 24 QUESTS',
                      style: AppTypography.base.copyWith(
                        fontSize: 11,
                        letterSpacing: 0.6,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        _PageChip(label: '<'),
                        const SizedBox(width: 8),
                        _PageChip(label: '1', isActive: true),
                        const SizedBox(width: 8),
                        _PageChip(label: '2'),
                        const SizedBox(width: 8),
                        _PageChip(label: '3'),
                        const SizedBox(width: 8),
                        _PageChip(label: '>'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IncentiveHistoryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width > 1200
                  ? MediaQuery.of(context).size.width - 320
                  : 1000,
            ),

            child: DataTable(
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
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: AppColors.cFFF3F4F6,
                  width: 1,
                ),
              ),
              columns: const [
                DataColumn(label: Text('QUEST NAME')),
                DataColumn(label: Text('TYPE')),
                DataColumn(label: Text('TARGET')),
                DataColumn(label: Text('PROGRESS')),
                DataColumn(label: Text('EARNED AMOUNT')),
                DataColumn(label: Text('PAYOUT STATUS')),
              ],
              rows: [
                _incentiveRow(
                  title: 'Weekend Rider',
                  subtitle: 'Ends in 2 days',
                  type: 'WEEKLY',
                  target: '50 Rides',
                  progressText: '52/50',
                  progress: 1,
                  amount: '₹2,500.00',
                  status: 'PAID',
                  statusBg: AppColors.success.withAlpha(20),
                  statusText: AppColors.success,
                ),

                _incentiveRow(
                  title: 'Weekend Rider',
                  subtitle: 'Ends in 2 days',
                  type: 'WEEKLY',
                  target: '50 Rides',
                  progressText: '52/50',
                  progress: 1,
                  amount: '₹2,500.00',
                  status: 'PAID',
                  statusBg: AppColors.success.withAlpha(20),
                  statusText: AppColors.success,
                ),
                _incentiveRow(
                  title: 'Bonus Rider',
                  subtitle: 'Special Campaign',
                  type: 'BONUS',
                  target: '100 Rides',
                  progressText: '75/100',
                  progress: 0.75,
                  amount: '₹2,000.00',
                  status: 'TIER 2',
                  statusBg: AppColors.primary.withAlpha(20),
                  statusText: AppColors.primary,
                ),
                _incentiveRow(
                  title: 'Morning Rush Daily',
                  subtitle: 'Completed 04 Nov',
                  type: 'DAILY',
                  target: '8 Rides',
                  progressText: '10/8',
                  progress: 1,
                  amount: '₹450.00',
                  status: 'PAID',
                  statusBg: AppColors.success.withAlpha(20),
                  statusText: AppColors.success,
                ),
                _incentiveRow(
                  title: 'Monthly Service Star',
                  subtitle: 'Rating > 4.8',
                  type: 'BONUS',
                  target: '30 Days',
                  progressText: '30/30',
                  progress: 1,
                  amount: '₹5,000.00',
                  status: 'PROCESSING',
                  statusBg: AppColors.cFFD97706.withAlpha(20),
                  statusText: AppColors.cFFD97706,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

DataRow _incentiveRow({
  required String title,
  required String subtitle,
  required String type,
  required String target,
  required String progressText,
  required double progress,
  required String amount,
  required String status,
  required Color statusBg,
  required Color statusText,
}) {
  return DataRow(
    cells: [
      DataCell(_QuestCell(title: title, subtitle: subtitle)),
      DataCell(_TypeBadge(label: type)),
      DataCell(Text(target)),
      DataCell(_ProgressCell(value: progress, label: progressText)),
      DataCell(
        Text(
          amount,
          style: AppTypography.base.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      DataCell(_StatusBadge(label: status, fg: statusText, bg: statusBg)),
    ],
  );
}

class _QuestCell extends StatelessWidget {
  final String title;
  final String subtitle;

  const _QuestCell({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTypography.base.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTypography.base.copyWith(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;

  const _TypeBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    switch (label) {
      case 'BONUS':
        bgColor = AppColors.cFFE0F2F2.withAlpha(20);
        textColor = AppColors.cFFE0F2F2;
        break;
      case 'DAILY':
        bgColor = AppColors.cFFD97706.withAlpha(20);
        textColor = AppColors.cFFD97706;
        break;
      case 'WEEKLY':
      default:
        bgColor = AppColors.cFF2563EB.withAlpha(20);
        textColor = AppColors.cFF2563EB;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTypography.base.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

class _ProgressCell extends StatelessWidget {
  final double value;
  final String label;

  const _ProgressCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: value.clamp(0, 1),
                  minHeight: 6,
                  backgroundColor: AppColors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.success,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, size: 14, color: AppColors.success),
          ],
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;

  const _StatusBadge({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTypography.base.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

class _PageChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _PageChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final bg = isActive ? AppColors.success : AppColors.white;
    final border = isActive ? AppColors.success : AppColors.cFFE5E7EB;
    final fg = isActive ? AppColors.white : AppColors.textSecondary;

    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: AppTypography.base.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
