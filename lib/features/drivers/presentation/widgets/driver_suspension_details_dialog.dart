// import 'package:flutter/material.dart';
// import 'package:admin/core/theme/app_typography.dart';
// import '../../../../core/theme/app_colors.dart';

// class SuspensionDetailsDialog extends StatelessWidget {
//   SuspensionDetailsDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Dialog sizes to maintain a good aspect ratio
//     final screenWidth = MediaQuery.of(context).size.width;
//     final dialogWidth = screenWidth > 800 ? 700.0 : screenWidth * 0.9;

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       backgroundColor: AppColors.white,
//       surfaceTintColor: AppColors.transparent, // Prevents Material 3 color tinting
//       child: Container(
//         width: dialogWidth,
//         constraints: BoxConstraints(maxHeight: 800),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildHeader(context),
//             Divider(height: 1, color: AppColors.cFFF3F4F6),
//             Flexible(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(flex: 1, child: _buildActivityOverview()),
//                         SizedBox(width: 32),
//                         Expanded(flex: 1, child: _buildPolicyViolation()),
//                       ],
//                     ),
//                     SizedBox(height: 32),
//                     _buildUserReports(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.warning_amber_rounded,
//                 color: AppColors.error,
//                 size: 24,
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'CURRENT VIOLATION DETAILS',
//                 style: AppTypography.base.copyWith(
//                   color: AppColors.error,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'Reported on 15 Feb, 2026',
//                 style: AppTypography.base.copyWith(
//                   color: AppColors.textSecondary.withValues(alpha: 0.7),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(
//               Icons.close,
//               color: AppColors.textPrimary,
//               size: 20,
//             ),
//             padding: EdgeInsets.zero,
//             constraints: BoxConstraints(),
//             splashRadius: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActivityOverview() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Activity Overview',
//           style: AppTypography.base.copyWith(
//             color: AppColors.textPrimary,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _OverviewStatCard(title: 'TOTAL RIDES', value: '142'),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: _OverviewStatCard(title: 'ACCOUNT AGE', value: '2 Years'),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _OverviewStatCard(
//                 title: 'CANCELLATION RATE',
//                 value: '8.2%',
//                 isErrorValue: true,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: _OverviewStatCard(
//                 title: 'LAST RIDE DATE',
//                 value: 'Oct 12, 2023',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildPolicyViolation() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Policy Violation: Unsafe Driving Reports',
//           style: AppTypography.base.copyWith(
//             color: AppColors.textPrimary,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         Text(
//           'Multiple users reported aggressive maneuvering and exceeding speed limits in residential zones. Telemetry data confirms speeds 30% above limit on 3 separate occasions during trip #TRP-8821.',
//           style: AppTypography.base.copyWith(
//             color: AppColors.cFF6B7280,
//             fontSize: 13,
//             height: 1.6,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildUserReports() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'USER REPORTS (02)',
//           style: AppTypography.base.copyWith(
//             color: AppColors.textSecondary.withValues(alpha: 0.8),
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 0.5,
//           ),
//         ),
//         SizedBox(height: 16),
//         _UserReportItem(
//           rating: '1/5 Rating',
//           title: 'Felt very unsafe',
//           comment:
//               'The driver was swerving between lanes and braking very late. I had to ask him to slow down twice.',
//         ),
//         SizedBox(height: 12),
//         _UserReportItem(
//           rating: '2/5 Rating',
//           title: 'Aggressive driver',
//           comment: 'Overtook other vehicles dangerously. Please investigate.',
//         ),
//       ],
//     );
//   }
// }

// class _OverviewStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final bool isErrorValue;

