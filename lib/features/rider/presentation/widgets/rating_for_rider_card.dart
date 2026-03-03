import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RatingForRiderCard extends StatelessWidget {
  const RatingForRiderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rating for Rider',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Customer\'s feedback profile for all lifetime rides',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '4.82',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        height: 1.0,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        Icon(Icons.star_half, size: 12, color: Colors.amber),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildRatingRow('5 STARS', 116, 142, Colors.yellowAccent),
            const SizedBox(height: 12),
            _buildRatingRow('4 STARS', 17, 142, Colors.yellow[300]!),
            const SizedBox(height: 12),
            _buildRatingRow('3 STARS', 5, 142, Colors.amber[200]!),
            const SizedBox(height: 12),
            _buildRatingRow('2 STARS', 3, 142, Colors.orange[300]!),
            const SizedBox(height: 12),
            _buildRatingRow('1 STAR', 1, 142, AppColors.error),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(
    String label,
    int count,
    int totalCount,
    Color progressColor,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: count / totalCount,
              backgroundColor: const Color(0xFFF1F5F9), // Very light cool grey
              color: progressColor,
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 24,
          child: Text(
            count.toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
