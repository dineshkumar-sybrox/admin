import 'package:flutter/material.dart';
import '../widgets/payment_stat_cards.dart';
import '../widgets/payment_analytics_chart.dart';
import '../widgets/payment_method_chart.dart';
import '../widgets/driver_payout_list.dart';
import 'cab_payment_screen.dart';
import 'bike_payment_screen.dart';
import 'auto_payment_screen.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

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
              PaymentStatCards(
                selectedIndex: 0,
                onCardTapped: (index) {
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CabPaymentScreen(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BikePaymentScreen(),
                      ),
                    );
                  } else if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AutoPaymentScreen(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              if (isTablet)
                const Column(
                  children: [
                    PaymentAnalyticsChart(),
                    SizedBox(height: 16),
                    PaymentMethodChart(),
                    SizedBox(height: 16),
                    DriverPayoutList(),
                  ],
                )
              else
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 14, child: PaymentAnalyticsChart()),
                        SizedBox(width: 20),
                        Expanded(flex: 9, child: PaymentMethodChart()),
                      ],
                    ),
                    SizedBox(height: 20),
                    DriverPayoutList(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
