import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class RateCardManagementPage extends StatefulWidget {
  const RateCardManagementPage({super.key});

  @override
  State<RateCardManagementPage> createState() => _RateCardManagementPageState();
}

class _RateCardManagementPageState extends State<RateCardManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _nightSurchargeEnabled = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs
        _buildTabs(),

        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Configuration
                    Expanded(
                      flex: 14,
                      child: Column(
                        children: [
                          _buildOperatingCitySection(),

                          const SizedBox(height: 24),
                          _buildExtraFareSection(),
                          const SizedBox(height: 24),
                          _buildTaxSection(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Right side - Preview
                    Expanded(
                      flex: 9,
                      child: Column(
                        children: [
                          _buildDescription(),
                          const SizedBox(height: 24),
                          _RateCardPreviewPanel(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(color: AppColors.divider),
                const SizedBox(height: 20),
                _buildFooter(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Footer
        //_buildFooter(),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey.shade200)),
      ),
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.base.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label, // 👈 Important
        indicatorWeight: 3,
        labelPadding: EdgeInsets.symmetric(horizontal: 16),
        dividerColor: AppColors.transparent,
        tabs: const [
          Tab(text: 'Cab'),
          Tab(text: 'Auto Rickshaw'),
          Tab(text: 'Bike Taxi'),
        ],
      ),
    );
  }

  Widget _buildOperatingCitySection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OPERATING CITY',
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Chennai, TN',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text('Distance Fare', style: AppTypography.h3.copyWith()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  label: 'Base Fare (Fixed)',
                  value: '25',
                  prefix: '₹',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distance Range (KM)',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildInputBox(value: '0')),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'to',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: _buildInputBox(value: '999')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtraFareSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              // const Icon(
              //   Icons.add_circle_outline_rounded,
              //   color: AppColors.primary,
              //   size: 20,
              // ),
              // const SizedBox(width: 8),
              Text(
                'Extra Fare Configuration',
                style: AppTypography.h3_5.copyWith(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  label: 'Long Pickup Fare (per km)',
                  value: '5',
                  prefix: '₹',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildInputField(
                  label: 'Max Pickup Amount',
                  value: '50',
                  prefix: '₹',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cancellation Fare Range',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildInputBox(value: '10', prefix: '₹'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'to',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildInputBox(value: '30', prefix: '₹'),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(color: AppColors.divider),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.nightlight_round_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Night Fare Surcharge',
                    style: AppTypography.h3_5.copyWith(),
                  ),
                  Text(
                    'Apply multiplier for late night rides',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Switch(
                value: _nightSurchargeEnabled,
                onChanged: (val) =>
                    setState(() => _nightSurchargeEnabled = val),
                activeColor: Colors.white,
                activeTrackColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildInputField(
                  label: 'ACTIVE TIME RANGE',
                  value: '10:00 PM → 06:00 AM',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: _buildInputField(
                  label: 'MULTIPLIER PERCENTAGE',
                  value: '30',
                  suffix: '%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildNightFareSection() {
  //   return _buildSectionCard(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             const Icon(
  //               Icons.nightlight_round_outlined,
  //               color: AppColors.primary,
  //               size: 20,
  //             ),
  //             const SizedBox(width: 8),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Night Fare Surcharge',
  //                   style: AppTypography.h3.copyWith(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Apply multiplier for late night rides',
  //                   style: AppTypography.base.copyWith(
  //                     color: AppColors.textSecondary,
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const Spacer(),
  //             Switch(
  //               value: _nightSurchargeEnabled,
  //               onChanged: (val) =>
  //                   setState(() => _nightSurchargeEnabled = val),
  //               activeColor: Colors.white,
  //               activeTrackColor: AppColors.primary,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 3,
  //               child: _buildInputField(
  //                 label: 'ACTIVE TIME RANGE',
  //                 value: '10:00 PM → 06:00 AM',
  //               ),
  //             ),
  //             const SizedBox(width: 24),
  //             Expanded(
  //               flex: 2,
  //               child: _buildInputField(
  //                 label: 'MULTIPLIER PERCENTAGE',
  //                 value: '30',
  //                 suffix: '%',
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTaxSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_balance_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Commission & Taxation',
                style: AppTypography.h3_5.copyWith(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  label: 'Platform Comm. (%)',
                  value: '20',
                  suffix: '%',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildInputField(
                  label: 'GST (to Govt)',
                  value: '5',
                  suffix: '%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: AppTypography.h3_5),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            height: 100, // 👈 important for textarea look
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC), // 👈 light grey background
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey.shade200),
            ),
            child: Text(
              "The com....",
              style: AppTypography.bodyRegular.copyWith(
                color: Colors.grey, // 👈 hint-like color
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        _buildInputBox(value: value, prefix: prefix, suffix: suffix),
      ],
    );
  }

  Widget _buildInputBox({
    required String value,
    String? prefix,
    String? suffix,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Row(
        children: [
          if (prefix != null) ...[
            Text(
              prefix,
              style: AppTypography.bodyRegular.copyWith(color: Colors.grey),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            value,
            style: AppTypography.bodyRegular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (suffix != null)
            Text(
              suffix,
              style: AppTypography.bodyRegular.copyWith(color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: AppColors.white),
            ),
          ),
          child: Text(
            'Reset Changes',
            style: AppTypography.bodyRegular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            'Update Rate',
            style: AppTypography.bodyRegular.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}

class _RateCardPreviewPanel extends StatelessWidget {
  const _RateCardPreviewPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Green Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate Card Preview',
                  style: AppTypography.h3.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Simulated for a 5 KM ride at 11:30 PM',
                  style: AppTypography.bodyRegular.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Map Placeholder
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'LIVE PREVIEW MAP',
                        style: AppTypography.base.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Fare Details
                _buildFareRow('Base Fare (0-2 KM)', '₹ 25.00'),
                _buildFareRow('Long Pickup Fare (3 KM extra)', '₹ 36.00'),
                _buildFareRow(
                  'Night Surcharge (+30%)',
                  '₹ 18.00',
                  isGreen: true,
                ),
                _buildFareRow('Platform Fee', '₹ 20.00'),
                _buildFareRow('GST', '₹ 10.00'),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: AppColors.divider),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estimated Total', style: AppTypography.h3.copyWith()),
                    Text(
                      '₹ 109.00',
                      style: AppTypography.h3.copyWith(
                        color: AppColors.primary,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Earning Split
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'EARNING SPLIT',
                            style: AppTypography.bodyRegular.copyWith(
                              color: AppColors.textSecondary,
                              
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSplitRow(
                        'Driver Earnings',
                        '₹ 79.00',
                        isEarn: true,
                      ),
                      const SizedBox(height: 8),
                      _buildSplitRow('Platform Fee', '₹ 20.00'),
                      const SizedBox(height: 8),
                      _buildSplitRow('GST', '₹ 10.00'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply to All Cities',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyLarge.copyWith(
              color: isGreen ? AppColors.primary : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitRow(String label, String value, {bool isEarn = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyRegular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyRegular.copyWith(
            color: isEarn ? AppColors.primary : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
