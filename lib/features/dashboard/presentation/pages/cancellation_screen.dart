import 'package:flutter/material.dart';
import '../widgets/cancellation/cancellation_stat_cards.dart';
import '../widgets/cancellation/reasons_for_cancellation.dart';
import '../widgets/cancellation/cancellation_zones_chart.dart';
import '../widgets/cancellation/high_risk_zones_table.dart';
import 'rider_cancellation_screen.dart';
import 'driver_cancellation_screen.dart';

class CancellationScreen extends StatelessWidget {
  const CancellationScreen({super.key});

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
              CancellationStatCards(
                selectedIndex: 0,
                onCardTapped: (index) {
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiderCancellationScreen(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DriverCancellationScreen(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              if (isTablet)
                const Column(
                  children: [
                    ReasonsForCancellation(),
                    SizedBox(height: 16),
                    CancellationZonesChart(),
                    SizedBox(height: 16),
                    HighRiskZonesTable(),
                  ],
                )
              else
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 14, child: ReasonsForCancellation()),
                        SizedBox(width: 20),
                        Expanded(flex: 9, child: CancellationZonesChart()),
                      ],
                    ),
                    SizedBox(height: 20),
                    HighRiskZonesTable(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
