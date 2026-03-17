# GoAPP Admin Panel Flow Document

## Purpose
This document explains the full admin panel flow, module structure, and how to extend the system safely. It is based on the current code in this repository and maps UI screens to their routing and state flow.

## High-Level Flow
1. App entry point boots the Admin app.
2. A single Dashboard shell hosts the navigation and swaps content based on nav state.
3. Each feature module owns its screen UI and any local state management.

## App Entry And Shell
1. Entry file: `lib/main.dart`
2. App root widget: `AdminApp`
3. Global state: `DashboardCubit` is provided at app root.
4. Main screen: `DashboardScreen`
5. Shell layout: `AdminScaffold`
6. Navigation UI: `Sidebar`

## Navigation And Routing
Navigation is state-driven, not route-driven.

1. `Sidebar` updates `DashboardCubit` with the selected `NavItem`.
2. `DashboardScreen` reads the current `NavItem` from `DashboardState`.
3. `DashboardScreen._buildBody` switches between feature screens based on `NavItem`.
4. Titles are derived using `DashboardScreen._titleFor`.

Key files:
- `lib/features/dashboard/presentation/cubit/dashboard_state.dart`
- `lib/features/dashboard/presentation/cubit/dashboard_cubit.dart`
- `lib/features/dashboard/presentation/pages/dashboard_screen.dart`
- `lib/presentation/widgets/sidebar.dart`
- `lib/presentation/widgets/admin_scaffold.dart`

## Layout System
`AdminScaffold` is the responsive layout wrapper.

Desktop layout:
1. Left sidebar (fixed width)
2. Header row (title + actions)
3. Main body area

Tablet/mobile layout:
1. AppBar with title and actions
2. Drawer with sidebar
3. Body content below

Key file:
- `lib/presentation/widgets/admin_scaffold.dart`

