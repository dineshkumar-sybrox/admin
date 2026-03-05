import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';

class DocumentVerificationPage extends StatefulWidget {
  final String driverName;
  final String documentId;

  const DocumentVerificationPage({
    super.key,
    this.driverName = 'Vikram Seth',
    this.documentId = '#DOC-8801',
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
    _tabController = TabController(length: 6, vsync: this);
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
                  isRejected: true,
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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
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
        labelPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
        // Left Side: Document Preview (Scrollable)
        Expanded(
          flex: 75, // Matching flex for approx 3:1 or similar
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
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Panel (Scrollable)
        SizedBox(
          width: 550,
          child: SingleChildScrollView(
            child: _buildPanel(
              fieldLabel: fieldLabel,
              fieldValue: fieldValue,
              isRejected: isRejected,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageBox() {
    return AspectRatio(
      aspectRatio: 1.45,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 50,
              offset: const Offset(0, 20),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              size: 96,
              color: Colors.grey.shade100,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileNameTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF33383F),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildActionButton(Icons.zoom_in_outlined),
          const SizedBox(height: 24),
          _buildActionButton(Icons.zoom_out_outlined),
          const SizedBox(height: 24),
          _buildActionButton(Icons.refresh_rounded),
          const SizedBox(height: 24),
          _buildActionButton(Icons.fullscreen_rounded),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Icon(icon, color: const Color(0xFF1A1D1F), size: 28),
    );
  }

  Widget _buildPanel({
    required String fieldLabel,
    required String fieldValue,
    required bool isRejected,
  }) {
    return Container(
      padding: const EdgeInsets.all(56),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify Document Details',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1D1F),
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 64),
          _buildFieldLabel(fieldLabel),
          const SizedBox(height: 18),
          _buildTextField(fieldValue),
          if (isRejected) ...[
            const SizedBox(height: 24),
            _buildRejectedStatusView(),
          ] else ...[
            const SizedBox(height: 48),
            _buildFieldLabel('EVALUATION NOTES'),
            const SizedBox(height: 18),
            _buildTextArea('Enter your notes here...'),
            const SizedBox(height: 56),
            const Divider(height: 1, thickness: 1.5),
            const SizedBox(height: 56),
            _buildFieldLabel('REJECTION REASONS'),
            const SizedBox(height: 32),
            ..._rejectionReasons.keys.map(
              (reason) => _buildCheckboxItem(reason),
            ),
            const SizedBox(height: 80),
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
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFEE2E2), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'CURRENT STATUS: REJECTED',
                    style: TextStyle(
                      color: Color(0xFFB91C1C),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const _RejectedLabel('REASON'),
              const SizedBox(height: 12),
              const Text(
                'Document Expired',
                style: TextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 32),
              const _RejectedLabel('ADMIN NOTES'),
              const SizedBox(height: 12),
              const Text(
                '"The vehicle registration has passed its validity date of Nov 12, 2025. Driver must upload a renewed RC or a valid extension certificate."',
                style: TextStyle(
                  color: Color(0xFF5E0A0A),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
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
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1A1D1F),
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xFF1A1D1F),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 10,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDC2C8), fontSize: 18),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    final isSelected = _rejectionReasons[label] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: () {
          setState(() {
            _rejectionReasons[label] = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: isSelected ? 3 : 2,
            ),
            borderRadius: BorderRadius.circular(18),
            color: isSelected
                ? AppColors.primary.withOpacity(0.08)
                : Colors.white,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.4,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      _rejectionReasons[label] = val ?? false;
                    });
                  },
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
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
      icon: Icon(icon, size: 30),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
          letterSpacing: 1.5,
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
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }
}
