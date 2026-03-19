import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/incentive_form_sections.dart';
import '../widgets/incentive_launched_dialog.dart';
import '../widgets/mobile_preview_widget.dart';

class CreateIncentiveScreen extends StatefulWidget {
  CreateIncentiveScreen({super.key});

  @override
  State<CreateIncentiveScreen> createState() => _CreateIncentiveScreenState();
}

class _CreateIncentiveScreenState extends State<CreateIncentiveScreen> {
  // Quest Type Tab State
  // 0: Daily, 1: Weekly, 2: Bonus
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Form Area
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuestTypeSelection(
                        selectedTab: _selectedTab,
                        onTabChanged: (index) {
                          setState(() {
                            _selectedTab = index;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: AppColors.cFFF0F1F3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TargetConfiguration(selectedTab: _selectedTab),
                              SizedBox(height: 24),
                              ProgramNameConfiguration(
                                selectedTab: _selectedTab,
                              ),
                              SizedBox(height: 24),
                              CampaignSchedule(selectedTab: _selectedTab),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: AppColors.cFFF0F1F3),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MilestoneRules(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right side - Mobile Preview Area
              Expanded(
                flex: 3,
                child: Container(
                  color: AppColors.scaffoldBackground,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Live mobile preview',
                          style: AppTypography.h4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 32),
                        Expanded(
                          child: MobilePreviewWidget(selectedTab: _selectedTab),
                        ),
                        SizedBox(height: 32),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => IncentiveLaunchedDialog(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Publish Incentive',
                              style: AppTypography.base.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          // Mobile/Tablet fallback - Stack vertically
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestTypeSelection(
                  selectedTab: _selectedTab,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: AppColors.cFFF0F1F3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TargetConfiguration(selectedTab: _selectedTab),
                        SizedBox(height: 24),
                        ProgramNameConfiguration(selectedTab: _selectedTab),
                        SizedBox(height: 24),
                        CampaignSchedule(selectedTab: _selectedTab),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: AppColors.cFFF0F1F3),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MilestoneRules(),
                  ),
                ),
                SizedBox(height: 48),
                Text(
                  'Live mobile preview',
                  style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                SizedBox(
                  height:
                      800, // Fixed height for mobile preview mockup inside scroll
                  child: MobilePreviewWidget(selectedTab: _selectedTab),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => IncentiveLaunchedDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Publish Incentive',
                      style: AppTypography.base.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
