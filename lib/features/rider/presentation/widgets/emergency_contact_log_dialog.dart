import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class EmergencyContactLogDialog extends StatelessWidget {
  EmergencyContactLogDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      child: Container(
        width: 700,
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emergency Contact Management & Logs',
                      style: AppTypography.base.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Linked contacts and historical communication activity',
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: 24,
                ),
              ],
            ),
            SizedBox(height: 32),

            // Linked Emergency Contacts Section
            Row(
              children: [
                Icon(
                  Icons.contact_mail_outlined,
                  size: 20,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8),
                Text(
                  'Linked Emergency Contacts',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildContactCard(
                    name: 'Ananya Sharma',
                    tag: '(Primary)',
                    relation: 'Wife',
                    phone: '+91 98765 43210',
                    isVerified: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildContactCard(
                    name: 'Rajesh Sharma',
                    tag: '',
                    relation: 'Brother',
                    phone: '+91 98765 43211',
                    isVerified: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Communication Log Section
            Row(
              children: [
                Icon(Icons.history, size: 20, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Communication Log',
                  style: AppTypography.base.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Log Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children:  [
                        Expanded(
                          flex: 2,
                          child: Text('TIMESTAMP', style: _tableHeaderStyle),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('CONTACT NAME', style: _tableHeaderStyle),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'TRIGGER EVENT',
                            style: _tableHeaderStyle,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('METHOD', style: _tableHeaderStyle),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('STATUS', style: _tableHeaderStyle),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: AppColors.divider),
                  _buildLogRow(
                    '28 Feb, 07:46',
                    'Ananya Sharma',
                    '# RID-44210 SOS',
                    'SMS',
                  ),
                  Divider(height: 1, color: AppColors.divider),
                  _buildLogRow(
                    '28 Feb, 07:48',
                    'Rajesh Sharma',
                    '# RID-44210 SOS',
                    'SMS',
                  ),
                  Divider(height: 1, color: AppColors.divider),
                  _buildLogRow(
                    '12 Sep, 21:13',
                    'Ananya Sharma',
                    '# RID-39822 Panic',
                    'SMS',
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Done Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
                  style: AppTypography.base.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final _tableHeaderStyle = AppTypography.base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  Widget _buildContactCard({
    required String name,
    required String tag,
    required String relation,
    required String phone,
    required bool isVerified,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cFFD1FAE5, // light green bg
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      name,
                      style: AppTypography.base.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (tag.isNotEmpty)
                      Text(
                        tag,
                        style: AppTypography.base.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '$relation • $phone',
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isVerified)
            Text(
              'VERIFIED',
              style: AppTypography.base.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogRow(String time, String name, String trigger, String method) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              time,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              trigger,
              style: AppTypography.base.copyWith(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4),
                Text(
                  method,
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(width: 4),
                Text(
                  '$method Delivered',
                  style: AppTypography.base.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



