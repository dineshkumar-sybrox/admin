import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../widgets/cancellation/cancellation_stat_cards.dart';
import '../widgets/cancellation/high_risk_clusters_map.dart';
import '../widgets/cancellation/specific_cancellation_reasons.dart';
import '../widgets/cancellation/recent_cancelled_rides.dart';

class CancellationZoneDetailsScreen extends StatelessWidget {
  final String zoneName;

  const CancellationZoneDetailsScreen({super.key, required this.zoneName});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Cancellation - $zoneName',
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth < 1100;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CancellationStatCards(
                  totalValue: '24k',
                  totalTrend: '+5.2%',
                  riderValue: '8.2k',
                  riderTrend: '-2.1%',
                  driverValue: '₹1.2M',
                  driverTrend: '+12%',
                  driverTrendUp: true,
                ),
                const SizedBox(height: 20),
                const HighRiskClustersMap(),
                const SizedBox(height: 20),
                if (isTablet)
                  const Column(
                    children: [
                      SpecificCancellationReasons(),
                      SizedBox(height: 16),
                      RecentCancelledRides(),
                    ],
                  )
                else
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: SpecificCancellationReasons()),
                      SizedBox(width: 20),
                      Expanded(flex: 1, child: RecentCancelledRides()),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
