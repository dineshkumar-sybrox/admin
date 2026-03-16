import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/stats_card.dart';
import '../widgets/activity_chart.dart';
import '../widgets/trust_safety_panel.dart';
import '../widgets/ride_outcome_distribution.dart';
import '../widgets/last_ride_summary.dart';
import '../widgets/monthly_spending_trend_chart.dart';
import '../widgets/spend_by_category_chart.dart';
import '../widgets/transactions_list.dart';
import '../widgets/total_cancellation_rate_card.dart';
import '../widgets/cancellation_reasons_card.dart';
import '../widgets/cancellation_timeline_chart.dart';
import '../widgets/cancellation_log_table.dart';
import '../widgets/rating_for_rider_card.dart';
import '../widgets/common_feedback_tags_card.dart';
import '../widgets/critical_feedback_logs_card.dart';

class RiderOverviewTab extends StatefulWidget {
  RiderOverviewTab({super.key});

  @override
  State<RiderOverviewTab> createState() => _RiderOverviewTabState();
}

class _RiderOverviewTabState extends State<RiderOverviewTab> {
  int _selectedStatIndex = 1; // Default to Total Spend

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmallScreen = width < 900;

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 48,
          ), // Move padding here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Row
              if (isSmallScreen)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildStatsCard1()),
                        SizedBox(width: 16),
                        Expanded(child: _buildStatsCard2()),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildStatsCard3()),
                        SizedBox(width: 16),
                        Expanded(child: _buildStatsCard4()),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildStatsCard1()),
                    SizedBox(width: 16),
                    Expanded(child: _buildStatsCard2()),
                    SizedBox(width: 16),
                    Expanded(child: _buildStatsCard3()),
                    SizedBox(width: 16),
                    Expanded(child: _buildStatsCard4()),
                  ],
                ),

              SizedBox(height: 24),

              // Activity + Safety Row
              if (_selectedStatIndex == 1) ...[
                if (isSmallScreen)
                  Column(
                    children: [
                      MonthlySpendingTrendChart(),
                      SizedBox(height: 24),
                      SpendByCategoryChart(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: MonthlySpendingTrendChart(),
                      ),
                      SizedBox(width: 24),
                      Expanded(flex: 1, child: SpendByCategoryChart()),
                    ],
                  ),
                SizedBox(height: 24),
                TransactionsList(),
              ] else if (_selectedStatIndex == 2) ...[
                if (isSmallScreen)
                  Column(
                    children: [
                      TotalCancellationRateCard(),
                      SizedBox(height: 24),
                      CancellationReasonsCard(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TotalCancellationRateCard(),
                      ),
                      SizedBox(width: 24),
                      Expanded(flex: 2, child: CancellationReasonsCard()),
                    ],
                  ),
                SizedBox(height: 24),
                CancellationTimelineChart(),
                SizedBox(height: 24),
                CancellationLogTable(),
              ] else if (_selectedStatIndex == 3) ...[
                if (isSmallScreen)
                  Column(
                    children: [
                      RatingForRiderCard(),
                      SizedBox(height: 24),
                      CommonFeedbackTagsCard(),
                      SizedBox(height: 24),
                      CriticalFeedbackLogsCard(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            RatingForRiderCard(),
                            SizedBox(height: 24),
                            CommonFeedbackTagsCard(),
                          ],
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        flex: 4,
                        child: CriticalFeedbackLogsCard(),
                      ),
                    ],
                  ),
              ] else ...[
                if (isSmallScreen)
                  Column(
                    children: [
                      ActivityTrendChart(),
                      SizedBox(height: 24),
                      TrustSafetyPanel(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: ActivityTrendChart()),
                      SizedBox(width: 24),
                      Expanded(flex: 1, child: TrustSafetyPanel()),
                    ],
                  ),
                SizedBox(height: 24),
                // Outcome + Summary Row
                if (isSmallScreen)
                  Column(
                    children: [
                      RideOutcomeDistribution(),
                      SizedBox(height: 24),
                      LastRideSummary(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: RideOutcomeDistribution()),
                      SizedBox(width: 24),
                      Expanded(flex: 2, child: LastRideSummary()),
                    ],
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsCard1() => StatsCard(
    title: 'Total Rides',
    value: '142',
    trend: '+12%',
    isPositiveTrend: true,
    isSelected: _selectedStatIndex == 0,
    onTap: () => setState(() => _selectedStatIndex = 0),
  );

  Widget _buildStatsCard2() => StatsCard(
    title: 'Total Spend',
    value: '₹12,450',
    subtitle: 'Avg ₹87.6/ride',
    isSelected: _selectedStatIndex == 1,
    onTap: () => setState(() => _selectedStatIndex = 1),
  );

  Widget _buildStatsCard3() => StatsCard(
    title: 'Cancellation',
    value: '4.2%',
    trend: '6/142 rides',
    isPositiveTrend: false,
    isSelected: _selectedStatIndex == 2,
    activeColor: AppColors.error,
    onTap: () => setState(() => _selectedStatIndex = 2),
  );

  Widget _buildStatsCard4() => StatsCard(
    title: 'Avg Rating',
    value: '4.8',
    isSelected: _selectedStatIndex == 3,
    activeColor: AppColors.amber,
    onTap: () => setState(() => _selectedStatIndex = 3),
    extraContent: Row(
      children: const [
        Icon(Icons.star, size: 16, color: AppColors.amber),
        Icon(Icons.star, size: 16, color: AppColors.amber),
        Icon(Icons.star, size: 16, color: AppColors.amber),
        Icon(Icons.star, size: 16, color: AppColors.amber),
        Icon(Icons.star_half, size: 16, color: AppColors.amber),
      ],
    ),
  );
}


