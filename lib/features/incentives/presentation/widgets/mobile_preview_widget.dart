import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class MobilePreviewWidget extends StatelessWidget {
  final int selectedTab;
  MobilePreviewWidget({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 375, // Standard mobile width
          height: 812, // Standard mobile height
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: AppColors.cFF1E1E2C, // Dark phone border
              width: 14,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 30,
                offset: Offset(0, 15),
              ),
            ],
          ),
          // Clip content to border radius
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Status bar mock
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: null,
              ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         '9:41',
              //         style: AppTypography.base.copyWith(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 14,
              //         ),
              //       ),
              //       Row(
              //         children: const [
              //           Icon(Icons.signal_cellular_4_bar, size: 16),
              //           SizedBox(width: 4),
              //           Icon(Icons.wifi, size: 16),
              //           SizedBox(width: 4),
              //           Icon(Icons.battery_full, size: 16),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              // App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 20),
                    Expanded(
                      child: Text(
                        'Incentives',
                        textAlign: TextAlign.center,
                        style: AppTypography.h3.copyWith(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 20), // Balance center alignment
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Tabs
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.cFFF5F5F5,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      if (selectedTab == 0) ...[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Day',
                              textAlign: TextAlign.center,
                              style: AppTypography.base.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Week',
                            textAlign: TextAlign.center,
                            style: AppTypography.base.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Bonus',
                            textAlign: TextAlign.center,
                            style: AppTypography.base.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Text(
                            'Day',
                            textAlign: TextAlign.center,
                            style: AppTypography.base.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Week',
                              textAlign: TextAlign.center,
                              style: AppTypography.base.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Bonus',
                            textAlign: TextAlign.center,
                            style: AppTypography.base.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Date Selector (Horizontal Scroll)
              if (selectedTab == 0) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      _buildDateItem('Tue', '10', false),
                      _buildDateItem('Wed', '11', false),
                      _buildDateItem('Thu', '12', true), // Active item
                      _buildDateItem('Fri', '13', false),
                      _buildDateItem('Sat', '14', false),
                    ],
                  ),
                ),
              ] else ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      _buildWeekItem('Tue', '1', '7', false),
                      _buildWeekItem('Wed', '8', '14', false),
                      _buildWeekItem('Thu', '15', '21', true), // Active item
                      _buildWeekItem('Fri', '22', '29', false),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedTab == 0) ...[
                        Center(
                          child: Text(
                            'MORNING SESSION • 08:00 AM - 12:00 PM',
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey[600],
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ] else ...[
                        Center(
                          child: Text(
                            'WEEKLY SESSION',
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey[600],
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 16),

                      // Active Quest Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.cFF1B4332, // Dark green
                              AppColors.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ACTIVE QUEST',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.white.withValues(alpha: 0.8),
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Potential Reward: ₹150',
                              style: AppTypography.h3.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 32),

                            // Progress Tracker (Custom layout)
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 4,
                                  color: AppColors.white.withValues(alpha: 0.3),
                                ),
                                Container(
                                  width: 80, // Example progress
                                  height: 4,
                                  color: AppColors.white,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildQuestNode(true, '3'),
                                    _buildQuestNode(false, '5'),
                                    _buildQuestNode(false, '7'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '2 of 3 rides completed',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.white.withValues(
                                      alpha: 0.8,
                                    ),
                                  ),
                                ),
                                Text(
                                  'TIER 1',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),

                      // Milestones List (Vertical timeline approach)
                      _buildMilestoneStep(
                        tier: 'Silver Milestone',
                        desc: 'Complete 3 rides today',
                        amount: '₹50',
                        statusText: 'UNLOCKED',
                        isUnlocked: true,
                        isLast: false,
                      ),
                      _buildMilestoneStep(
                        tier: 'Gold Milestone',
                        desc: 'Complete 5 rides today',
                        amount: '₹100',
                        statusText: 'LOCKED',
                        isUnlocked: false,
                        isLast: false,
                      ),
                      _buildMilestoneStep(
                        tier: 'Platinum Milestone',
                        desc: 'Complete 7 rides today',
                        amount: '₹150',
                        statusText: 'LOCKED',
                        isUnlocked: false,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateItem(String day, String date, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: AppColors.primary) : null,
      ),
      child: Column(
        children: [
          Text(
            day,
            style: AppTypography.base.copyWith(
              color: isActive ? AppColors.primary : AppColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            date,
            style: AppTypography.base.copyWith(
              color: isActive ? AppColors.primary : AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekItem(
    String day,
    String startdate,
    String enddate,
    bool isActive,
  ) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: AppColors.primary) : null,
      ),
      child: Row(
        children: [
          Text(
            day,
            style: AppTypography.base.copyWith(
              color: isActive ? AppColors.primary : AppColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            startdate,
            style: AppTypography.base.copyWith(
              color: isActive ? AppColors.primary : AppColors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(" - "),
          Text(
            enddate,
            style: AppTypography.base.copyWith(
              color: isActive ? AppColors.primary : AppColors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestNode(bool isActive, String label) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? AppColors.white : AppColors.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.base.copyWith(
            color: AppColors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneStep({
    required String tier,
    required String desc,
    required String amount,
    required String statusText,
    required bool isUnlocked,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isUnlocked ? AppColors.primary : AppColors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: AppColors.grey[200]),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8),

          // Card content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 24),
              padding: EdgeInsets.all(16),
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
                border: Border.all(color: AppColors.grey[100]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? AppColors.amber.withValues(alpha: 0.1)
                          : AppColors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      color: isUnlocked ? AppColors.amber : AppColors.grey[400],
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tier,
                          style: AppTypography.base.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isUnlocked
                                ? AppColors.black
                                : AppColors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          desc,
                          style: AppTypography.base.copyWith(
                            fontSize: 12,
                            color: AppColors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: AppTypography.base.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked
                              ? AppColors.primary
                              : AppColors.grey[400],
                        ),
                      ),
                      Text(
                        statusText,
                        style: AppTypography.base.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked
                              ? AppColors.amber
                              : AppColors.grey[400],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
