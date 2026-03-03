import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/incentive_form_sections.dart';
import '../widgets/incentive_launched_dialog.dart';
import '../widgets/mobile_preview_widget.dart';

class CreateIncentiveScreen extends StatefulWidget {
  const CreateIncentiveScreen({super.key});

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
                  padding: const EdgeInsets.all(32.0),
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
                      const SizedBox(height: 24),
                      TargetConfiguration(selectedTab: _selectedTab),
                      const SizedBox(height: 24),
                      const ProgramNameConfiguration(),
                      const SizedBox(height: 24),
                      CampaignSchedule(selectedTab: _selectedTab),
                      const SizedBox(height: 24),
                      MilestoneRules(),
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
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Live mobile preview',
                          style: AppTypography.h4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Expanded(child: MobilePreviewWidget()),
                        const SizedBox(height: 32),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const IncentiveLaunchedDialog(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Publish Incentive',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
            padding: const EdgeInsets.all(24.0),
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
                const SizedBox(height: 24),
                TargetConfiguration(selectedTab: _selectedTab),
                const SizedBox(height: 24),
                const ProgramNameConfiguration(),
                const SizedBox(height: 24),
                CampaignSchedule(selectedTab: _selectedTab),
                const SizedBox(height: 24),
                const MilestoneRules(),
                const SizedBox(height: 48),
                Text(
                  'Live mobile preview',
                  style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const SizedBox(
                  height:
                      800, // Fixed height for mobile preview mockup inside scroll
                  child: MobilePreviewWidget(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const IncentiveLaunchedDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Publish Incentive',
                      style: TextStyle(
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
