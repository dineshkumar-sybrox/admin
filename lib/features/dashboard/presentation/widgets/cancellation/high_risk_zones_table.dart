import 'package:admin/core/theme/app_colors.dart';
import 'package:admin/features/dashboard/presentation/pages/cancellation_zone_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';

class HighRiskZonesTable extends StatelessWidget {
  HighRiskZonesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High-Risk Cancellation Zones',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cFF1A1D1F,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Areas with highest frequency of canceled rides',
                      style: AppTypography.base.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.cFF9EA5AD,
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: AppColors.cFFEFEFEF),
                  ),
                  child: Text(
                    'Export Report',
                    style: AppTypography.base.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF1A1D1F,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Divider(height: 1, color: AppColors.cFFF0F1F3),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth, // 👈 important
                  ),
                  child: DataTable(
                    columnSpacing: 40,
                    horizontalMargin: 16,

                    headingRowHeight: 60,

                    dataRowMinHeight: 60,
                    dataRowMaxHeight: 60,
                    headingRowColor: MaterialStateProperty.all(
                      AppColors.cFFF8F8F8,
                    ),
                    headingTextStyle: AppTypography.base.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                    columns: const [
                      DataColumn(label: Text('AREA NAME')),
                      DataColumn(label: Text('REQUESTS')),
                      DataColumn(label: Text('CANCELLATIONS')),
                      DataColumn(label: Text('RATE')),
                      DataColumn(label: Text('STATUS')),
                      DataColumn(label: Text('ACTION')),
                    ],
                    rows: [
                      _buildRow(
                        areaName: 'Anna Nagar, Chennai',
                        areaDesc: 'Primary Transit Hub',
                        requests: '12,400',
                        cancellations: '1,116',
                        rate: '9.0%',
                        rateBgColor: AppColors.cFFFFECEE,
                        rateTextColor: AppColors.cFFEA3546,
                        status: 'Critical High',
                        statusColor: AppColors.cFFEA3546,
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CancellationZoneDetailsScreen(
                                    zoneName: 'Anna Nagar',
                                  ),
                            ),
                          );
                        },
                      ),
                      _buildRow(
                        areaName: 'Adyar, Chennai',
                        areaDesc: 'Residential Area',
                        requests: '8,200',
                        cancellations: '508',
                        rate: '6.2%',
                        rateBgColor: AppColors.cFFFFF7DB,
                        rateTextColor: AppColors.cFFD4A000,
                        status: 'Elevated',
                        statusColor: AppColors.cFFD4A000,
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CancellationZoneDetailsScreen(
                                    zoneName: 'Adyar',
                                  ),
                            ),
                          );
                        },
                      ),
                      _buildRow(
                        areaName: 'Velachery, Chennai',
                        areaDesc: 'IT Park Corridor',
                        requests: '15,600',
                        cancellations: '702',
                        rate: '4.5%',
                        rateBgColor: AppColors.cFFE8FDF2,
                        rateTextColor: AppColors.cFF00C46B,
                        status: 'Normal',
                        statusColor: AppColors.cFF00C46B,
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CancellationZoneDetailsScreen(
                                    zoneName: 'Velachery',
                                  ),
                            ),
                          );
                        },
                      ),
                      _buildRow(
                        areaName: 'T-Nagar, Chennai',
                        areaDesc: 'Commercial Zone',
                        requests: '10,100',
                        cancellations: '858',
                        rate: '8.5%',
                        rateBgColor: AppColors.cFFFFECEE,
                        rateTextColor: AppColors.cFFEA3546,
                        status: 'High Risk',
                        statusColor: AppColors.cFFEA3546,
                        onViewDetails: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CancellationZoneDetailsScreen(
                                    zoneName: 'T-Nagar',
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: DataTable(
          //     headingRowColor: WidgetStateProperty.all(
          //       AppColors.cFFF4F6F9.withValues(alpha: 0.5),
          //     ),
          //     dataRowMaxHeight: 80,
          //     dataRowMinHeight: 80,
          //     horizontalMargin: 24,
          //     columnSpacing: 40,
          //     dividerThickness: 1,
          //     headingTextStyle: AppTypography.base.copyWith(
          //       fontSize: 11,
          //       fontWeight: FontWeight.w700,
          //       color: AppColors.cFF6F767E,
          //       letterSpacing: 0.5,
          //     ),
          //     columns: const [
          // DataColumn(label: Text('AREA NAME')),
          // DataColumn(label: Text('REQUESTS')),
          // DataColumn(label: Text('CANCELLATIONS')),
          // DataColumn(label: Text('RATE')),
          // DataColumn(label: Text('STATUS')),
          // DataColumn(label: Text('ACTION')),
          //     ],
          // rows: [
          //   _buildRow(
          //     areaName: 'Anna Nagar, Chennai',
          //     areaDesc: 'Primary Transit Hub',
          //     requests: '12,400',
          //     cancellations: '1,116',
          //     rate: '9.0%',
          //     rateBgColor: AppColors.cFFFFECEE,
          //     rateTextColor: AppColors.cFFEA3546,
          //     status: 'Critical High',
          //     statusColor: AppColors.cFFEA3546,
          //     onViewDetails: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>
          //               CancellationZoneDetailsScreen(
          //                 zoneName: 'Anna Nagar',
          //               ),
          //         ),
          //       );
          //     },
          //   ),
          //   _buildRow(
          //     areaName: 'Adyar, Chennai',
          //     areaDesc: 'Residential Area',
          //     requests: '8,200',
          //     cancellations: '508',
          //     rate: '6.2%',
          //     rateBgColor: AppColors.cFFFFF7DB,
          //     rateTextColor: AppColors.cFFD4A000,
          //     status: 'Elevated',
          //     statusColor: AppColors.cFFD4A000,
          //     onViewDetails: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>
          //               CancellationZoneDetailsScreen(
          //                 zoneName: 'Adyar',
          //               ),
          //         ),
          //       );
          //     },
          //   ),
          //   _buildRow(
          //     areaName: 'Velachery, Chennai',
          //     areaDesc: 'IT Park Corridor',
          //     requests: '15,600',
          //     cancellations: '702',
          //     rate: '4.5%',
          //     rateBgColor: AppColors.cFFE8FDF2,
          //     rateTextColor: AppColors.cFF00C46B,
          //     status: 'Normal',
          //     statusColor: AppColors.cFF00C46B,
          //     onViewDetails: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>
          //               CancellationZoneDetailsScreen(
          //                 zoneName: 'Velachery',
          //               ),
          //         ),
          //       );
          //     },
          //   ),
          //   _buildRow(
          //     areaName: 'T-Nagar, Chennai',
          //     areaDesc: 'Commercial Zone',
          //     requests: '10,100',
          //     cancellations: '858',
          //     rate: '8.5%',
          //     rateBgColor: AppColors.cFFFFECEE,
          //     rateTextColor: AppColors.cFFEA3546,
          //     status: 'High Risk',
          //     statusColor: AppColors.cFFEA3546,
          //     onViewDetails: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>
          //               CancellationZoneDetailsScreen(
          //                 zoneName: 'T-Nagar',
          //               ),
          //         ),
          //       );
          //     },
          //   ),
          // ],
          //   ),
          // ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing 4 of 28 zones',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cFF6F767E,
                  ),
                ),
                Row(
                  children: [
                    _buildPaginator('<', isActive: false),
                    SizedBox(width: 8),
                    _buildPaginator('1', isActive: true),
                    SizedBox(width: 8),
                    _buildPaginator('2', isActive: false),
                    SizedBox(width: 8),
                    _buildPaginator('3', isActive: false),
                    SizedBox(width: 8),
                    _buildPaginator('>', isActive: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginator(String text, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.cFF00A86B : AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: isActive ? null : Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.base.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isActive ? AppColors.white : AppColors.cFF1A1D1F,
          ),
        ),
      ),
    );
  }

  DataRow _buildRow({
    required String areaName,
    required String areaDesc,
    required String requests,
    required String cancellations,
    required String rate,
    required Color rateBgColor,
    required Color rateTextColor,
    required String status,
    required Color statusColor,
    required VoidCallback onViewDetails,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                areaName,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 4),
              Text(
                areaDesc,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: AppColors.cFF6F767E,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            requests,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            cancellations,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: rateBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              rate,
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: rateTextColor,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: statusColor,
                ),
              ),
              SizedBox(width: 8),
              Text(
                status,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          TextButton(
            onPressed: onViewDetails,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'View Details',
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.cFF00C46B, // Brighter green for actions
              ),
            ),
          ),
        ),
      ],
    );
  }
}





