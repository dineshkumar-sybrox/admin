import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class SafetyTab extends StatelessWidget {
  SafetyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'TOTAL SOS ALERTS',
                  icon: Icons.sos,
                  iconColor: AppColors.cFFE11D48, // Red
                  value: '03',
                  valueColor: AppColors.cFFE11D48, // Pink/Red
                  subtitle: 'Lifetime total',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  title: 'OVERALL SAFETY SCORE',
                  icon: Icons.health_and_safety_sharp,
                  iconColor: AppColors.cFFD4A000, // Teal
                  value: '92/100',
                  valueColor: AppColors.cFFD4A000, // Teal
                  subtitle: 'Based on violations',
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildIncidentHistoryCard(context),

          SizedBox(height: 24),

          // Live Location Sharing Log
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: _buildLiveLocationCard()),
              SizedBox(width: 24),
              Expanded(flex: 4, child: _buildDriverDetailsLog()),
            ],
          ),
        ],
      ),

      // Row(

      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     // Left Column
      //     Expanded(
      //       flex: 2,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           // Top Cards
      //           Row(
      //             children: [
      //               Expanded(
      //                 child: _buildStatCard(
      //                   title: 'TOTAL SOS ALERTS',
      //                   icon: Icons.sos,
      //                   iconColor: AppColors.cFFE11D48, // Red
      //                   value: '03',
      //                   valueColor: AppColors.cFFE11D48, // Pink/Red
      //                   subtitle: 'Lifetime total',
      //                 ),
      //               ),
      //               SizedBox(width: 24),
      //               Expanded(
      //                 child: _buildStatCard(
      //                   title: 'OVERALL SAFETY SCORE',
      //                   icon: Icons.health_and_safety_sharp,
      //                   iconColor: AppColors.cFFD4A000, // Teal
      //                   value: '92/100',
      //                   valueColor: AppColors.cFFD4A000, // Teal
      //                   subtitle: 'Based on violations',
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(height: 24),

      //           // SOS Incident History
      //           _buildIncidentHistoryCard(context),

      //           SizedBox(height: 24),

      //           // Live Location Sharing Log
      //           _buildLiveLocationCard(),
      //         ],
      //       ),
      //     ),

      //     SizedBox(width: 24),

      //     // Right Column
      //     Expanded(
      //       flex: 1,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           _buildActiveIncidentSelection(),
      //           SizedBox(height: 24),
      //           _buildDriverDetailsLog(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 30, color: iconColor),
          ),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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

              Text(
                value,
                style: AppTypography.base.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
            child: Text('SOS Incident History', style: AppTypography.h3),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),
          SizedBox(
            width: double.infinity,
            child: DataTable(
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
              showCheckboxColumn: false,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: AppColors.cFFF3F4F6,
                  width: 1,
                ),
              ),
              columns: const [
                DataColumn(label: Text('DATE & TIME')),
                DataColumn(label: Text('RIDE ID')),
                DataColumn(label: Text('MOBILE NUMBER')),
                DataColumn(label: Text('PICKUP-DROP LOCATIONS')),
                DataColumn(label: Text('DRIVER NAME')),
                DataColumn(label: Text('ACTION')),
              ],
              rows: [
                _buildIncidentRow(
                  date: '28 Feb, 2026',
                  time: '07:45 PM',
                  rideId: '#RID- 44210',
                  mobileNumber: '+91 98765 43210',
                  pickdropLocation: 'MG Road → Koramangala',
                  driverName: 'Amit Kumar',
                  status: 'Active',
                ),
                _buildIncidentRow(
                  date: '12 Sep, 2025',
                  time: '08:12 PM',
                  mobileNumber: '+91 98765 43210',
                  pickdropLocation: 'Indiranagar → Jayanagar',
                  driverName: 'Rajesh Sharma',

                  rideId: '#RID- 39822',
                  status: 'Resolved',
                ),
                _buildIncidentRow(
                  date: '04 Aug, 2025',
                  time: '10:30 AM',
                  rideId: '#RID- 31004',
                  mobileNumber: '+91 98765 43210',
                  pickdropLocation: 'Whitefield → MG Road',
                  driverName: 'Sunita Verma',
                  status: 'False Alarm',
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.cFFF0F1F3),

          // Pagination
          Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing 1 of 25 transactions',
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
                    _buildPaginator('4', isActive: false),
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

  DataRow _buildIncidentRow({
    required String date,
    required String time,
    required String rideId,
    required String mobileNumber,
    required String pickdropLocation,
    required String driverName,
    required String status,
  }) {
    return DataRow(
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
          Text(
            mobileNumber,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            pickdropLocation,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
            ),
          ),
        ),
        DataCell(
          Text(
            driverName,
            style: AppTypography.base.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.cFF1A1D1F,
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
                Text('Live Location Sharing Log', style: AppTypography.h3),
                SizedBox(height: 4),
                Text(
                  'Records of location sharing with emergency contacts',
                  style: AppTypography.base.copyWith(),
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
              Icons.share_location_sharp,
              size: 25,
              color: AppColors.grey,
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    color: AppColors.cFF6F767E,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.base.copyWith(
              fontSize: 13,
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
                Icon(Icons.info_outline, color: AppColors.cFFE11D48, size: 20),
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                Text('Driver details Sharing Log', style: AppTypography.h3),
                SizedBox(height: 4),
                Text(
                  'Driver details sharing with emergency contacts',
                  style: AppTypography.base.copyWith(),
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
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  Icons.share_location_sharp,
                  size: 25,
                  color: AppColors.grey,
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
