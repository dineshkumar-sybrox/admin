import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class StatCardsRow extends StatelessWidget {
  const StatCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 700;
            if (isNarrow) {
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: state.statCards
                    .asMap()
                    .entries
                    .map(
                      (e) => _StatCard(
                        card: e.value,
                        isClickable:
                            e.key == 0 ||
                            e.key == 1 ||
                            e.key == 2 ||
                            e.key == 3,
                        onTap: e.key == 0
                            ? () => context.read<DashboardCubit>().selectNav(
                                NavItem.drivers,
                              )
                            : e.key == 1
                            ? () => context.read<DashboardCubit>().selectNav(
                                NavItem.rider,
                              )
                            : e.key == 2
                            ? () => context.read<DashboardCubit>().selectNav(
                                NavItem.revenue,
                              )
                            : e.key == 3
                            ? () => context.read<DashboardCubit>().selectNav(
                                NavItem.cancellation,
                              )
                            : null,
                      ),
                    )
                    .toList(),
              );
            }
            return Row(
              children: state.statCards.asMap().entries.map((e) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: e.key < state.statCards.length - 1 ? 12 : 0,
                    ),
                    child: _StatCard(
                      card: e.value,
                      isClickable:
                          e.key == 0 || e.key == 1 || e.key == 2 || e.key == 3,
                      onTap: e.key == 0
                          ? () => context.read<DashboardCubit>().selectNav(
                              NavItem.drivers,
                            )
                          : e.key == 1
                          ? () => context.read<DashboardCubit>().selectNav(
                              NavItem.rider,
                            )
                          : e.key == 2
                          ? () => context.read<DashboardCubit>().selectNav(
                              NavItem.revenue,
                            )
                          : e.key == 3
                          ? () => context.read<DashboardCubit>().selectNav(
                              NavItem.cancellation,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatefulWidget {
  final StatCard card;
  final bool isClickable;
  final VoidCallback? onTap;
  const _StatCard({required this.card, this.isClickable = false, this.onTap});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  static const _accent = Color(0xFF00A86B);
  static const _cardRadius = 18.0;
  static const _barWidth = 2.5;

  @override
  Widget build(BuildContext context) {
    final trendColor = widget.card.isPositive
        ? _accent
        : const Color(0xFFFF4757);

    return MouseRegion(
      cursor: widget.isClickable
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.isClickable) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (widget.isClickable) setState(() => _hovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_cardRadius),
            border: Border.all(color: const Color(0xFFE6EAF0), width: 1),
            boxShadow: [
              BoxShadow(
                color: _hovered && widget.isClickable
                    ? _accent.withValues(alpha: 0.13)
                    : Colors.black.withValues(alpha: 0.055),
                blurRadius: _hovered && widget.isClickable ? 20 : 12,
                spreadRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_cardRadius),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _barWidth,
                    color: _accent,
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.card.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8A97A8),
                              letterSpacing: 0.9,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.card.value,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A2332),
                                  height: 1.0,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(width: 10),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    widget.card.isPositive
                                        ? Icons.trending_up_rounded
                                        : Icons.trending_down_rounded,
                                    size: 16,
                                    color: trendColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    widget.card.trend,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: trendColor,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                ],
                              ),

                              if (widget.isClickable) ...[
                                const Spacer(),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: _hovered ? 1.0 : 0.4,
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 12,
                                    color: _accent,
                                  ),
                                ),
                              ],
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
