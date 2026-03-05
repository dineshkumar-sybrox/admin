import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../presentation/widgets/admin_scaffold.dart';

class DocumentVerificationPage extends StatefulWidget {
  final String driverName;
  final String documentId;
  final int initialIndex;

  const DocumentVerificationPage({
    super.key,
    required this.driverName,
    required this.documentId,
    this.initialIndex = 0,
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
      initialIndex: widget.initialIndex,
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
                _buildDynamicTabContent(), // index 0: Driving License
                _buildDynamicTabContent(), // index 1: Vehicle RC
                _buildDynamicTabContent(), // index 2: PAN Card
                _buildDynamicTabContent(), // index 3: Aadhar Card
                _buildBankDetailsTab(), // index 4: Bank Details
                _buildIdentityVerificationTab(), // index 5: Identity Verification
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicTabContent() {
    final int index = _tabController.index;
    String fileTag = '';
    String fieldLabel = '';
    String fieldValue = '';

    if (index == 0) {
      fileTag = 'DL_FRONT & Back_VIKRAM_SETH.JPG';
      fieldLabel = 'LICENSE NUMBER';
      fieldValue = 'DL-2023089421';
    } else if (index == 1) {
      fileTag = 'RC_FRONT & Back_VIKRAM_SETH.JPG';
      fieldLabel = 'VEHICLE NUMBER';
      fieldValue = 'TN02 BY4447';
    } else if (index == 2) {
      fileTag = 'Pan_FRONT & Back_VIKRAM_SETH.JPG';
      fieldLabel = 'PAN NUMBER';
      fieldValue = 'TN02 BY4447';
    } else if (index == 3) {
      fileTag = 'Aadhar_FRONT & Back_VIKRAM_SETH.JPG';
      fieldLabel = 'AADHAR NUMBER'; // Matching screenshot for Aadhar tab
      fieldValue = 'TN02 BY4447';
    }

    return _buildVerificationContent(
      fileTag: fileTag,
      fieldLabel: fieldLabel,
      fieldValue: fieldValue,
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: const Color(
          0xFF22C55E,
        ), // Green indicator for tabs in screenshot
        indicatorWeight: 3,
        labelColor: Colors.black,
        unselectedLabelColor: const Color(0xFF6F767E),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  Widget _buildBankDetailsTab() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Identity Verification Summary
        Expanded(
          flex: 7,
          child: Container(
            color: const Color(0xFFF8F9FD),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Identity Verification Summary',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1D1F),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cross-verify the bank account holder name with previously verified identity documents.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6F767E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildVerificationCard(
                    icon: Icons.contact_mail_outlined,
                    label: 'NAME ON PAN CARD',
                    name: widget.driverName.toUpperCase(),
                    iconBg: const Color(0xFFE9FBF3),
                    iconColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 24),
                  _buildVerificationCard(
                    icon: Icons.fingerprint_rounded,
                    label: 'NAME ON AADHAR CARD',
                    name: widget.driverName.toUpperCase(),
                    iconBg: const Color(0xFFE9FBF3),
                    iconColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 48),
                  _buildGuidelinesBox(),
                ],
              ),
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(
          width: 450,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: _buildBankVerificationPanel(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityVerificationTab() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Identity Previews
        Expanded(
          flex: 7,
          child: Container(
            color: const Color(0xFFF8F9FD),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live Selfie
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSourceBadge(
                          'LIVE SELFIE (REAL-TIME)',
                          'Liveness Passed',
                          const Color(0xFFE9FBF3),
                          const Color(0xFF10B981),
                        ),
                        const SizedBox(height: 24),
                        _buildIdentityPreviewBox(isCamera: true),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Document Extraction
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSourceBadge(
                          'DOCUMENT EXTRACTION (DL)',
                          'Source: DL_Front.jpg',
                          const Color(0xFFF1F5F9),
                          const Color(0xFF64748B),
                        ),
                        const SizedBox(height: 24),
                        _buildIdentityPreviewBox(isCamera: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(
          width: 450,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: _buildIdentityVerificationPanel(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceBadge(String title, String label, Color bg, Color text) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1D1F),
            letterSpacing: 0.5,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: text,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityPreviewBox({bool isCamera = false}) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: isCamera
            ? Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.35),
                    width: 3,
                    style: BorderStyle.none, // Placeholder for dash effect
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomPaint(
                    painter: _DashPainter(
                      color: const Color(0xFF10B981).withOpacity(0.5),
                    ),
                    child: Container(),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _buildIdentityVerificationPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify Document Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1D1F),
          ),
        ),
        const SizedBox(height: 44),
        _buildSectionLabel('NAME'),
        const SizedBox(height: 12),
        _buildTextField('Vikram Seth'),
        const SizedBox(height: 32),
        _buildSectionLabel('AGE'),
        const SizedBox(height: 12),
        _buildTextField('24'),
        const SizedBox(height: 32),
        _buildSectionLabel('GENDER'),
        const SizedBox(height: 12),
        _buildTextField('Male'),
        const SizedBox(height: 32),
        _buildSectionLabel('IFSC CODE'),
        const SizedBox(height: 12),
        _buildTextField('HDFC0001245'),
        const SizedBox(height: 48),
        _buildSectionLabel('EVALUATION NOTES'),
        const SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        const SizedBox(height: 32),
        const Divider(height: 1),
        const SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        const SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: const Color(0xFFEF4444),
                icon: Icons.cancel_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: const Color(0xFF10B981),
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationCard({
    required IconData icon,
    required String label,
    required String name,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F767E),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1D1F),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE9FBF3),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: const Color(0xFFD1FAE5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  'VERIFIED',
                  style: TextStyle(
                    color: Color(0xFF065F46),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelinesBox() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF2563EB),
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Verification Guidelines',
                style: TextStyle(
                  color: Color(0xFF1E40AF),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...[
            'The Account Holder Name must exactly match the verified names above.',
            'Small spelling variations may be accepted as per local compliance rules.',
            'Ensure the IFSC Code matches the branch location if applicable.',
          ].map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageBox() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            size: 80,
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _buildFileNameTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF33383F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBankVerificationPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify Document Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1D1F),
          ),
        ),
        const SizedBox(height: 44),
        _buildSectionLabel('NAME'),
        const SizedBox(height: 12),
        _buildTextField('Vikram Seth'),
        const SizedBox(height: 32),
        _buildSectionLabel('BANK NAME'),
        const SizedBox(height: 12),
        _buildTextField('HDFC Bank'),
        const SizedBox(height: 32),
        _buildSectionLabel('ACCOUNT NUMBER'),
        const SizedBox(height: 12),
        _buildTextField('50100422938104'),
        const SizedBox(height: 32),
        _buildSectionLabel('IFSC CODE'),
        const SizedBox(height: 12),
        _buildTextField('HDFC0001245'),
        const SizedBox(height: 48),
        _buildSectionLabel('EVALUATION NOTES'),
        const SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        const SizedBox(height: 32),
        const Divider(height: 1),
        const SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        const SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: const Color(0xFFEF4444),
                icon: Icons.cancel_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: const Color(0xFF10B981),
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationContent({
    required String fileTag,
    required String fieldLabel,
    required String fieldValue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Document Preview (Scrollable)
        Expanded(
          flex: 7,
          child: Container(
            color: const Color(0xFFF8F9FD),
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      _buildImageBox(),
                      const SizedBox(height: 32),
                      _buildImageBox(),
                      const SizedBox(height: 48),
                      _buildFileNameTag(fileTag),
                    ],
                  ),
                ),
                const Positioned(right: 32, top: 32, child: _ZoomControls()),
              ],
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel (Scrollable)
        SizedBox(
          width: 450,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: _buildVerificationPanel(
                fieldLabel: fieldLabel,
                fieldValue: fieldValue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationPanel({
    required String fieldLabel,
    required String fieldValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify Document Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1D1F),
          ),
        ),
        const SizedBox(height: 40),
        _buildSectionLabel(fieldLabel),
        const SizedBox(height: 12),
        _buildTextField(fieldValue),
        const SizedBox(height: 40),
        const SizedBox(height: 32),
        _buildSectionLabel('EVALUATION NOTES'),
        const SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        const SizedBox(height: 32),
        const Divider(height: 1),
        const SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        const SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: const Color(0xFFEF4444),
                icon: Icons.cancel_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: const Color(0xFF10B981),
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1A1D1F),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xFF1A1D1F),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 2),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 6,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9A9FA5), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 2),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    final isSelected = _rejectionReasons[label] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _rejectionReasons[label] = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF22C55E)
                  : Colors.grey.shade200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      _rejectionReasons[label] = val ?? false;
                    });
                  },
                  activeColor: const Color(0xFF22C55E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ZoomControls extends StatelessWidget {
  const _ZoomControls();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBtn(Icons.zoom_in_outlined),
          const SizedBox(height: 12),
          _buildBtn(Icons.zoom_out_outlined),
          const SizedBox(height: 12),
          _buildBtn(Icons.refresh_rounded),
          const SizedBox(height: 12),
          _buildBtn(Icons.fullscreen_rounded),
        ],
      ),
    );
  }

  Widget _buildBtn(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Icon(icon, color: const Color(0xFF1A1D1F), size: 20),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;
  _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8;
    const double dashSpace = 4;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );
    final path = Path()..addRRect(rrect);

    for (final measure in path.computeMetrics()) {
      double distance = 0;
      while (distance < measure.length) {
        canvas.drawPath(
          measure.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
