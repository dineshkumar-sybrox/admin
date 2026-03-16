import 'package:flutter/material.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../features/dashboard/presentation/widgets/stat_cards_row.dart';
import '../widgets/rider_payments_table.dart';

class DriverPayoutDetailsScreen extends StatelessWidget {
  final String driverName;

  DriverPayoutDetailsScreen({super.key, required this.driverName});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Payment Management - rider payments',
      body: SingleChildScrollView(
        child: Column(
          children: [
            StatCardsRow(), // Re-use our stat cards from dashboard
            SizedBox(height: 24),
            RiderPaymentsTable(),
          ],
        ),
      ),
    );
  }
}

