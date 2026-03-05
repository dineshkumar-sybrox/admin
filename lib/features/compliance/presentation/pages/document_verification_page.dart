import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';

class DocumentVerificationPage extends StatefulWidget {
  final String driverName;
  final String documentId;
  final int initialTabIndex;

  const DocumentVerificationPage({
    super.key,
    this.driverName = 'Vikram Seth',
    this.documentId = '#DOC-8801',
    this.initialTabIndex = 1, // Defaulting to 1 (Vehicle RC) as per screenshot
  });

  @override
  State<DocumentVerificationPage> createState() =>
      _DocumentVerificationPageState();
}

class _DocumentVerificationPageState extends State<DocumentVerificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, bool> _rejectionReasons = {
    'Expired Document': false,
    'Blurry Image / Unreadable': false,
    'Name Mismatch': false,
    'Incorrect Document Type': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getPageTitle() {
    // Screenshot specifically shows "Rejected Documents" when Vehicle RC is selected.
    if (_tabController.index == 1) {
      return 'Rejected Documents - ${widget.driverName}';
    }
    return 'New Documents - ${widget.driverName}';
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: _getPageTitle(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVerificationTab(
                  fileTag: 'DL_FRONT & Back_VIKRAM_SETH.JPG',
                  fieldLabel: 'LICENSE NUMBER',
                  fieldValue: 'DL-2023089421',
                  isRejected: false,
                ),
                _buildVerificationTab(
                  fileTag: 'RC_FRONT & Back_VIKRAM_SETH.JPG',
                  fieldLabel: 'VEHICLE NUMBER',
                  fieldValue: 'TN02 BY4447',
                  isRejected: true, // This is exactly what's in the screenshot
                ),
                _buildPlaceholderTab('PAN Card'),
                _buildPlaceholderTab('Aadhar Card'),
                _buildPlaceholderTab('Bank Details'),
                _buildPlaceholderTab('Identity Verification'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AppColors.primary,
        indicatorWeight: 4,
        labelColor: Colors.black,
        unselectedLabelColor: const Color(0xFF6F767E),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        tabs: const [
          Tab(text: 'Driving License'),
          Tab(text: 'Vehicle RC'),
          Tab(text: 'PAN Card'),
          Tab(text: 'Aadhar Card'),
          Tab(text: 'Bank Details'),
          Tab(text: 'Identity Verification'),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String name) {
    return Center(child: Text('$name content coming soon...'));
  }

  Widget _buildVerificationTab({
    required String fileTag,
    required String fieldLabel,
    required String fieldValue,
    required bool isRejected,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Document Preview area
        Expanded(
          flex: 6,
          child: Container(
            color: const Color(
              0xFFF8F9FD,
            ), // Light grey background as in screenshot
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(56),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildImageBox(),
                        const SizedBox(height: 48),
                        _buildImageBox(),
                        const SizedBox(height: 64),
                        _buildFileNameTag(fileTag),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  _buildZoomControls(),
                ],
              ),
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Panel area
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: _buildPanel(
                fieldLabel: fieldLabel,
                fieldValue: fieldValue,
                isRejected: isRejected,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageBox() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              size: 80,
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileNameTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF33383F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Column(
      children: [
        _buildActionButton(Icons.zoom_in_outlined),
        const SizedBox(height: 20),
        _buildActionButton(Icons.zoom_out_outlined),
        const SizedBox(height: 20),
        _buildActionButton(Icons.refresh_rounded),
        const SizedBox(height: 20),
        _buildActionButton(Icons.fullscreen_rounded),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Icon(icon, color: const Color(0xFF1A1D1F), size: 26),
    );
  }

  Widget _buildPanel({
    required String fieldLabel,
    required String fieldValue,
    required bool isRejected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify Document Details',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1D1F),
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 56),
          _buildFieldLabel(fieldLabel),
          const SizedBox(height: 16),
          _buildTextField(fieldValue),
          if (isRejected) ...[
            const SizedBox(height: 24),
            _buildRejectedStatusView(),
          ] else ...[
            const SizedBox(height: 40),
            _buildFieldLabel('EVALUATION NOTES'),
            const SizedBox(height: 16),
            _buildTextArea('Enter your notes here...'),
            const SizedBox(height: 48),
            const Divider(height: 1, thickness: 1.5),
            const SizedBox(height: 48),
            _buildFieldLabel('REJECTION REASONS'),
            const SizedBox(height: 28),
            ..._rejectionReasons.keys.map(
              (reason) => _buildCheckboxItem(reason),
            ),
            const SizedBox(height: 64),
            Row(
              children: [
                Expanded(
                  child: _buildActionBtn(
                    label: 'REJECT',
                    color: const Color(0xFFEF4444),
                    icon: Icons.cancel_outlined,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildActionBtn(
                    label: 'APPROVE',
                    color: AppColors.primary,
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRejectedStatusView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This document expired 12 days ago.',
          style: TextStyle(
            color: Color(0xFFEF4444),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFEE2E2), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'CURRENT STATUS: REJECTED',
                    style: TextStyle(
                      color: Color(0xFFB91C1C),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _RejectedLabel('REASON'),
              const SizedBox(height: 8),
              const Text(
                'Document Expired',
                style: TextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              const _RejectedLabel('ADMIN NOTES'),
              const SizedBox(height: 8),
              const Text(
                '"The vehicle registration has passed its validity date of Nov 12, 2025. Driver must upload a renewed RC or a valid extension certificate."',
                style: TextStyle(
                  color: Color(0xFF5E0A0A),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1A1D1F),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF1A1D1F),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 8,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDC2C8), fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    final isSelected = _rejectionReasons[label] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          setState(() {
            _rejectionReasons[label] = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: isSelected ? 2 : 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? AppColors.primary.withOpacity(0.06)
                : Colors.white,
          ),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (val) {
                  setState(() {
                    _rejectionReasons[label] = val ?? false;
                  });
                },
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  color: isSelected ? Colors.black : const Color(0xFF6F767E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionBtn({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _RejectedLabel extends StatelessWidget {
  final String text;
  const _RejectedLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF991B1B),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.0,
      ),
    );
  }
}
