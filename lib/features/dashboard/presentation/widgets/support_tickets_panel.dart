import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class SupportTicketsPanel extends StatelessWidget {
  SupportTicketsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderBlack, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text('Support Tickets', style: AppTypography.h3),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightpink.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${state.newTickets} NEW',
                        style: AppTypography.bodyRegular.copyWith(
                          color: AppColors.lightpink,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.borderBlack, thickness: 1),
        // Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.white,
        //     borderRadius: BorderRadius.circular(12),
        //     boxShadow: [
        //       BoxShadow(
        //         color: AppColors.black.withValues(alpha: 0.04),
        //         blurRadius: 8,
        //         offset: Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.fromLTRB(20, 16, 16, 16),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Support Tickets',
        //               style: AppTypography.base.copyWith(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w600,
        //                 color: AppColors.cFF1A2332,
        //               ),
        //             ),
        //             Spacer(),
        //             if (state.newTickets > 0)
        //               Container(
        //                 padding: EdgeInsets.symmetric(
        //                   horizontal: 8,
        //                   vertical: 3,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   color: AppColors.cFFFF4757.withValues(alpha: 0.1),
        //                   borderRadius: BorderRadius.circular(4),
        //                 ),
        //                 child: Text(
        //                   '${state.newTickets} NEW',
        //                   style: AppTypography.base.copyWith(
        //                     color: AppColors.cFFFF4757,
        //                     fontSize: 10,
        //                     fontWeight: FontWeight.w600,
        //                   ),
        //                 ),
        //               ),
        //           ],
        //         ),
        //       ),
              if (state.supportTickets.isEmpty)
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'No open tickets',
                      style: AppTypography.base.copyWith(color: AppColors.cFF8E9BAB),
                    ),
                  ),
                )
              else
                ...state.supportTickets.map(
                  (ticket) => _TicketCard(ticket: ticket),
                ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _TicketCard extends StatelessWidget {
  final SupportTicket ticket;
  const _TicketCard({required this.ticket});

  Color get priorityColor {
    switch (ticket.priority) {
      case 'URGENT':
        return AppColors.red;
      case 'HIGH':
        return AppColors.btnOrange;
      default:
        return AppColors.cFF4A90D9;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cFFEEF0F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ticket.ticketId,
                style: AppTypography.base.copyWith(
                  fontSize: 12,
                  color: AppColors.cFF8E9BAB,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ticket.priority,
                  style: AppTypography.base.copyWith(
                    color: priorityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            '${ticket.userName} - ${ticket.issue}',
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.cFF1A2332,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                ticket.timeAgo,
                style: AppTypography.base.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.cFF8E9BAB,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  context.read<DashboardCubit>().resolveTicket(ticket.ticketId);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      'RESOLVE',
                      style: AppTypography.base.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cFF00A86B,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: AppColors.cFF00A86B,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