//   const _OverviewStatCard({
//     required this.title,
//     required this.value,
//     this.isErrorValue = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.cFFF8FAFC, // Very light gray/blue background
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.cFFF1F5F9),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppTypography.base.copyWith(
//               color: AppColors.cFF94A3B8, // slate-400
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 0.5,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             value,
//             style: AppTypography.base.copyWith(
//               color: isErrorValue ? AppColors.error : AppColors.textPrimary,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _UserReportItem extends StatelessWidget {
//   final String rating;
//   final String title;
//   final String comment;

//   const _UserReportItem({
//     required this.rating,
//     required this.title,
//     required this.comment,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColors.cFFE2E8F0), // slate-200
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: AppColors.cFFEAB308,
//                 size: 14,
//               ), // yellow-500
//               SizedBox(width: 6),
//               Text(
//                 rating,
//                 style: AppTypography.base.copyWith(
//                   color: AppColors.textPrimary,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 '•',
//                 style: AppTypography.base.copyWith(color: AppColors.cFF94A3B8, fontSize: 13),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 '"$title"',
//                 style: AppTypography.base.copyWith(
//                   color: AppColors.cFF64748B,
//                   fontSize: 13,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text(
//             '"$comment"',
//             style: AppTypography.base.copyWith(
//               color: AppColors.cFF475569, // slate-600
//               fontSize: 13,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class SuspensionDetailsDialog extends StatelessWidget {
  final bool showActions;
  SuspensionDetailsDialog({super.key, this.showActions = true});

  @override
  Widget build(BuildContext context) {
    // Dialog sizes to maintain a good aspect ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 800 ? 850.0 : screenWidth * 0.5;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.white,
      surfaceTintColor:
          AppColors.transparent, // Prevents Material 3 color tinting
      child: Container(
        width: dialogWidth,
        constraints: BoxConstraints(maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Divider(height: 1, color: AppColors.cFFF3F4F6),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: _buildActivityOverview()),
                        SizedBox(width: 32),
                        Expanded(flex: 4, child: _buildPolicyViolation()),
                      ],
                    ),
                    SizedBox(height: 32),
                    _buildUserReports(),
                  ],
                ),
              ),
            ),

            if (showActions) ...[
              // const SizedBox(height: 8),
              Divider(height: 1, color: AppColors.cFFF3F4F6),

              const SizedBox(height: 8),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cFFF3F4F6,
                          elevation: 0,
                          
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTypography.base.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                
                    const SizedBox(width: 16),
                
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Your confirm logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green, // green
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Confirm Activate",
                          style: AppTypography.base.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'CURRENT VIOLATION DETAILS',
                style: AppTypography.h3.copyWith(
                  fontSize: 15,
                  color: AppColors.error,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Reported on 15 Feb, 2026',
                style: AppTypography.base.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: AppColors.textPrimary, size: 20),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity Overview',
          style: AppTypography.base.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(title: 'TOTAL RIDES', value: '142'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _OverviewStatCard(title: 'ACCOUNT AGE', value: '2 Years'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _OverviewStatCard(
                title: 'CANCELLATION RATE',
                value: '8.2%',
                isErrorValue: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _OverviewStatCard(
                title: 'LAST RIDE DATE',
                value: 'Oct 12, 2023',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPolicyViolation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Policy Violation: Unsafe Driving Reports',
          style: AppTypography.base.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Multiple users reported aggressive maneuvering and exceeding speed limits in residential zones. Telemetry data confirms speeds 30% above limit on 3 separate occasions during trip #TRP-8821.',
          style: AppTypography.base.copyWith(
            color: AppColors.cFF6B7280,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildUserReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'USER REPORTS (02)',
          style: AppTypography.base.copyWith(
            color: AppColors.textSecondary.withValues(alpha: 0.8),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 16),
        _UserReportItem(
          rating: '1/5 Rating',
          title: 'Felt very unsafe',
          comment:
              'The driver was swerving between lanes and braking very late. I had to ask him to slow down twice.',
        ),
        SizedBox(height: 12),
        _UserReportItem(
          rating: '2/5 Rating',
          title: 'Aggressive driver',
          comment: 'Overtook other vehicles dangerously. Please investigate.',
        ),
        SizedBox(height: 12),
        _UserReportItem(
          rating: '1/5 Rating',
          title: 'Felt very unsafe',
          comment:
              'The driver was swerving between lanes and braking very late. I had to ask him to slow down twice.',
        ),
        SizedBox(height: 12),
        _UserReportItem(
          rating: '2/5 Rating',
          title: 'Aggressive driver',
          comment: 'Overtook other vehicles dangerously. Please investigate.',
        ),
        SizedBox(height: 12),
        _UserReportItem(
          rating: '1/5 Rating',
          title: 'Felt very unsafe',
          comment:
              'The driver was swerving between lanes and braking very late. I had to ask him to slow down twice.',
        ),
        SizedBox(height: 12),
        _UserReportItem(
          rating: '2/5 Rating',
          title: 'Aggressive driver',
          comment: 'Overtook other vehicles dangerously. Please investigate.',
        ),
      ],
    );
  }
}

class _OverviewStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isErrorValue;

  const _OverviewStatCard({
    required this.title,
    required this.value,
    this.isErrorValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cFFF8FAFC, // Very light gray/blue background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cFFF1F5F9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.base.copyWith(
              color: AppColors.cFF94A3B8, // slate-400
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.base.copyWith(
              color: isErrorValue ? AppColors.error : AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserReportItem extends StatelessWidget {
  final String rating;
  final String title;
  final String comment;

  const _UserReportItem({
    required this.rating,
    required this.title,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFE2E8F0), // slate-200
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.cFFEAB308,
                size: 14,
              ), // yellow-500
              SizedBox(width: 6),
              Text(
                rating,
                style: AppTypography.base.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '•',
                style: AppTypography.base.copyWith(
                  color: AppColors.cFF94A3B8,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '"$title"',
                style: AppTypography.base.copyWith(
                  color: AppColors.cFF64748B,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '"$comment"',
            style: AppTypography.base.copyWith(
              color: AppColors.cFF475569, // slate-600
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}



