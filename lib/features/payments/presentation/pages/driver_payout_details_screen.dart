import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../features/dashboard/presentation/widgets/stat_cards_row.dart';
import '../widgets/rider_payments_table.dart';

class DriverPayoutDetailsScreen extends StatelessWidget {
  final String driverName;

  const DriverPayoutDetailsScreen({super.key, required this.driverName});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Payment Management - rider payments',
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StatCardsRow(), // Re-use our stat cards from dashboard
            const SizedBox(height: 24),
            const RiderPaymentsTable(),
          ],
        ),
      ),
    );
  }
}
