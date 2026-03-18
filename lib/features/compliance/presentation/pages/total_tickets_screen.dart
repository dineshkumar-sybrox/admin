import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/total_tickets_cubit.dart';
import '../cubit/total_tickets_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/total_tickets/total_tickets_stat_cards.dart';
import '../widgets/total_tickets/total_tickets_controls.dart';
import '../widgets/total_tickets/total_tickets_table.dart';
import '../widgets/total_tickets/total_tickets_pagination.dart';

class TotalTicketsScreen extends StatelessWidget {
  TotalTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TotalTicketsCubit(),
      child: BlocBuilder<TotalTicketsCubit, TotalTicketsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TotalTicketsStatCards(statusFilter: state.statusFilter),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TotalTicketsControls(state: state),
                      Divider(height: 1, color: AppColors.divider),
                      TotalTicketsTable(
                        tickets: state.filteredTickets,
                        statusFilter: state.statusFilter,
                      ),
                      Divider(height: 1, color: AppColors.divider),
                      TotalTicketsPagination(
                        totalFiltered: state.filteredTickets.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
