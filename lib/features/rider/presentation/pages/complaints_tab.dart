import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class ComplaintsTab extends StatefulWidget {
  final VoidCallback? onIssueRefund;

  ComplaintsTab({super.key, this.onIssueRefund});

  @override
  State<ComplaintsTab> createState() => _ComplaintsTabState();
}

class _ComplaintsTabState extends State<ComplaintsTab> {
  int _selectedTicketIndex = 0;
  String _selectedFilter = 'All';
  String _searchQuery = '';
  bool _showSearch = false;

  final List<Map<String, dynamic>> tickets = [
    {
      'id': '#TC-8821',
      'title': 'Overcharged for ride',
      'status': 'In Progress',
      'rideId': 'RD-1205',
      'date': 'Oct 15, 2026',
    },
    {
      'id': '#TC-8742',
      'title': 'Driver behavior issue',
      'status': 'Resolved',
      'rideId': 'RD-0992',
      'date': 'Oct 15, 2026',
    },
    {
      'id': '#TC-8611',
      'title': 'Cancellation fee dispute',
      'status': 'Closed',
      'rideId': 'RD-0814',
      'date': 'Oct 15, 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final openTickets = tickets
        .where((t) => t['status'] == 'In Progress')
        .toList();
    final closedTickets = tickets
        .where((t) => t['status'] != 'In Progress')
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Sidebar: Support Tickets
        Container(
          width: 300,
          color: AppColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 HEADER
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !_showSearch
                        ? Text(
                            'Support Tickets',
                            style: AppTypography.base.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          )
                        : Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value.toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search Ticket ID or Name...',
                                hintStyle: AppTypography.base.copyWith(
                                  color: AppColors.cFF9EA5AD,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.cFF9EA5AD,
                                  size: 18,
                                ),
                                filled: true,
                                fillColor: AppColors.cFFF9FAFB,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.cFFEFEFEF,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.cFFEFEFEF,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),

                    Row(
                      children: [
                        // 🔽 FILTER
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              _selectedFilter = value;
                            });
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'All',
                              child: Text('All'),
                            ),
                            const PopupMenuItem(
                              value: 'In Progress',
                              child: Text('In Progress'),
                            ),
                            const PopupMenuItem(
                              value: 'Resolved',
                              child: Text('Resolved'),
                            ),
                            const PopupMenuItem(
                              value: 'Closed',
                              child: Text('Closed'),
                            ),
                          ],
                          child: Icon(
                            Icons.filter_list,
                            color: AppColors.textSecondary,
                          ),
                        ),

                        const SizedBox(width: 8),

                        // 🔍 SEARCH TOGGLE
                        IconButton(
                          icon: Icon(
                            _showSearch ? Icons.close : Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _showSearch = !_showSearch;
                              _searchQuery = '';
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: AppColors.divider),

              // 🔹 LIST
              Expanded(
                child: Builder(
                  builder: (context) {
                    // 🔥 FILTER + SEARCH LOGIC
                    List<Map<String, dynamic>> filteredTickets = tickets.where((
                      ticket,
                    ) {
                      final title = ticket['title'].toString().toLowerCase();
                      final id = ticket['id'].toString().toLowerCase();
                      final rideId = ticket['rideId'].toString().toLowerCase();
                      final status = ticket['status'].toString();

                      final matchesSearch =
                          title.contains(_searchQuery) ||
                          id.contains(_searchQuery) ||
                          rideId.contains(_searchQuery);

                      if (_selectedFilter == 'All') {
                        return matchesSearch;
                      } else {
                        return status == _selectedFilter && matchesSearch;
                      }
                    }).toList();

                    // 🔹 SPLIT DATA
                    final openTickets = filteredTickets
                        .where((t) => t['status'] == 'In Progress')
                        .toList();

                    final closedTickets = filteredTickets
                        .where((t) => t['status'] != 'In Progress')
                        .toList();

                    return ListView(
                      children: [
                        // 🔸 OPEN
                        ...openTickets.asMap().entries.map((entry) {
                          int index = entry.key;
                          final ticket = entry.value;
                          final isSelected = index == _selectedTicketIndex;

                          return _buildTicketItem(ticket, index, isSelected);
                        }),

                        // 🔸 CLOSED HEADER
                        if (closedTickets.isNotEmpty)
                          Container(
                            width: double.infinity,
                            color: AppColors.cFFF3F4F6,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Text(
                              'Closed Tickets',
                              style: AppTypography.base.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),

                        // 🔸 CLOSED
                        ...closedTickets.asMap().entries.map((entry) {
                          int index = entry.key + openTickets.length;
                          final ticket = entry.value;
                          final isSelected = index == _selectedTicketIndex;

                          return _buildTicketItem(ticket, index, isSelected);
                        }),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        VerticalDivider(width: 1, color: AppColors.divider),

        // Right Panel: Chat/Resolution
        Expanded(
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                // Chat Header
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Complaints & Resolution',
                                style: AppTypography.base.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'BILLING',
                                  style: AppTypography.base.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              text: 'Ticket ID: #TC-8821 • Assigned to: ',
                              style: AppTypography.base.copyWith(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Support Agent Sarah',
                                  style: AppTypography.base.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check_circle_outline_sharp,
                              size: 16,
                            ),
                            label: Text('ClOSE TICKET'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: BorderSide(color: AppColors.divider),
                              backgroundColor: AppColors.background,
                            ),
                          ),
                          SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (widget.onIssueRefund != null) {
                                widget.onIssueRefund!();
                              }
                            },
                            icon: Icon(Icons.money, size: 16),
                            label: Text('Issue Refund'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppColors.divider),

                // Chat Messages // [Rest of the Chat UI intact]
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(24.0),
                    children: [
                      // User Message
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(
                              'assets/images/rahul_sharma.jpg',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.scaffoldBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Hi, I was charged ₹452 for a ride from Prestige Tech Park to Indiranagar, but the app estimated only ₹352. Could you please look into why the final fare was so high? There was no significant traffic.',
                                    style: AppTypography.base.copyWith(
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Rahul Sharma • 10:42 AM',
                                  style: AppTypography.base.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 48), // Padding on right
                        ],
                      ),
                      SizedBox(height: 24),

                      // Agent Message
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 48), // Padding on left
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.cFF111827, // Very dark
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Hello Rahul, I am checking the ride logs right now. It appears the driver deviated from the suggested route. Please give me a moment to calculate the refund amount based on the estimated path.',
                                    style: AppTypography.base.copyWith(
                                      fontSize: 14,
                                      color: AppColors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Support Sarah • 10:55 AM',
                                  style: AppTypography.base.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.cFF111827,
                            child: Icon(
                              Icons.support_agent,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Ride Reference Card
                      Center(
                        child: Container(
                          width: 350, // Fixed width based on design
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.divider),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.scaffoldBackground,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'RIDE REFERENCE RD-1205',
                                      style: AppTypography.base.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      'COMPLETED',
                                      style: AppTypography.base.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.success,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: AppColors.divider),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'FARE CHARGED',
                                          style: AppTypography.base.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '₹452.00',
                                          style: AppTypography.base.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ESTIMATED',
                                          style: AppTypography.base.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '₹352.00',
                                          style: AppTypography.base.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 24), // Spacer
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Input
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.divider),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {},
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Type a message...',
                                    hintStyle: AppTypography.base.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.textPrimary,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.scaffoldBackground,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.mic, color: AppColors.primary),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketItem(Map ticket, int index, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTicketIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cFFF9FAFB : AppColors.white,
          border: Border(
            left: BorderSide(
              color: isSelected
                  ? AppColors
                        .cFF22C55E // green like image
                  : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID + STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket['id'],
                  style: AppTypography.base.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                _buildStatusBadge(ticket['status']),
              ],
            ),

            SizedBox(height: 6),

            // TITLE
            Text(
              ticket['title'],
              style: AppTypography.base.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 8),

            // RIDE + DATE
            Row(
              children: [
                Icon(Icons.directions_car_outlined, size: 14),
                SizedBox(width: 4),
                Text(ticket['rideId']),

                SizedBox(width: 12),

                Icon(Icons.calendar_today_outlined, size: 14),
                SizedBox(width: 4),
                Text(ticket['date']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'In Progress':
        bgColor = AppColors.cFFFEF3C7; // Light orange/yellow
        textColor = AppColors.cFFD97706; // Dark orange
        break;
      case 'Resolved':
        bgColor = AppColors.cFFD1FAE5; // Light green
        textColor = AppColors.cFF065F46; // Dark green
        break;
      case 'Closed':
        bgColor = AppColors.cFFFEE2E2; // Light red
        textColor = AppColors.cFFB91C1C; // Dark red
        break;
      default:
        bgColor = AppColors.grey[200]!;
        textColor = AppColors.textSecondary;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: AppTypography.base.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
