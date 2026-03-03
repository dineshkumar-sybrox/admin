import 'package:flutter/material.dart';

class PaymentStatCards extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onCardTapped;

  const PaymentStatCards({
    super.key,
    this.selectedIndex = 0,
    this.onCardTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        if (isNarrow) {
          return Column(
            children: [
              _PaymentStatCard(
                title: 'TOTAL PAYMENT',
                value: '₹13.6k',
                trend: '+5.2%',
                isTrendUp: true,
                isSelected: selectedIndex == 0,
                onTap: () => onCardTapped?.call(0),
              ),
              const SizedBox(height: 12),
              _PaymentStatCard(
                title: 'CAB PAYMENT',
                value: '₹8.2k',
                trend: '-2.1%',
                isTrendUp: false,
                isSelected: selectedIndex == 1,
                onTap: () => onCardTapped?.call(1),
              ),
              const SizedBox(height: 12),
              _PaymentStatCard(
                title: 'BIKE/SCOOTER PAYMENT',
                value: '₹1.2k',
                trend: '+12%',
                isTrendUp: true,
                isSelected: selectedIndex == 2,
                onTap: () => onCardTapped?.call(2),
              ),
              const SizedBox(height: 12),
              _PaymentStatCard(
                title: 'AUTO PAYMENT',
                value: '₹4.2k',
                trend: '-0.5%',
                isTrendUp: false,
                isSelected: selectedIndex == 3,
                onTap: () => onCardTapped?.call(3),
              ),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
              child: _PaymentStatCard(
                title: 'TOTAL PAYMENT',
                value: '₹13.6k',
                trend: '+5.2%',
                isTrendUp: true,
                isSelected: selectedIndex == 0,
                onTap: () => onCardTapped?.call(0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PaymentStatCard(
                title: 'CAB PAYMENT',
                value: '₹8.2k',
                trend: '-2.1%',
                isTrendUp: false,
                isSelected: selectedIndex == 1,
                onTap: () => onCardTapped?.call(1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PaymentStatCard(
                title: 'BIKE/SCOOTER PAYMENT',
                value: '₹1.2k',
                trend: '+12%',
                isTrendUp: true,
                isSelected: selectedIndex == 2,
                onTap: () => onCardTapped?.call(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PaymentStatCard(
                title: 'AUTO PAYMENT',
                value: '₹4.2k',
                trend: '-0.5%',
                isTrendUp: false,
                isSelected: selectedIndex == 3,
                onTap: () => onCardTapped?.call(3),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PaymentStatCard extends StatefulWidget {
  final String title;
  final String value;
  final String trend;
  final bool isTrendUp;
  final bool isSelected;
  final VoidCallback? onTap;

  const _PaymentStatCard({
    required this.title,
    required this.value,
    required this.trend,
    this.isTrendUp = true,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<_PaymentStatCard> createState() => _PaymentStatCardState();
}

class _PaymentStatCardState extends State<_PaymentStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF00A86B);
    const borderColor = Color(0xFFE6EAF0);
    const trendColor =
        accentColor; // In the design, all trends are green styled

    final isClickable = widget.onTap != null;

    return MouseRegion(
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: _isHovered && isClickable
                    ? accentColor.withValues(alpha: 0.13)
                    : Colors.black.withValues(alpha: 0.02),
                blurRadius: _isHovered && isClickable ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.isSelected)
                    Container(width: 3, color: accentColor),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8A97A8),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                widget.value,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1D1F),
                                  height: 1.0,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                widget.isTrendUp
                                    ? Icons.trending_up_rounded
                                    : Icons
                                          .trending_up_rounded, // Assuming downwards variant is wavy down but we can use wavy up for everything or wavy down depending on real design. Looks like green wavy symbol is used matching `show_chart_rounded` or `trending_up` universally!
                                size: 18,
                                color: trendColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.trend,
                                style: const TextStyle(
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
