import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drivers_management_cubit.dart';

class ActiveDriversTable extends StatelessWidget {
  const ActiveDriversTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriversManagementCubit, DriversManagementState>(
      builder: (context, state) {
        if (state.isLoading) return const SizedBox.shrink();

        final displayDrivers = state.filteredDrivers;

        return Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width > 1200
                    ? MediaQuery.of(context).size.width - 320
                    : 1100,
              ),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Colors.white),
                headingTextStyle: const TextStyle(
                  color: Color(0xFF8E9BAB),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
                dataTextStyle: const TextStyle(
                  color: Color(0xFF1A1D1F),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                horizontalMargin: 24,
                columnSpacing: 24,
                headingRowHeight: 64,
                dataRowMaxHeight: 92,
                dataRowMinHeight: 92,
                showCheckboxColumn: false,
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: Color(0xFFF4F6F9),
                    width: 1,
                  ),
                ),
                columns: const [
                  DataColumn(label: Text('RANK')),
                  DataColumn(label: Text('DRIVER')),
                  DataColumn(label: Text('TOTAL\nRIDES\nTODAY')),
                  DataColumn(label: Text('ONLINE\nHOURS')),
                  DataColumn(label: Text('ACCEPTANCE\nRATE')),
                  DataColumn(label: Text('TOTAL\nEARNINGS (₹)')),
                  DataColumn(label: Text('TREND (24H)')),
                ],
                rows: displayDrivers.map((driver) {
                  return DataRow(
                    cells: [
                      DataCell(_RankBadge(rank: driver.rank ?? 0)),
                      DataCell(_DriverInfo(driver: driver)),
                      DataCell(
                        Text(
                          '${driver.ridesToday ?? 0} Rides',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1D1F),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${driver.onlineHours ?? 0}\nhrs',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6F767E),
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
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF00A86B),
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
    Color bgColor;
    if (rank == 1) {
      bgColor = const Color(0xFF00A86B);
    } else if (rank == 2) {
      bgColor = const Color(0xFF8E9BAB).withOpacity(0.6);
    } else if (rank == 3) {
      bgColor = const Color(0xFFFF9F43).withOpacity(0.8);
    } else {
      bgColor = Colors.transparent;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          rank == 0 ? '-' : rank.toString(),
          style: TextStyle(
            color: rank <= 3 && rank > 0
                ? Colors.white
                : const Color(0xFF8E9BAB),
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
              '${driver.city} • ${driver.vehicleType}',
              style: const TextStyle(
                fontSize: 11,
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
      width: 120,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: rate / 100,
                backgroundColor: const Color(0xFFF4F6F9),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00A86B),
                ),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$rate%',
            style: const TextStyle(
              fontSize: 13,
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
      width: 80,
      height: 32,
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

    // Create points
    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Curve points
        final prevX = (i - 1) * stepX;
        final prevY = size.height - (data[i - 1] * size.height);
        final controlX1 = prevX + (x - prevX) / 2;
        final controlX2 = x - (x - prevX) / 2;
        path.cubicTo(controlX1, prevY, controlX2, y, x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// _VehicleBadge removed as it's no longer used in the new leaderboard UI
