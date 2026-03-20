import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/drivers_management_cubit.dart';
import '../cubit/drivers_management_state.dart';

class LeaderboardTable extends StatelessWidget {
  const LeaderboardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriversManagementState>(
      builder: (context, state) {
        if (state.isLoading) return const SizedBox.shrink();

        final displayDrivers = state.filteredDrivers;

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width > 1200
                      ? MediaQuery.of(context).size.width - 320
                      : 1000,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFF3F4F6)
                    )
                  ),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.white),
                    headingTextStyle: const TextStyle(
                      color: Color(0xFF8E9BAB),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    dataTextStyle: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    horizontalMargin: 24,
                    columnSpacing: 24,
                    headingRowHeight: 56,
                    dataRowMaxHeight: 72,
                    dataRowMinHeight: 72,
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFF3F4F6),
                        width: 1,
                      ),
                    ),
                    columns: const [
                      DataColumn(label: Text('RANK')),
                      DataColumn(label: Text('DRIVER')),
                      DataColumn(label: Text('TOTAL RIDES\n TODAY')),
                      DataColumn(label: Text('ONLINE\n HOURS')),
                      DataColumn(label: Text('ACCEPTANCE\n RATE')),
                      DataColumn(label: Text('TOTAL\n EARNINGS (₹)')),
                      DataColumn(label: Text('TREND (24H)')),
                    ],
                    rows: displayDrivers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final driver = entry.value;
                      final rank = index + 1;
                  
                      return DataRow(
                        cells: [
                          DataCell(_RankBadge(rank: rank)),
                          DataCell(_DriverInfo(driver: driver)),
                          DataCell(
                            Text(
                              '${driver.ridesToday ?? 0} Rides',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${driver.onlineHours ?? 0} hrs',
                              style: const TextStyle(
                                color: Color(0xFF6F767E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(
                            _AcceptanceRate(rate: driver.acceptanceRate ?? 0),
                          ),
                          DataCell(
                            Text(
                              '₹${(driver.earnings ?? 0).toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF00A86B),
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          DataCell(_TrendSparkline(data: driver.trendData ?? [])),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    Color? bgColor;
    Color textColor = const Color(0xFF8E9BAB);

    if (rank == 1) {
      bgColor = const Color(0xFF00A86B);
      textColor = Colors.white;
    } else if (rank == 2) {
      bgColor = const Color(0xFF8E9BAB).withValues(alpha: 0.6);
      textColor = Colors.white;
    } else if (rank == 3) {
      bgColor = const Color(0xFFFF9F43).withValues(alpha: 0.8);
      textColor = Colors.white;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _DriverInfo extends StatelessWidget {
  final Driver driver;
  const _DriverInfo({required this.driver});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(driver.avatarUrl),
          backgroundColor: const Color(0xFFF4F6F9),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              driver.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D1F),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${driver.city.toUpperCase()} • ${driver.vehicleType.toUpperCase()}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8E9BAB),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AcceptanceRate extends StatelessWidget {
  final int rate;
  const _AcceptanceRate({required this.rate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: rate / 100,
                backgroundColor: const Color(0xFFF4F6F9),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00A86B),
                ),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$rate%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1D1F),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendSparkline extends StatelessWidget {
  final List<double> data;
  const _TrendSparkline({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 24,
      child: CustomPaint(painter: _SparklinePainter(data: data)),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  _SparklinePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = const Color(0xFF00A86B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
