import 'package:flutter/material.dart';
import '../widgets/stat_cards_row.dart';
import '../widgets/revenue/revenue_trend_chart.dart';
import '../widgets/revenue/recent_transactions_table.dart';
import '../widgets/revenue/top_earning_drivers.dart';
import '../widgets/revenue/revenue_by_region.dart';
import '../widgets/revenue/service_type_breakdown.dart';

class RevenueTodayScreen extends StatelessWidget {
  const RevenueTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth < 1100;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatCardsRow(),
              const SizedBox(height: 20),
              if (isTablet)
                const Column(
                  children: [
                    RevenueTrendChart(),
                    SizedBox(height: 16),
                    TopEarningDrivers(),
                    SizedBox(height: 16),
                    RecentTransactionsTable(),
                    SizedBox(height: 16),
                    RevenueByRegion(),
                    SizedBox(height: 16),
                    ServiceTypeBreakdown(),
                  ],
                )
              else
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 14,
                      child: Column(
                        children: [
                          RevenueTrendChart(),
                          SizedBox(height: 20),
                          RecentTransactionsTable(),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 9,
                      child: Column(
                        children: [
                          TopEarningDrivers(),
                          SizedBox(height: 20),
                          RevenueByRegion(),
                          SizedBox(height: 20),
                          ServiceTypeBreakdown(),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