## Theme And Design System
Global visual styling is centralized in:
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_typography.dart`
- `lib/core/theme/app_theme.dart`

## Modules And Screens

### Dashboard
Primary dashboard overview and quick panels.

Screens and widgets:
- `lib/features/dashboard/presentation/pages/dashboard_screen.dart`
- `lib/features/dashboard/presentation/widgets/stat_cards_row.dart`
- `lib/features/dashboard/presentation/widgets/demand_map_widget.dart`
- `lib/features/dashboard/presentation/widgets/document_approvals_panel.dart`
- `lib/features/dashboard/presentation/widgets/ride_trend_chart.dart`
- `lib/features/dashboard/presentation/widgets/support_tickets_panel.dart`

State:
- `DashboardCubit` loads mock data and manages nav state.
- `DashboardState` stores statistics, approvals, and ticket data.

### Riders
Rider management, insights, and detailed rider profile tabs.

Main screen:
- `lib/features/rider/presentation/pages/rider_list_screen.dart`

Tabs and detail pages:
- `lib/features/rider/presentation/pages/rider_overview_page.dart`
- `lib/features/rider/presentation/pages/rider_overview_tab.dart`
- `lib/features/rider/presentation/pages/ride_history_tab.dart`
- `lib/features/rider/presentation/pages/wallet_coins_tab.dart`
- `lib/features/rider/presentation/pages/safety_tab.dart`
- `lib/features/rider/presentation/pages/complaints_tab.dart`
- `lib/features/rider/presentation/pages/refund_ticket_page.dart`

Widgets:
- `lib/features/rider/presentation/widgets/rider_header.dart`
- `lib/features/rider/presentation/widgets/rider_stat_cards.dart`
- `lib/features/rider/presentation/widgets/rider_table.dart`
- `lib/features/rider/presentation/widgets/suspended_riders_table.dart`

State:
- `lib/features/rider/presentation/cubit/rider_cubit.dart`
- `lib/features/rider/presentation/cubit/rider_state.dart`

### Drivers
Driver management with tabs for total, active, new, suspended, and leaderboard.

Main screen:
- `lib/features/drivers/presentation/pages/drivers_management_screen.dart`

Tables and widgets:
- `lib/features/drivers/presentation/widgets/drivers_table.dart`
- `lib/features/drivers/presentation/widgets/active_drivers_table.dart`
- `lib/features/drivers/presentation/widgets/new_drivers_table.dart`
- `lib/features/drivers/presentation/widgets/suspended_drivers_table.dart`
- `lib/features/drivers/presentation/widgets/leaderboard_table.dart`
- `lib/features/drivers/presentation/widgets/drivers_table_header.dart`
- `lib/features/drivers/presentation/widgets/pagination_controls.dart`

State:
- `lib/features/drivers/presentation/cubit/drivers_management_cubit.dart`
- `lib/features/drivers/presentation/cubit/drivers_management_state.dart`

### Payments
Payments dashboard plus transaction list view with filtering.

Main screen:
- `lib/features/payments/presentation/pages/payments_screen.dart`

Widgets:
- `lib/features/payments/presentation/widgets/payment_stat_cards.dart`
- `lib/features/payments/presentation/widgets/payment_analytics_chart.dart`
- `lib/features/payments/presentation/widgets/payment_method_chart.dart`
- `lib/features/payments/presentation/widgets/driver_payout_list.dart`
- `lib/features/payments/presentation/widgets/rider_payments_table.dart`

State:
- `lib/features/payments/presentation/cubit/payments_cubit.dart`
- `lib/features/payments/presentation/cubit/payments_state.dart`

### Analytics
Analytics dashboards with charts and performance tables.

Main screen:
- `lib/features/analytics/presentation/pages/analytics_screen.dart`

Widgets:
- `lib/features/analytics/presentation/widgets/completion_vs_cancellation_chart.dart`
- `lib/features/analytics/presentation/widgets/supply_vs_demand_indicator.dart`
- `lib/features/analytics/presentation/widgets/peak_hour_heatmap.dart`
- `lib/features/analytics/presentation/widgets/regional_performance_table.dart`

### Compliance
Compliance summary and drilldown screens.

Main screen:
- `lib/features/compliance/presentation/pages/compliance_screen.dart`

Drilldowns:
- `lib/features/compliance/presentation/pages/total_documents_screen.dart`
- `lib/features/compliance/presentation/pages/total_tickets_screen.dart`
- `lib/features/compliance/presentation/pages/compliance_score_details_screen.dart`
- `lib/features/compliance/presentation/pages/document_verification_page.dart`
- `lib/features/compliance/presentation/pages/ticket_detail_screen.dart`
- `lib/features/compliance/presentation/pages/close_ticket_dialog.dart`

State:
- `lib/features/compliance/presentation/cubit/total_documents_cubit.dart`
- `lib/features/compliance/presentation/cubit/total_tickets_cubit.dart`

### Pricing
Pricing and rate card management.

Screens:
- `lib/features/pricing/presentation/pages/zone_wise_pricing_page.dart`
- `lib/features/pricing/presentation/pages/rate_card_management_page.dart`

### Incentives
Create and review incentive programs.

Screens:
- `lib/features/incentives/presentation/pages/create_incentive_screen.dart`
- `lib/features/incentives/presentation/pages/incentive_historical_screen.dart`
- `lib/features/incentives/presentation/pages/incentive_detail_screen.dart`

## Data And State Flow
1. Global navigation is managed by `DashboardCubit`.
2. Feature screens that need local state use a `BlocProvider` inside the screen.
3. Filtering, searching, and export are handled in respective feature cubits.

## Common UI Patterns
1. Tables are wrapped in a container with light borders and soft shadows.
2. Filters and search are placed in a top bar inside the same container.
3. Pagination is a footer row inside the container.
4. Section titles use `AppTypography.base` with bold weight.

## How To Add A New Module
1. Create a new feature folder, for example: `lib/features/reports/presentation/pages/reports_screen.dart`.
2. Build the new screen UI and keep layout spacing consistent with existing screens.
3. Add a new `NavItem` to `lib/features/dashboard/presentation/cubit/dashboard_state.dart`.
4. Add a sidebar item in `lib/presentation/widgets/sidebar.dart` to select the new `NavItem`.
5. Add a case in `DashboardScreen._titleFor` for the new nav item.
6. Add a case in `DashboardScreen._buildBody` to return your new screen.
7. If needed, create a feature cubit and wire it with `BlocProvider` in your screen.

## How To Add A New Tab In Riders
1. Add a new tab page in `lib/features/rider/presentation/pages/`.
2. Connect the tab in `rider_overview_page.dart` or the controlling tab widget.
3. Update the tab selector UI to include the new label.
4. If needed, extend `RiderCubit` to support filters or data for the new tab.

## How To Add A New Tab In Drivers
1. Add a new table widget in `lib/features/drivers/presentation/widgets/`.
2. Add a new enum entry to `DriverTab`.
3. Update the switch in `DriversManagementScreen` to render the new widget.
4. If needed, update the `DriversManagementCubit` to support filters or data.

## Export And Reports
Some sections export data:
- Dashboard uses `ExcelExportHelper` in `DashboardCubit.exportTodayReport`.
- Rider and Payments use their own export logic in their cubits.

## Notes
This document maps current files and flow as of the last code scan. If a new module is added, update this document accordingly.
