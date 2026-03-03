import 'package:flutter/material.dart';

class ReasonsForCancellation extends StatefulWidget {
  const ReasonsForCancellation({super.key});

  @override
  State<ReasonsForCancellation> createState() => _ReasonsForCancellationState();
}

class _ReasonsForCancellationState extends State<ReasonsForCancellation> {
  String _selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF0F1F3)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reasons for Cancellation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Breakdown of user-reported reasons',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9EA5AD),
                    ),
                  ),
                ],
              ),
              _buildDropdown(),
            ],
          ),
          const SizedBox(height: 48),
          _buildReasonBar('Driver No Show', 0.53, const Color(0xFF00C46B)),
          const SizedBox(height: 32),
          _buildReasonBar(
            'Wrong Pickup Location',
            0.35,
            const Color(0xFF19B277),
          ),
          const SizedBox(height: 32),
          _buildReasonBar('Long Wait Time', 0.18, const Color(0xFF8CE0B9)),
          const SizedBox(height: 32),
          _buildReasonBar('Technical Issue', 0.07, const Color(0xFFB1E7CE)),
          const SizedBox(height: 32),
          _buildReasonBar('Other Reasons', 0.05, const Color(0xFFD8F1EB)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReasonBar(String title, double progress, Color color) {
    final int percentage = (progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D1F),
              ),
            ),
            if (percentage < 30) // if small show percentage top right
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1D1F),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6F9),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFEFEFEF)),
        ),
        color: Colors.white,
        elevation: 6,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedFilter,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1D1F),
              ),
            ),
            const SizedBox(width: 32),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Color(0xFF6F767E),
            ),
          ],
        ),
        onSelected: (val) {
          setState(() {
            _selectedFilter = val;
          });
        },
        itemBuilder: (context) => [
          _buildPopupItem('Today', _selectedFilter == 'Today'),
          _buildPopupItem('Last 15 Days', _selectedFilter == 'Last 15 Days'),
          _buildPopupItem('Last 30 Days', _selectedFilter == 'Last 30 Days'),
          _buildPopupItem('Last 6 Months', _selectedFilter == 'Last 6 Months'),
          _buildPopupItem('Last 1 Year', _selectedFilter == 'Last 1 Year'),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
    return PopupMenuItem<String>(
      value: text,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isSelected ? const Color(0xFFF4Fdf8) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF00A86B),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
