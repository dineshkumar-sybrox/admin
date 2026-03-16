import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class RegionalPerformanceTable extends StatelessWidget {
  RegionalPerformanceTable({super.key});

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
                      'Regional Performance',
                      style: AppTypography.h3
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Top performing cities by efficiency',
                      style: AppTypography.base.copyWith(
                        
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.download_rounded,
                    size: 16,
                    color: AppColors.cFF1A1D1F,
                  ),
                  label: Text(
                    'Export Report',
                    style: AppTypography.base.copyWith(
                      fontWeight: FontWeight.w800
                    ),
                  ),
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
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
             headingRowColor: WidgetStateProperty.all(AppColors.cFFF8FAFC),
              headingTextStyle: AppTypography.base.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              dataTextStyle: AppTypography.base.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              horizontalMargin: 24,
              columnSpacing: 24,
              headingRowHeight: 56,
              dataRowMaxHeight: 72,
              dataRowMinHeight: 72,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: AppColors.cFFF3F4F6,
                  width: 1,
                ),
              ),
              columns: const [
                DataColumn(label: Text('CITY / ZONE')),
                DataColumn(label: Text('DAILY REQUESTS')),
                DataColumn(label: Text('AVG. WAIT TIME')),
                DataColumn(label: Text('COMPLETION')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: [
                _buildRow(
                  city: 'Mumbai South',
                  zoneDesc: 'Commercial Zone',
                  requests: '42,500',
                  waitTime: '3.2m',
                  completionValue: '98.2%',
                  completionProgress: 0.98,
                  completionColor: AppColors.cFF00C46B,
                  status: 'STEADY TREND',
                  statusColor: AppColors.cFF00C46B,
                  statusBgColor: AppColors.cFFE8FDF2,
                ),
                _buildRow(
                  city: 'Delhi NCR',
                  zoneDesc: 'Primary Hub',
                  requests: '38,100',
                  waitTime: '5.8m',
                  completionValue: '84.5%',
                  completionProgress: 0.84,
                  completionColor: AppColors.cFFFFD12E,
                  status: 'MODERATE SURGE',
                  statusColor: Color(
                    0xFFD4A000,
                  ), // Darker yellow for text visibility
                  statusBgColor: AppColors.cFFFFFBE8,
                ),
                _buildRow(
                  city: 'Bangalore East',
                  zoneDesc: 'IT Corridor',
                  requests: '28,900',
                  waitTime: '4.1m',
                  completionValue: '92.0%',
                  completionProgress: 0.92,
                  completionColor: AppColors.cFF00C46B,
                  status: 'NORMAL',
                  statusColor: AppColors.cFF00C46B,
                  statusBgColor: AppColors.cFFE8FDF2,
                ),
                _buildRow(
                  city: 'Chennai Central',
                  zoneDesc: 'Residential Area',
                  requests: '12,400',
                  waitTime: '8.2m',
                  completionValue: '68.2%',
                  completionProgress: 0.68,
                  completionColor: AppColors.cFFEA3546,
                  status: 'HIGH DEMAND',
                  statusColor: AppColors.cFFEA3546,
                  statusBgColor: AppColors.cFFFFECEE,
                ),
              ],
            ),
          ),
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
    required String city,
    required String zoneDesc,
    required String requests,
    required String waitTime,
    required String completionValue,
    required double completionProgress,
    required Color completionColor,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                city,
                style: AppTypography.base.copyWith(
                  
                ),
              ),
              SizedBox(height: 2),
              Text(
                zoneDesc,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            requests,
            style: AppTypography.base.copyWith(
              
            ),
          ),
        ),
        DataCell(
          Text(
            waitTime,
            style: AppTypography.base.copyWith(
              
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  completionValue,
                  style: AppTypography.base.copyWith(
                    
                  ),
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 60,
                height: 4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cFFF4F6F9,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: completionProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: completionColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
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
                SizedBox(width: 6),
                Text(
                  status,
                  style: AppTypography.base.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 8,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {},
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
                color: AppColors.cFF00C46B,
              ),
            ),
          ),
        ),
      ],
    );
  }
}




