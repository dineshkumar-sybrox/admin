import 'package:admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/rider_cubit.dart';
import '../cubit/rider_state.dart';
import 'rider_overview_page.dart';

class RiderScreen extends StatelessWidget {
  const RiderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RiderCubit()..loadRiders(),
      child: const _RiderScreenBody(),
    );
  }
}

class _RiderScreenBody extends StatefulWidget {
  const _RiderScreenBody();

  @override
  State<_RiderScreenBody> createState() => _RiderScreenBodyState();
}

class _RiderScreenBodyState extends State<_RiderScreenBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RiderCubit, RiderState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return DefaultTextStyle.merge(
          style: const TextStyle(fontFamily: 'Saira'),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatCardsRow(state: state),
                const SizedBox(height: 24),

                _SearchFilterBar(searchController: _searchController),
                const SizedBox(height: 20),
                _RiderTable(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCardsRow extends StatelessWidget {
  final RiderState state;
  const _StatCardsRow({required this.state});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        final cards = [
          _StatData(
            title: 'TOTAL RIDERS',
            value: '48,921',
            sub: '+2.4%',
            subColor: AppColors.activeGreen,
            subIcon: Icons.arrow_upward,
            borderColor: AppColors.activeGreen,
          ),
          _StatData(
            title: 'ACTIVE TODAY',
            value: '12,402',
            sub: 'Peak: 14k',
            subColor: const Color(0xFF8E9BAB),
            borderColor: AppColors.inactiveGrey,
          ),
          _StatData(
            title: 'NEW REGISTRATIONS',
            value: '428',
            sub: '+12%',
            subColor: const Color(0xFF00A86B),
            subIcon: Icons.arrow_upward,
            borderColor: AppColors.inactiveGrey,
          ),
          _StatData(
            title: 'BANNED RIDERS',
            value: '152',
            sub: 'Flagged for review',
            subColor: const Color(0xFFFF4757),
            borderColor: AppColors.inactiveGrey,
          ),
        ];

        if (isNarrow) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
            children: cards.map((d) => _StatCard(data: d)).toList(),
          );
        }
        return Row(
          children: cards.asMap().entries.map((e) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: e.key < cards.length - 1 ? 12 : 0,
                ),
                child: _StatCard(data: e.value),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _StatData {
  final String title;
  final String value;
  final String sub;
  final Color subColor;
  final Color borderColor;
  final IconData? subIcon;
  const _StatData({
    required this.title,
    required this.value,
    required this.sub,
    required this.subColor,
    required this.borderColor,
    this.subIcon,
  });
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: data.borderColor, // Green color
            width: 3, // Thickness of left border
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8E9BAB),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A2332),
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: [
                    if (data.subIcon != null)
                      Icon(data.subIcon, size: 10, color: data.subColor),
                    Text(
                      data.sub,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: data.subColor,
                      ),
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
}

class _SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  const _SearchFilterBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 4),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (v) => context.read<RiderCubit>().search(v),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1A2332),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search by name, email or phone...',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            SizedBox(width: 500),

            BlocBuilder<RiderCubit, RiderState>(
              builder: (context, state) {
                return Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEFEFEF)),
                  ),
                  child: PopupMenuButton<RiderStatusFilter>(
                    offset: const Offset(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFEFEFEF)),
                    ),
                    color: Colors.white,
                    elevation: 6,
                    onSelected: (val) {
                      context.read<RiderCubit>().setStatusFilter(val);
                    },
                    itemBuilder: (context) => [
                      _buildStatusItem(
                        RiderStatusFilter.all,
                        'All Status',
                        state.statusFilter == RiderStatusFilter.all,
                      ),
                      _buildStatusItem(
                        RiderStatusFilter.active,
                        'Active',
                        state.statusFilter == RiderStatusFilter.active,
                      ),
                      _buildStatusItem(
                        RiderStatusFilter.inactive,
                        'Inactive',
                        state.statusFilter == RiderStatusFilter.inactive,
                      ),
                      _buildStatusItem(
                        RiderStatusFilter.banned,
                        'Banned',
                        state.statusFilter == RiderStatusFilter.banned,
                      ),
                    ],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getStatusText(state.statusFilter),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1D1F),
                          ),
                        ),
                        const SizedBox(width: 32),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: Color(0xFF6F767E),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),

            SizedBox(
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 16, color: Colors.white),
                label: const Text(
                  'Export Data',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A86B),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getStatusText(RiderStatusFilter filter) {
  switch (filter) {
    case RiderStatusFilter.all:
      return 'All Status';
    case RiderStatusFilter.active:
      return 'Active';
    case RiderStatusFilter.inactive:
      return 'Inactive';
    case RiderStatusFilter.banned:
      return 'Banned';
  }
}

PopupMenuItem<RiderStatusFilter> _buildStatusItem(
  RiderStatusFilter value,
  String text,
  bool isSelected,
) {
  return PopupMenuItem<RiderStatusFilter>(
    value: value,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.activeGreen
                  : const Color(0xFF1A1D1F),
            ),
          ),
          SizedBox(width: 15),
          if (isSelected)
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 14,
              color: AppColors.activeGreen,
            ),
        ],
      ),
    ),
  );
}

