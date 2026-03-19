import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class IncentiveDetailScreen extends StatelessWidget {
  IncentiveDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allRows = _incentiveRows;
    return BlocProvider(
      create: (context) => IncentiveDetailCubit(),
      child: BlocBuilder<IncentiveDetailCubit, IncentiveDetailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatCardsSection(selectedTab: state.selectedTab),
                  SizedBox(height: 32),
                  Container(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _ActionSection(),
                          SizedBox(height: 24),
                          _DriverListTable(
                            rows: allRows,
                            selectedTab: state.selectedTab,
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatCardsSection extends StatelessWidget {
  final IncentiveTab selectedTab;

  const _StatCardsSection({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => context.read<IncentiveDetailCubit>().selectTab(
                IncentiveTab.total,
              ),
              child: _StatCard(
                title: 'TOTAL PARTICIPATING',
                value: '1,248',
                subtitle: 'Drivers',
                isPrimary: selectedTab == IncentiveTab.total,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => context.read<IncentiveDetailCubit>().selectTab(
                IncentiveTab.completed,
              ),
              child: _StatCard(
                title: 'COMPLETED TARGET',
                value: '848',
                subtitle: 'Target Achieved',
                isPrimary: selectedTab == IncentiveTab.completed,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => context.read<IncentiveDetailCubit>().selectTab(
                IncentiveTab.pending,
              ),
              child: _StatCard(
                title: 'PENDING PROGRESS',
                value: '400',
                subtitle: 'Average 4 rides remaining',
                isPrimary: selectedTab == IncentiveTab.pending,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool isPrimary;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isPrimary
                ? AppColors.primary
                : AppColors.transparent, // Hide when not selected
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.bodyRegular.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        value,
                        style: AppTypography.h1.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionSection extends StatefulWidget {
  const _ActionSection();

  @override
  State<_ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<_ActionSection> {
  String _selectedFilter = 'ALL';
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 350,
              height: 40,
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search Document ID or Driver Name...',
                  hintStyle: AppTypography.base.copyWith(fontSize: 13),
                  prefixIcon: Icon(Icons.search, size: 18),
                  filled: true,
                  fillColor: AppColors.cFFF9FAFB,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.cFFEFEFEF),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.cFFEFEFEF),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            // Container(
            //   width: 300,
            //   height: 48,
            //   decoration: BoxDecoration(
            //     color: AppColors.white,
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: AppColors.grey.shade300),
            //   ),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: 'Search by ID or Driver...',
            //       hintStyle: AppTypography.bodyRegular.copyWith(
            //         color: AppColors.textSecondary,
            //       ),
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: AppColors.textSecondary,
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: 16,
            //         vertical: 14,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(width: 16),
            // _buildDropdownFilter(),
            SizedBox(width: 16),
            _buildStatusDropdownFilter(),
          ],
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cFF00A86B,
              foregroundColor: AppColors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: Text(
              'Export CSV',
              style: AppTypography.base.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.cFFEFEFEF),
        ),
        color: AppColors.white,
        elevation: 6,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedFilter,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(width: 32),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.cFF6F767E,
            ),
          ],
        ),
        onSelected: (val) {
          setState(() {
            _selectedFilter = val;
          });
        },
        itemBuilder: (context) => [
          _buildPopupItem('ALL', _selectedFilter == 'ALL'),
          _buildPopupItem('COMPLETED', _selectedFilter == 'COMPLETED'),
          _buildPopupItem('PENDING', _selectedFilter == 'PENDING'),
        ],
      ),
    );
  }

  Widget _buildStatusDropdownFilter() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cFFEFEFEF),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.cFFEFEFEF),
        ),
        color: AppColors.white,
        elevation: 6,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedFilter,
              style: AppTypography.base.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.cFF1A1D1F,
              ),
            ),
            SizedBox(width: 32),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.cFF6F767E,
            ),
          ],
        ),
        onSelected: (val) {
          setState(() {
            _selectedFilter = val;
          });
        },
        itemBuilder: (context) => [
          _buildPopupItem('ALL', _selectedFilter == 'ALL'),
          _buildPopupItem('COMPLETED', _selectedFilter == 'COMPLETED'),
          _buildPopupItem('PENDING', _selectedFilter == 'PENDING'),
        ],
      ),
    );
  }
}

PopupMenuItem<String> _buildPopupItem(String text, bool isSelected) {
  return PopupMenuItem<String>(
    value: text,
    height: 44,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      color: isSelected ? AppColors.cFFF4FDF8 : AppColors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTypography.base.copyWith(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: AppColors.cFF1A1D1F,
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.cFF00A86B,
              size: 18,
            ),
        ],
      ),
    ),
  );
}

class _DriverListTable extends StatelessWidget {
  final List<_IncentiveDriverRow> rows;
  final IncentiveTab selectedTab;

