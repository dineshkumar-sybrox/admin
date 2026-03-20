import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';

class CancellationStatCards extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onCardTapped;

  final String totalValue;
  final String totalTrend;
  final bool totalTrendUp;
  final String riderValue;
  final String riderTrend;
  final bool riderTrendUp;
  final String driverValue;
  final String driverTrend;
  final bool driverTrendUp;

  CancellationStatCards({
    super.key,
    this.selectedIndex = 0,
    this.onCardTapped,
    this.totalValue = '9.4k',
    this.totalTrend = '+5.2%',
    this.totalTrendUp = true,
    this.riderValue = '8.2k',
    this.riderTrend = '-2.1%',
    this.riderTrendUp = false,
    this.driverValue = '1.2K',
    this.driverTrend = '+12%',
    this.driverTrendUp = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        if (isNarrow) {
          return Column(
            children: [
              _CancellationStatCard(
                title: 'TOTAL CANCELLATION',
                value: totalValue,
                trend: totalTrend,
                isTrendUp: totalTrendUp,
                isSelected: selectedIndex == 0,
                onTap: () => onCardTapped?.call(0),
              ),
              SizedBox(height: 12),
              _CancellationStatCard(
                title: 'RIDER CANCELLATION',
                value: riderValue,
                trend: riderTrend,
                isTrendUp: riderTrendUp,
                isSelected: selectedIndex == 1,
                onTap: () => onCardTapped?.call(1),
              ),
              SizedBox(height: 12),
              _CancellationStatCard(
                title: 'DRIVER CANCELLATION',
                value: driverValue,
                trend: driverTrend,
                isTrendUp: driverTrendUp,
                isSelected: selectedIndex == 2,
                onTap: () => onCardTapped?.call(2),
              ),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              child: _CancellationStatCard(
                title: 'TOTAL CANCELLATION',
                value: totalValue,
                trend: totalTrend,
                isTrendUp: totalTrendUp,
                isSelected: selectedIndex == 0,
                onTap: () => onCardTapped?.call(0),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _CancellationStatCard(
                title: 'RIDER CANCELLATION',
                value: riderValue,
                trend: riderTrend,
                isTrendUp: riderTrendUp,
                isSelected: selectedIndex == 1,
                onTap: () => onCardTapped?.call(1),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _CancellationStatCard(
                title: 'DRIVER CANCELLATION',
                value: driverValue,
                trend: driverTrend,
                isTrendUp: driverTrendUp,
                isSelected: selectedIndex == 2,
                onTap: () => onCardTapped?.call(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CancellationStatCard extends StatefulWidget {
  final String title;
  final String value;
  final String trend;
  final bool isTrendUp;
  final bool isSelected;
  final VoidCallback? onTap;

  const _CancellationStatCard({
    required this.title,
    required this.value,
    required this.trend,
    this.isTrendUp = true,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<_CancellationStatCard> createState() => _CancellationStatCardState();
}

class _CancellationStatCardState extends State<_CancellationStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const accentColor = AppColors.cFF00A86B;
    const borderColor = AppColors.cFFE6EAF0;
    const trendColorRed = AppColors.cFFFF4757; // Red color for the trend
    const trendColorGreen = accentColor;

    final trendColor = widget.isTrendUp ? trendColorGreen : trendColorRed;
    final isClickable = widget.onTap != null;

    return MouseRegion(
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(
            left: BorderSide(
              color: widget.isSelected
                  ? AppColors.primary
                  : AppColors.transparent, // 👈 Hide when not selected
              width: 4, // Thickness of left border
            ),
          ),
            boxShadow: [
              BoxShadow(
                color: _isHovered && isClickable
                    ? accentColor.withValues(alpha: 0.13)
                    : AppColors.black.withValues(alpha: 0.02),
                blurRadius: _isHovered && isClickable ? 20 : 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              11,
            ), // Slightly less than 12 for border
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // if (widget.isSelected)
                  //   Container(width: 3, color: AppColors.primary),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: AppTypography.base.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.cFF8A97A8,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                widget.value,
                                style: AppTypography.base.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.cFF1A1D1F,
                                  height: 1.0,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(width: 12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons
                                        .show_chart_rounded, // Assuming downwards variant or visually similar. StatCardsRow uses trending_down_rounded. Let's use trending_down_rounded
                                    // Icons.trending_down_rounded,
                                  ),
                                  // Wait, let's just use trending_down_rounded for matching.
                                ],
                              ),
                              Icon(
                                widget.isTrendUp
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                size: 18,
                                color: trendColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.trend,
                                style: AppTypography.base.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: trendColor,
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
            ),
          ),
        ),
      ),
    );
  }
}


