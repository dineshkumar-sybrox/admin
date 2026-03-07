import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ComplianceScoreDetailsScreen extends StatelessWidget {
  const ComplianceScoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Complaiance Score',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const _ScoreOverviewCard(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 12, child: _ComplianceBreakdownCard()),
                const SizedBox(width: 24),
                const Expanded(flex: 8, child: _RejectionReasonsCard()),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 12, child: _RegionalHeatmapCard()),
                const SizedBox(width: 24),
                const Expanded(flex: 8, child: _TopCitiesCard()),
              ],
            ),
            const SizedBox(height: 32),
            const _RecentLogsCard(),
          ],
        ),
      ),
    );
  }
}

class _ScoreOverviewCard extends StatelessWidget {
  const _ScoreOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TAMIL NADU COMPLIANCE SCORE',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '97',
                      style: AppTypography.h1.copyWith(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '%',
                      style: AppTypography.h3.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F9F3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+2.4%',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: AppTypography.bodyRegular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Current compliance status is rated as ',
                      ),
                      TextSpan(
                        text: 'HIGH',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '. 984 drivers verified in the last 24 hours.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 7,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 2.8),
                            FlSpot(2, 3.5),
                            FlSpot(3, 2.5),
                            FlSpot(4, 4),
                            FlSpot(5, 3.2),
                            FlSpot(6, 4.5),
                            FlSpot(7, 4),
                          ],
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '30 DAYS AGO',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'TODAY',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplianceBreakdownCard extends StatelessWidget {
  const _ComplianceBreakdownCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Breakdown by Document', style: AppTypography.h3),
          const SizedBox(height: 4),
          Text(
            'Review status across all mandatory documentation',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          _buildBreakdownItem('Driving License', 98, AppColors.primary),
          const SizedBox(height: 24),
          _buildBreakdownItem(
            'Registration Certificate (RC)',
            94,
            AppColors.primary,
          ),
          const SizedBox(height: 24),
          _buildBreakdownItem('Aadhar', 82, const Color(0xFFF59E0B)),
          const SizedBox(height: 24),
          _buildBreakdownItem('PAN Card Verification', 99, AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, int pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '$pct%',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct / 100,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class _RejectionReasonsCard extends StatelessWidget {
  const _RejectionReasonsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Document Rejection Reasons', style: AppTypography.h3),
          const SizedBox(height: 32),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                sections: [
                  PieChartSectionData(
                    color: const Color(0xFFEF4444),
                    value: 75,
                    title: '',
                    radius: 25,
                  ),
                  PieChartSectionData(
                    color: const Color(0xFFF59E0B),
                    value: 15,
                    title: '',
                    radius: 25,
                  ),
                  PieChartSectionData(
                    color: const Color(0xFF64748B),
                    value: 10,
                    title: '',
                    radius: 25,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildLegendItem('Expired Document', '75%', const Color(0xFFEF4444)),
          const SizedBox(height: 12),
          _buildLegendItem('Blurry Image', '15%', const Color(0xFFF59E0B)),
          const SizedBox(height: 12),
          _buildLegendItem(
            'Incorrect Document',
            '10%',
            const Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String pct, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          pct,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _RegionalHeatmapCard extends StatelessWidget {
  const _RegionalHeatmapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Compliance Heatmap', style: AppTypography.h3),
          const SizedBox(height: 24),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=2074&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCitiesCard extends StatelessWidget {
  const _TopCitiesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Non- Compliance Cities', style: AppTypography.h3),
          const SizedBox(height: 24),
          _buildCityItem(
            '01',
            'Chennai',
            'Avg Score : 68%',
            'High Risk',
            const Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          _buildCityItem(
            '02',
            'Madurai',
            'Avg Score : 72%',
            'Medium Risk',
            const Color(0xFFF59E0B),
          ),
          const SizedBox(height: 16),
          _buildCityItem(
            '03',
            'Trichy',
            'Avg Score : 75%',
            'Medium Risk',
            const Color(0xFFF59E0B),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'VIEW ALL LOCATIONS',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityItem(
    String rank,
    String city,
    String score,
    String risk,
    Color riskColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            rank,
            style: AppTypography.h2.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.3),
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  score,
                  style: AppTypography.bodySmall.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                risk,
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(4, (i) {
                  return Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < (risk == 'High Risk' ? 3 : 2)
                          ? riskColor
                          : Colors.grey.shade300,
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentLogsCard extends StatelessWidget {
  const _RecentLogsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Text('Recent Compliance Logs', style: AppTypography.h3),
                const Spacer(),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Ticket ID or Name...',
                      hintStyle: const TextStyle(fontSize: 13),
                      prefixIcon: const Icon(Icons.search, size: 18),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEFEFEF)),
                  ),
                  child: Row(
                    children: [
                      Text('All Categories', style: AppTypography.bodySmall),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildLogsTable(context),
          const Divider(height: 1),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildLogsTable(BuildContext context) {
    return DataTable(
      headingRowHeight: 60,
      dataRowMaxHeight: 80,
      dataRowMinHeight: 80,
      columns: const [
        DataColumn(label: Text('DOCUMENT ID')),
        DataColumn(label: Text('DRIVER NAME')),
        DataColumn(label: Text('DOCUMENTS')),
        DataColumn(label: Text('CATEGORY')),
        DataColumn(label: Text('STATUS')),
        DataColumn(label: Text('CLOSED DATE & TIME')),
        DataColumn(label: Text('ACTION')),
      ],
      rows: [
        _buildDataRow(
          id: '#DOC-8801',
          driverName: 'Vikram Seth',
          documents: 'DRIVING LICENSE',
          category: 'REJECTED',
          status: 'Rejected',
          dateTime: '04 Nov 2025\n05:20 PM',
        ),
        _buildDataRow(
          id: '#DOC-8798',
          driverName: 'Anita Mehra',
          documents: 'ALL DOCUMENTS',
          category: 'VERIFIED',
          status: 'Approved',
          dateTime: '04 Nov 2025\n04:15 PM',
        ),
      ],
    );
  }

  DataRow _buildDataRow({
    required String id,
    required String driverName,
    required String documents,
    required String category,
    required String status,
    required String dateTime,
  }) {
    final bool isRejected = status == 'Rejected';
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
          Text(driverName, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          Text(
            documents,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isRejected
                  ? const Color(0xFFFEF2F2)
                  : const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isRejected
                    ? const Color(0xFFB91C1C)
                    : const Color(0xFF15803D),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRejected ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  color: isRejected ? AppColors.error : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            dateTime,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ),
        const DataCell(
          Icon(Icons.visibility_outlined, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 1-10 of 4,842 documents',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6F767E),
            ),
          ),
          Row(
            children: [
              _buildPageIcon(Icons.chevron_left),
              const SizedBox(width: 8),
              _buildPageNumber('1', isActive: true),
              const SizedBox(width: 8),
              _buildPageNumber('2', isActive: false),
              const SizedBox(width: 8),
              _buildPageNumber('3', isActive: false),
              const SizedBox(width: 8),
              _buildPageIcon(Icons.chevron_right),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber(String n, {bool isActive = false}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: isActive ? null : Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Center(
        child: Text(
          n,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildPageIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Center(
        child: Icon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }
}