  const _DriverListTable({required this.rows, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final filteredRows = _filterRows(rows, selectedTab);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cFFF9FAFB,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(color: AppColors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'DRIVER ID',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'DRIVER NAME',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'ACHIEVEMENT BADGE',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'RIDE COMPLETION',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'PROGRESS BAR',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'STATUS',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Table Rows
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (final row in filteredRows)
                _buildDriverRow(
                  id: row.id,
                  name: row.name,
                  tier: row.tier,
                  iconData: row.iconData,
                  completionMain: row.completionMain,
                  completionSub: row.completionSub,
                  progressName: row.progressName,
                  progressPct: row.progressPct,
                  progressColor: row.progressColor,
                  status: row.status,
                  statusColor: row.statusColor,
                  statusBgColor: row.statusBgColor,
                ),
            ],
          ),
          // Pagination Footer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${filteredRows.length} of ${rows.length}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: AppColors.grey.shade400,
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '2',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '3',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.chevron_right, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverRow({
    required String id,
    required String name,
    required String tier,
    required IconData iconData,
    required String completionMain,
    required String completionSub,
    required String progressName,
    required int progressPct,
    required Color progressColor,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'ID: $id',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  tier,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 8),
                Icon(iconData, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  completionMain,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  completionSub,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        progressName,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '$progressPct%',
                        style: AppTypography.bodySmall.copyWith(
                          color: progressColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Container(
                            height: 6,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: AppColors.cFFF3F4F6,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Container(
                            height: 6,
                            width: constraints.maxWidth * (progressPct / 100),
                            decoration: BoxDecoration(
                              color: progressColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: AppTypography.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _completedStatus = 'COMPLETED';
const String _pendingStatus = 'PENDING';

enum IncentiveTab { total, completed, pending }

class IncentiveDetailState {
  final IncentiveTab selectedTab;

  const IncentiveDetailState({required this.selectedTab});

  IncentiveDetailState copyWith({IncentiveTab? selectedTab}) {
    return IncentiveDetailState(selectedTab: selectedTab ?? this.selectedTab);
  }
}

class IncentiveDetailCubit extends Cubit<IncentiveDetailState> {
  IncentiveDetailCubit()
    : super(const IncentiveDetailState(selectedTab: IncentiveTab.total));

  void selectTab(IncentiveTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}

class _IncentiveDriverRow {
  final String id;
  final String name;
  final String tier;
  final IconData iconData;
  final String completionMain;
  final String completionSub;
  final String progressName;
  final int progressPct;
  final Color progressColor;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  const _IncentiveDriverRow({
    required this.id,
    required this.name,
    required this.tier,
    required this.iconData,
    required this.completionMain,
    required this.completionSub,
    required this.progressName,
    required this.progressPct,
    required this.progressColor,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });
}

List<_IncentiveDriverRow> _filterRows(
  List<_IncentiveDriverRow> rows,
  IncentiveTab selectedTab,
) {
  if (selectedTab == IncentiveTab.completed) {
    return rows.where((r) => r.status == _completedStatus).toList();
  }
  if (selectedTab == IncentiveTab.pending) {
    return rows.where((r) => r.status == _pendingStatus).toList();
  }
  return rows;
}

const List<_IncentiveDriverRow> _incentiveRows = [
  _IncentiveDriverRow(
    id: 'DRV-00281',
    name: 'Arjun\nSharma',
    tier: 'TIER 3',
    iconData: Icons.diamond_outlined,
    completionMain: '12 / 12',
    completionSub: 'GOAL REACHED',
    progressName: 'Tier 3 (Platinum)',
    progressPct: 100,
    progressColor: AppColors.primary,
    status: _completedStatus,
    statusColor: AppColors.primary,
    statusBgColor: AppColors.cFFE8F5E9,
  ),
  _IncentiveDriverRow(
    id: 'DRV-00280',
    name: 'Arun\nSharma',
    tier: 'TIER 2',
    iconData: Icons.emoji_events_outlined,
    completionMain: '08 / 12',
    completionSub: '5 LEFT TO MILESTONE',
    progressName: 'Tier 3 (Gold)',
    progressPct: 60,
    progressColor: AppColors.amber,
    status: _pendingStatus,
    statusColor: AppColors.amber,
    statusBgColor: AppColors.cFFFFF8E1,
  ),
  _IncentiveDriverRow(
    id: 'DRV-00265',
    name: 'Karan\nSharma',
    tier: 'TIER 1',
    iconData: Icons.verified_outlined,
    completionMain: '04 / 12',
    completionSub: '7 LEFT TO MILESTONE',
    progressName: 'Tier 3 (Silver)',
    progressPct: 30,
    progressColor: AppColors.blue,
    status: _pendingStatus,
    statusColor: AppColors.amber,
    statusBgColor: AppColors.cFFFFF8E1,
  ),
  _IncentiveDriverRow(
    id: 'DRV-00232',
    name: 'Sam\nKumar',
    tier: 'TIER 3',
    iconData: Icons.diamond_outlined,
    completionMain: '11 / 12',
    completionSub: '1 LEFT TO MILESTONE',
    progressName: 'Tier 3 (Platinum)',
    progressPct: 90,
    progressColor: AppColors.primary,
    status: _completedStatus,
    statusColor: AppColors.primary,
    statusBgColor: AppColors.cFFE8F5E9,
  ),
  _IncentiveDriverRow(
    id: 'DRV-00255',
    name: 'Arjun\nKumar',
    tier: 'TIER 3',
    iconData: Icons.diamond_outlined,
    completionMain: '09 / 12',
    completionSub: '3 LEFT TO MILESTONE',
    progressName: 'Tier 3 (Platinum)',
    progressPct: 70,
    progressColor: AppColors.primary,
    status: _completedStatus,
    statusColor: AppColors.primary,
    statusBgColor: AppColors.cFFE8F5E9,
  ),
];
