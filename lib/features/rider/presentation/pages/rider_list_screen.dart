import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/rider_cubit.dart';
import '../cubit/rider_state.dart';
import '../widgets/rider_stat_cards.dart';
import '../widgets/rider_table.dart';
import '../widgets/suspended_riders_table.dart';

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const RiderStatCards(),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SearchFilterBar(searchController: _searchController),
                    if (state.selectedTab == RiderTab.suspended)
                      SuspendedRidersTable(state: state)
                    else
                      RiderTable(state: state),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    Container(
                      color: Colors.white,
                      child: _Pagination(state: state),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;

  const _SearchFilterBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Box
          SizedBox(
            width: 380,
            height: 44,
            child: TextField(
              controller: searchController,
              onChanged: (v) => context.read<RiderCubit>().search(v),
              decoration: InputDecoration(
                hintText: 'Search by name, email or phone...',
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),

          Row(
            children: [
              // Status Dropdown
              Container(
                height: 44,
                width: 140,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: BlocBuilder<RiderCubit, RiderState>(
                  buildWhen: (p, c) => p.statusFilter != c.statusFilter,
                  builder: (context, state) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.statusFilter,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        items: ['All Status', 'Active', 'Inactive', 'Suspended']
                            .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context.read<RiderCubit>().setStatusFilter(
                              newValue,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Export Button
              BlocBuilder<RiderCubit, RiderState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: state.isExporting
                          ? null
                          : () => context.read<RiderCubit>().exportToExcel(),
                      icon: state.isExporting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.download,
                              size: 18,
                              color: Colors.white,
                            ),
                      label: Text(
                        state.isExporting ? 'Exporting...' : 'Export Data',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success, // Green as per mock
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pagination extends StatelessWidget {
  final RiderState state;
  const _Pagination({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.filteredRiders.isEmpty) return const SizedBox.shrink();

    // Showing dummy numbers as the mock shows "Showing 1 - 5 of 22,482 drivers" despite being Rider Screen
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Showing 1 - 5 of 22,482 drivers', // Replicated explicitly from mockup typo
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              _PageButton(icon: Icons.chevron_left, onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(label: '1', onPressed: () {}, isActive: true),
              const SizedBox(width: 8),
              _PageButton(label: '2', onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(label: '3', onPressed: () {}),
              const SizedBox(width: 8),
              _PageButton(icon: Icons.chevron_right, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isActive;

  const _PageButton({
    this.label,
    this.icon,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primary : const Color(0xFFE5E7EB),
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 16, color: const Color(0xFF6B7280))
            : Text(
                label!,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
