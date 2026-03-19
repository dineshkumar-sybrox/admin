import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';
import '../../../drivers/presentation/cubit/drivers_management_state.dart';
import '../../../../core/utils/excel_export_helper.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  Future<void> loadDashboard() async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(Duration(milliseconds: 800));

    emit(
      state.copyWith(
        isLoading: false,
        pendingApprovals: 12,
        newTickets: 4,
        statCards:  [
          StatCard(
            title: 'TOTAL DRIVERS',
            value: '24k',
            trend: '+5.2%',
            isPositive: true,
          ),
          StatCard(
            title: 'TOTAL RIDES',
            value: '8.2k',
            trend: '-2.1%',
            isPositive: false,
          ),
          StatCard(
            title: 'TOTAL REVENUE',
            value: '₹1.2M',
            trend: '+12%',
            isPositive: true,
          ),
          StatCard(
            title: 'TOTAL CANCELLATION',
            value: '4.2%',
            trend: '-0.5%',
            isPositive: true,
          ),
        ],
        driverApprovals:  [
          DriverApproval(
            name: 'Arun Kumar',
            driverId: '#D-4421',
            documentCount: 5,
            progress: 80,
            approvedDocs: ['ID', 'LICENSE', 'RC', 'INSURANCE'],
            pendingDocs: ['Bank'],
          ),
          DriverApproval(
            name: 'Sam Yogi',
            driverId: '#D-4421',
            documentCount: 5,
            progress: 80,
            approvedDocs: ['ID', 'LICENSE', 'RC', 'INSURANCE'],
            pendingDocs: ['Bank'],
          ),
        ],
        supportTickets:  [
          SupportTicket(
            ticketId: '#TK-8821',
            userName: 'Amit Shah',
            issue: 'Payment Failed',
            timeAgo: '3 mins ago',
            priority: 'URGENT',
          ),
          SupportTicket(
            ticketId: '#TK-8819',
            userName: 'Sonia G.',
            issue: 'GPS Drift',
            timeAgo: '12 mins ago',
            priority: 'MEDIUM',
          ),
        ],
        recentTransactions:  [
          Transaction(
            id: '#RX-82710',
            amount: '85.00',
            serviceType: 'AUTO',
            paymentMethod: 'Cash',
            status: 'Completed',
            isCompleted: true,
          ),
          Transaction(
            id: '#RX-82709',
            amount: '245.50',
            serviceType: 'AUTO',
            paymentMethod: 'UPI',
            status: 'Completed',
            isCompleted: true,
          ),
          Transaction(
            id: '#RX-82708',
            amount: '1420.00',
            serviceType: 'CAB',
            paymentMethod: 'UPI',
            status: 'Failed',
            isCompleted: false,
          ),
          Transaction(
            id: '#RX-82707',
            amount: '92.00',
            serviceType: 'BIKE/SCOOTER',
            paymentMethod: 'UPI',
            status: 'Completed',
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  Future<void> selectNav(NavItem item) async {
    emit(
      state.copyWith(
        isLoading: true,
        selectedNav: item,
        initialDriverTab: null,
      ),
    );

    // Small delay to show the loader
    await Future.delayed(Duration(milliseconds: 600));

    emit(state.copyWith(isLoading: false));
  }

  Future<void> selectDriversTab(DriverTab tab) async {
    emit(
      state.copyWith(
        isLoading: true,
        selectedNav: NavItem.drivers,
        initialDriverTab: tab,
      ),
    );

    // Small delay to show the loader
    await Future.delayed(Duration(milliseconds: 600));

    emit(state.copyWith(isLoading: false));
  }

  void approveDriver(String driverId) {
    final updatedApprovals = state.driverApprovals
        .where((d) => d.driverId != driverId)
        .toList();
    emit(
      state.copyWith(
        driverApprovals: updatedApprovals,
        pendingApprovals: state.pendingApprovals - 1,
      ),
    );
  }

  void resolveTicket(String ticketId) {
    final updatedTickets = state.supportTickets
        .where((t) => t.ticketId != ticketId)
        .toList();
    emit(
      state.copyWith(
        supportTickets: updatedTickets,
        newTickets: (state.newTickets - 1).clamp(0, 99),
      ),
    );
  }

  Future<void> exportTodayReport() async {
    if (state.isExportingReport) return;
    emit(state.copyWith(isExportingReport: true));

    try {
      final headers = [
        'RIDE ID',
        'AMOUNT (₹)',
        'SERVICE TYPE',
        'PAYMENT METHOD',
        'STATUS',
      ];
      final rows = state.recentTransactions
          .map(
            (t) => [t.id, t.amount, t.serviceType, t.paymentMethod, t.status],
          )
          .toList();

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await ExcelExportHelper.exportToExcel(
        headers: headers,
        rows: rows,
        fileName: 'Todays_Report_$timestamp',
      );
    } catch (e) {
      debugPrint('Error exporting report: $e');
    } finally {
      emit(state.copyWith(isExportingReport: false));
    }
  }
}

