import 'package:admin/features/incentives/presentation/widgets/incentive_launched_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class QuestTypeSelection extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  QuestTypeSelection({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Text('Quest Type Selection', style: AppTypography.h3),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cFFF9FAFB,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTab(
                    index: 0,
                    title: 'Daily',
                    subtitle: 'Reset every 24h',
                    isSelected: selectedTab == 0,
                  ),
                  _buildTab(
                    index: 1,
                    title: 'Weekly',
                    subtitle: 'Monday to Sunday',
                    isSelected: selectedTab == 1,
                  ),
                  _buildTab(
                    index: 2,
                    title: 'Bonus',
                    subtitle: 'Special event quest',
                    isSelected: selectedTab == 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required int index,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTypography.bodyRegular.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TargetConfiguration extends StatelessWidget {
  final int selectedTab;

  TargetConfiguration({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text('Target Vehicle', style: AppTypography.h3),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Vehicle Categories',
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        TargetVehicleDropdown(),
      ],
    );
  }
}

class CampaignSchedule extends StatelessWidget {
  final int selectedTab;

  CampaignSchedule({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text('Campaign Schedule', style: AppTypography.h3),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildInputField('From Date', '06/12/2024')),
            SizedBox(width: 16),
            Expanded(child: _buildInputField('To Date', '06/12 /2024')),
          ],
        ),

        if (selectedTab == 0) ...[
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildInputField('From Time', '08:00 AM')),
              SizedBox(width: 16),
              Expanded(child: _buildInputField('To Time', '12:00 PM')),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildInputField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cFFF9FAFB,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class MilestoneRules extends StatelessWidget {
  MilestoneRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Milestone Rules (Incremental Splits)',
                  style: AppTypography.h3,
                ),
              ],
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add, size: 16),
              label: Text('Add Milestone'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddMilestoneDialog(),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Total Ride Target: 12 Rides',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 24),

        _buildMilestoneCard(
          tier: 'Silver',
          target: '5',
          reward: '50',
          iconColor: AppColors.amber,
          iconData: Icons.emoji_events_outlined,
        ),
        SizedBox(height: 16),
        _buildMilestoneCard(
          tier: 'Gold',
          target: '3',
          reward: '100',
          iconColor: AppColors.blueGrey,
          iconData: Icons.emoji_events_outlined,
        ),
        SizedBox(height: 16),
        _buildMilestoneCard(
          tier: 'Platinum',
          target: '4',
          reward: '150',
          iconColor: AppColors.blueAccent,
          iconData: Icons.diamond_outlined,
        ),
      ],
    );
  }

  Widget _buildMilestoneCard({
    required String tier,
    required String target,
    required String reward,
    required Color iconColor,
    required IconData iconData,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cFFF9FAFB,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 24),
          ),
          SizedBox(width: 24),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TIER LEVEL',
                      style: AppTypography.bodyRegular.copyWith(
                        // fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      tier,
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TARGET',
                      style: AppTypography.bodyRegular.copyWith(
                        // fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      target,
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REWARD (₹)',
                      style: AppTypography.bodyRegular.copyWith(
                        // fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      reward,
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: AppColors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class CampaignSchedule extends StatelessWidget {
//   final int selectedTab;

//   CampaignSchedule({super.key, required this.selectedTab});

class ProgramNameConfiguration extends StatelessWidget {
  final int selectedTab;

  ProgramNameConfiguration({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Text('Program Name', style: AppTypography.h3),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Name',
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cFFF9FAFB,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
           selectedTab == 0 ? 'Morning' : 'Weekly Rider',
            style: AppTypography.bodyRegular.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class TargetVehicleDropdown extends StatefulWidget {
  TargetVehicleDropdown({super.key});

  @override
  State<TargetVehicleDropdown> createState() => _TargetVehicleDropdownState();
}

class _TargetVehicleDropdownState extends State<TargetVehicleDropdown> {
  String _selectedValue = 'Bike/Scooter';
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _selectValue(String value) {
    setState(() {
      _selectedValue = value;
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        boxShadow: _isOpen
            ? [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggleDropdown,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cFFF9FAFB,
                borderRadius: _isOpen
                    ? BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )
                    : BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue,
                    style: AppTypography.bodyRegular.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    _isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          if (_isOpen) ...[
            Divider(height: 1, color: AppColors.cFFE5E7EB),
            _buildDropdownItem('Cab', Icons.directions_car_outlined),
            Divider(height: 1, color: AppColors.cFFE5E7EB),
            _buildDropdownItem('Auto', Icons.airport_shuttle_outlined),
            Divider(height: 1, color: AppColors.cFFE5E7EB),
            _buildDropdownItem(
              'Bike/Scooter',
              Icons.pedal_bike_outlined,
              isLast: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    String value,
    IconData icon, {
    bool isLast = false,
  }) {
    final isSelected = _selectedValue == value;
    return InkWell(
      onTap: () => _selectValue(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cFFF0FDF4 : AppColors.white,
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : AppColors.grey.shade400,
              size: 20,
            ),
            SizedBox(width: 12),
            Text(
              value,
              style: AppTypography.bodyRegular.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.black87,
              ),
            ),
            Spacer(),
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.blueGrey.shade300,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class AddMilestoneDialog extends StatelessWidget {
  AddMilestoneDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        color: AppColors.white,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('Add Milestone', style: AppTypography.h3),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: AppColors.grey, size: 20),
                ),
              ],
            ),
            SizedBox(height: 24),
            const _MilestoneInputRow(
              initialTier: 'Silver',
              initialTarget: '5',
              initialReward: '150',
              iconColor: AppColors.amber,
              iconData: Icons.emoji_events_outlined,
            ),
            SizedBox(height: 16),
            const _MilestoneInputRow(
              initialTier: 'Silver',
              initialTarget: '3',
              initialReward: '100',
              iconColor: AppColors.blueGrey,
              iconData: Icons.emoji_events_outlined,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible:
                    //       false,
                    //   builder: (context) => IncentiveLaunchedDialog(),
                    // );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.cFFF3F4F6,
                    foregroundColor: AppColors.black,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add',
                    style: AppTypography.base.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: AppTypography.base.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MilestoneInputRow extends StatelessWidget {
  final String initialTier;
  final String initialTarget;
  final String initialReward;
  final Color iconColor;
  final IconData iconData;

  const _MilestoneInputRow({
    required this.initialTier,
    required this.initialTarget,
    required this.initialReward,
    required this.iconColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TIER LEVEL',
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cFFF9FAFB,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(iconData, color: iconColor, size: 20),
                    SizedBox(width: 8),
                    Text(
                      initialTier,
                      style: AppTypography.bodyRegular.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Target',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cFFF9FAFB,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  initialTarget,
                  style: AppTypography.bodyRegular.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REWARD (₹)',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.cFFF9FAFB,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  initialReward,
                  style: AppTypography.bodyRegular.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
