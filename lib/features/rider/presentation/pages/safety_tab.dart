import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class SafetyTab extends StatelessWidget {
  SafetyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'TOTAL SOS ALERTS',
                        value: '03',
                        valueColor: AppColors.cFFE11D48, // Pink/Red
                        subtitle: 'Lifetime total',
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _buildStatCard(
                        title: 'SAFETY SCORE',
                        value: '92/100',
                        valueColor: AppColors.cFF0D9488, // Teal
                        subtitle: 'Based on violations',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // SOS Incident History
                _buildIncidentHistoryCard(context),

                SizedBox(height: 24),

                // Live Location Sharing Log
                _buildLiveLocationCard(),
              ],
            ),
          ),

          SizedBox(width: 24),

          // Right Column
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActiveIncidentSelection(),
                SizedBox(height: 24),
                _buildDriverDetailsLog(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color valueColor,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: AppTypography.base.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          SizedBox(height: 12),
          Text(
            subtitle,
            style: AppTypography.base.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentHistoryCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFF0F1F3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'SOS Incident History',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cFF1A1D1F,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Detailed log of safety triggers',
                  style: AppTypography.base.copyWith(fontSize: 13, color: AppColors.cFF9EA5AD),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor: WidgetStateProperty.all(AppColors.white),
              dataRowMaxHeight: 80,
              dataRowMinHeight: 80,
              horizontalMargin: 24,
              columnSpacing: 24,
              dividerThickness: 1,
              headingTextStyle: AppTypography.base.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.cFF6F767E,
                letterSpacing: 0.5,
              ),
              columns: const [
                DataColumn(label: Text('DATE &\nTIME')),
                DataColumn(label: Text('RIDE ID')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: [
                _buildIncidentRow(
                  date: '28 Feb, 2026',
                  time: '07:45 PM',
                  rideId: '#RID- 44210',
                  status: 'Active',
                  statusColor: AppColors.cFF00C46B, // Green
                  bgColor: Color(
                    0xFFCFEFE2,
                  ), // Light green for active item
                ),
                _buildIncidentRow(
                  date: '12 Sep, 2025',
                  time: '08:12 PM',
                  rideId: '#RID- 39822',
                  status: 'Resolved',
                  statusColor: AppColors.cFF00C46B,
                ),
                _buildIncidentRow(
                  date: '04 Aug, 2025',
                  time: '10:30 AM',
                  rideId: '#RID- 31004',
                  status: 'False Alarm',
                  statusColor: AppColors.cFF00C46B,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildIncidentRow({
    required String date,
    required String time,
    required String rideId,
    required String status,
    required Color statusColor,
    Color bgColor = AppColors.transparent,
  }) {
    return DataRow(
      color: WidgetStateProperty.all(bgColor),
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: AppTypography.base.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
              SizedBox(height: 2),
              Text(
                time,
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
            rideId,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
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
                  fontSize: 13,
                  color: AppColors.cFF1A1D1F,
                ),
              ),
            ],
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
              'View Logs',
              style: AppTypography.base.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: AppColors.cFF1A1D1F,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveLocationCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Location Sharing Log',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Records of location sharing with emergency contacts',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.4)),
          _buildLiveLocationRow(
            'Shared with: Ananya Sharma (Wife)',
            'Duration: 42 minutes • Status: Session Ended',
            '07:46 PM',
          ),
          _buildLiveLocationRow(
            'Shared with: Rajesh Sharma (Brother)',
            'Duration: 38 minutes • Status: Session Ended',
            '07:48 PM',
          ),
        ],
      ),
    );
  }

  Widget _buildLiveLocationRow(String title, String subtitle, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.my_location,
              size: 20,
              color: AppColors.cFF6F767E,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTypography.base.copyWith(
                    fontSize: 13,
                    color: AppColors.cFF6F767E,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.cFF9EA5AD,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveIncidentSelection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cFFFEF2F2, // Light red bg
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFFECACA), // Red border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE INCIDENT SELECTION',
                      style: AppTypography.base.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.cFFE11D48,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'RID-44210 Context',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.cFF6F767E,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.info_outline,
                  color: AppColors.cFFE11D48,
                  size: 20,
                ),
              ],
            ),
          ),

          // Map Placeholder Image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://static.mapmyindia.com/images/mmi_maps.png', // Temporary placeholder for India Map view
                  ),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: AppColors.cFFEFEFEF),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'ALERT LAT/LONG',
                            style: AppTypography.base.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.cFF6F767E,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '12.9716° N, 77.5946° E',
                            style: AppTypography.base.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.cFF1A1D1F,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.cFFE11D48, // Match red theme
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.cell_tower,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ALERT LOCATION',
                                style: AppTypography.base.copyWith(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.cFF6F767E,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Outer Ring Rd, Marathahalli',
                                style: AppTypography.base.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.cFF1A1D1F,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.cFFE11D48,
                      size: 48,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Details List
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'DRIVER ASSIGNED',
                          style: AppTypography.base.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.cFF6F767E,
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?u=a042581f4e29026704d', // dummy user
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Amit K.',
                          style: AppTypography.base.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.cFF1A1D1F,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    'VEHICLE',
                    style: AppTypography.base.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.cFF6F767E,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Ntroq (TN02 By4447)',
                    style: AppTypography.base.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cFF1A1D1F,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cFFFEF2F2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.cFFFECACA, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOTES',
                    style: AppTypography.base.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.cFFE11D48,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '"User pressed panic button. Contacted user within 2 mins. User reported accidental press while.."',
                    style: AppTypography.base.copyWith(
                      fontSize: 14,
                      color: AppColors.cFF6F767E,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDriverDetailsLog() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Driver details Sharing Log',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Driver details sharing with emergency contacts',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.4)),

          _buildDriverDetailRow('Ananya Sharma (Wife)', '07:46 PM'),
          _buildDriverDetailRow('Aruna (Sister)', '07:46 PM'),
          _buildDriverDetailRow('Arun (Brother)', '07:46 PM'),
        ],
      ),
    );
  }

  Widget _buildDriverDetailRow(String name, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.cFFF9FAFB,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.my_location,
                  size: 16,
                  color: AppColors.cFF6F767E,
                ),
              ),
              SizedBox(width: 16),
              Text(
                name,
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.cFF6F767E,
            ),
          ),
        ],
      ),
    );
  }
}




