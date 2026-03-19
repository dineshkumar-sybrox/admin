import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/revenue/revenue_stat_cards.dart';
import '../widgets/revenue/revenue_trend_chart.dart';
import '../widgets/revenue/top_earning_drivers.dart';
import '../widgets/revenue/revenue_by_region.dart';
import '../widgets/revenue/service_type_breakdown.dart';

class RevenueTodayScreen extends StatelessWidget {
  RevenueTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RevenueStatCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth < 1100;
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: BlocBuilder<RevenueStatCubit, RevenueStatState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RevenueStatCards(),
                    SizedBox(height: 20),
                    if (state.showOnlyTable) ...[
                      RevenueTransactionsTable(),
                    ] else if (isTablet)
                      Column(
                        children: [
                          RevenueTrendChart(),
                          SizedBox(height: 16),
                          TopEarningDrivers(),
                          SizedBox(height: 16),
                          RevenueTransactionsTable(),
                          SizedBox(height: 16),
                          RevenueByRegion(),
                          SizedBox(height: 16),
                          ServiceTypeBreakdown(),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 14,
                            child: Column(
                              children: [
                                RevenueTrendChart(),
                                SizedBox(height: 20),
                                RevenueTransactionsTable(),
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