class _RiderTable extends StatelessWidget {
  final RiderState state;
  const _RiderTable({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TableHeader(),

        //const Divider(height: 1, color: Color(0xFFF0F2F5)),
        if (state.filteredRiders.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text(
                'No riders found',
                style: TextStyle(color: Color(0xFF8E9BAB), fontSize: 14),
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.divider),
              // borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: state.filteredRiders
                  .asMap()
                  .entries
                  .map((e) => _RiderRow(rider: e.value, isEven: e.key.isEven))
                  .toList(),
            ),
          ),
        // Pagination
        const Divider(height: 1, color: Color(0xFFF0F2F5)),
        _Pagination(state: state),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: AppColors.textSecondary,
      letterSpacing: 0.5,
    );
    return Container(
      color: const Color.fromARGB(255, 248, 248, 248),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('CUSTOMER', style: headerStyle),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'CONTACT INFORMATION',
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'TOTAL RIDES',
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'WALLET BALANCE (₹)',
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'COINS',
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'STATUS',
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiderRow extends StatefulWidget {
  final Rider rider;
  final bool isEven;
  const _RiderRow({required this.rider, required this.isEven});

  @override
  State<_RiderRow> createState() => _RiderRowState();
}

class _RiderRowState extends State<_RiderRow> {
  bool _hovered = false;

  Color get _statusColor {
    switch (widget.rider.status) {
      case 'Active':
        return const Color(0xFF00A86B);
      case 'Inactive':
        return const Color(0xFFFF8C42);
      default:
        return const Color(0xFFFF4757);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RiderOverviewPage()),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: _hovered ? const Color(0xFFF7FDF9) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: _avatarBg(widget.rider.name),
                        child: Text(
                          widget.rider.avatarInitials,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _avatarFg(widget.rider.name),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.rider.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A2332),
                            ),
                          ),
                          Text(
                            'ID: ${widget.rider.id}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF8E9BAB),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.rider.phone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1A2332),
                      ),
                    ),
                    Text(
                      widget.rider.email,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8E9BAB),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  '${widget.rider.totalRides}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2332),
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  '₹${widget.rider.walletBalance.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2332),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  widget.rider.coins == 0
                      ? '0'
                      : _formatCoins(widget.rider.coins),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: widget.rider.coins == 0
                        ? const Color(0xFF8E9BAB)
                        : const Color(0xFFFF8C42),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.rider.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCoins(int coins) {
    if (coins >= 1000) {
      return '${(coins / 1000).toStringAsFixed(coins % 1000 == 0 ? 0 : 1)}k';
    }
    return '$coins';
  }

  Color _avatarBg(String name) {
    final colors = [
      const Color(0xFFE8F5FF),
      const Color(0xFFE8F9F1),
      const Color(0xFFFFF0E6),
      const Color(0xFFF3E8FF),
      const Color(0xFFFFEBEB),
    ];
    return colors[name.length % colors.length];
  }

  Color _avatarFg(String name) {
    final colors = [
      const Color(0xFF4A90D9),
      const Color(0xFF00A86B),
      const Color(0xFFFF8C42),
      const Color(0xFF9B59B6),
      const Color(0xFFFF4757),
    ];
    return colors[name.length % colors.length];
  }
}

class _Pagination extends StatelessWidget {
  final RiderState state;
  const _Pagination({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RiderCubit>();
    final totalPages = (state.totalCount / 5).ceil();
    final currentPage = state.currentPage;

    return Container(
      color: const Color.fromARGB(255, 248, 248, 248),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8E9BAB),
              ),
              children: [
                const TextSpan(text: 'Showing '),
                TextSpan(
                  text:
                      '${(currentPage - 1) * 5 + 1} - ${(currentPage * 5).clamp(0, state.totalCount)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A2332),
                  ),
                ),
                TextSpan(text: ' of ${_formatNum(state.totalCount)} customers'),
              ],
            ),
          ),
          const Spacer(),

          Row(
            children: [
              _PageBtn(
                label: 'Previous',
                onTap: currentPage > 1
                    ? () => cubit.goToPage(currentPage - 1)
                    : null,
              ),
              const SizedBox(width: 4),
              _PageNum(
                page: 1,
                isSelected: currentPage == 1,
                onTap: () => cubit.goToPage(1),
              ),
              const SizedBox(width: 4),
              _PageNum(
                page: 2,
                isSelected: currentPage == 2,
                onTap: () => cubit.goToPage(2),
              ),
              const SizedBox(width: 4),
              _PageNum(
                page: 3,
                isSelected: currentPage == 3,
                onTap: () => cubit.goToPage(3),
              ),
              const SizedBox(width: 4),
              const Text(
                '....',
                style: TextStyle(color: Color(0xFF8E9BAB), fontSize: 13),
              ),
              const SizedBox(width: 4),
              _PageNum(
                page: totalPages,
                isSelected: currentPage == totalPages,
                onTap: () => cubit.goToPage(totalPages),
              ),
              const SizedBox(width: 4),
              _PageBtn(
                label: 'Next',
                onTap: currentPage < totalPages
                    ? () => cubit.goToPage(currentPage + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}k';
    }
    return '$n';
  }
}

class _PageBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _PageBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDDE1E7)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onTap != null
                ? const Color(0xFF1A2332)
                : const Color(0xFFB0BAC8),
          ),
        ),
      ),
    );
  }
}

class _PageNum extends StatelessWidget {
  final int page;
  final bool isSelected;
  final VoidCallback onTap;
  const _PageNum({
    required this.page,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 30,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A2332)
              : Color.fromARGB(255, 248, 248, 248),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1A2332)
                : Color.fromARGB(255, 248, 248, 248),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF1A2332),
            ),
          ),
        ),
      ),
    );
  }
}
