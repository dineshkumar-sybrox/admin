import 'package:flutter/material.dart';
import '../../../dashboard/presentation/widgets/stat_cards_row.dart';
import '../widgets/completion_vs_cancellation_chart.dart';
import '../widgets/supply_vs_demand_indicator.dart';
import '../widgets/peak_hour_heatmap.dart';
import '../widgets/regional_performance_table.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
                    CompletionVsCancellationChart(),
                    SizedBox(height: 16),
                    SupplyVsDemandIndicator(),
                    SizedBox(height: 16),
                    PeakHourHeatmap(),
                    SizedBox(height: 16),
                    RegionalPerformanceTable(),
                  ],
                )
              else
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 14,
                          child: CompletionVsCancellationChart(),
                        ),
                        SizedBox(width: 20),
                        Expanded(flex: 9, child: SupplyVsDemandIndicator()),
                      ],
                    ),
                    SizedBox(height: 20),
                    PeakHourHeatmap(),
                    SizedBox(height: 20),
                    RegionalPerformanceTable(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
