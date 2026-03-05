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
    // Return "Rejected Documents" for Vehicle RC tab (index 1),
    // and "New Documents" for others as per screenshots.
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
                _buildDrivingLicenseTab(),
                _buildVehicleRCTab(),
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
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
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

  Widget _buildDrivingLicenseTab() {
    return _buildStandardVerificationLayout(
      fileTag: 'DL_FRONT & Back_VIKRAM_SETH.JPG',
      label1: 'FRONT VIEW',
      label2: 'BACK VIEW',
      panelTitle: 'Verify Document Details',
      fieldLabel: 'LICENSE NUMBER',
      fieldValue: 'DL-2023089421',
      showVerificationPanel: true,
    );
  }

  Widget _buildVehicleRCTab() {
    return _buildStandardVerificationLayout(
      fileTag: 'RC_FRONT & Back_VIKRAM_SETH.JPG',
      label1: 'FRONT VIEW',
      label2: 'BACK VIEW',
      panelTitle: 'Verify Document Details',
      fieldLabel: 'VEHICLE NUMBER',
      fieldValue: 'TN02 BY4447',
      showVerificationPanel: false,
      extraPanelContent: _buildRejectedStatusCard(),
    );
  }

  Widget _buildPlaceholderTab(String name) {
    return Center(child: Text('$name content coming soon...'));
  }

  Widget _buildStandardVerificationLayout({
    required String fileTag,
    required String label1,
    required String label2,
    required String panelTitle,
    required String fieldLabel,
    required String fieldValue,
    required bool showVerificationPanel,
    Widget? extraPanelContent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildImageBox(label1),
                      const SizedBox(height: 40),
                      _buildImageBox(label2),
                      const SizedBox(height: 48),
                      _buildFileNameTag(fileTag),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                _buildZoomControls(),
              ],
            ),
          ),
        ),
        Container(width: 1, color: Colors.grey.shade200),
        SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: _buildPanel(
              title: panelTitle,
              fieldLabel: fieldLabel,
              fieldValue: fieldValue,
              showVerificationForm: showVerificationPanel,
              extraContent: extraPanelContent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageBox(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Color(0xFF6F767E),
              letterSpacing: 1.2,
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 40,
                  offset: const Offset(0, 15),
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
        ),
      ],
    );
  }

  Widget _buildFileNameTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D1F),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildActionButton(Icons.zoom_in_outlined),
          const SizedBox(height: 20),
          _buildActionButton(Icons.zoom_out_outlined),
          const SizedBox(height: 20),
          _buildActionButton(Icons.refresh_rounded),
          const SizedBox(height: 20),
          _buildActionButton(Icons.fullscreen_rounded),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
    required String title,
    required String fieldLabel,
    required String fieldValue,
    required bool showVerificationForm,
    Widget? extraContent,
  }) {
    return Container(
      padding: const EdgeInsets.all(48),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
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
          if (extraContent != null) ...[
            const SizedBox(height: 24),
            extraContent,
          ],
          if (showVerificationForm) ...[
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

  Widget _buildRejectedStatusCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This document expired 12 days ago.',
          style: TextStyle(
            color: Color(0xFFEF4444),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFEE2E2)),
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
              const Text(
                'REASON',
                style: TextStyle(
                  color: Color(0xFF991B1B),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
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
              const Text(
                'ADMIN NOTES',
                style: TextStyle(
                  color: Color(0xFF991B1B),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '"The vehicle registration has passed its validity date of Nov 12, 2025. Driver must upload a renewed RC or a valid extension certificate."',
                style: TextStyle(
                  color: Color(0xff5e0a0a),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
        fontSize: 14,
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
          borderSide: const BorderSide(color: AppColors.primary, width: 2.5),
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
          borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.5),
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
              width: isSelected ? 2.5 : 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? AppColors.primary.withOpacity(0.06)
                : Colors.white,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
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
      icon: Icon(icon, size: 26),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
