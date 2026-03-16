import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';
import 'dart:ui';
import '../../../../presentation/widgets/admin_scaffold.dart';

class DocumentVerificationPage extends StatefulWidget {
  final String driverName;
  final String documentId;
  final int initialIndex;

  DocumentVerificationPage({
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
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey.shade200)),
      ),
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Color(
          0xFF22C55E,
        ), // Green indicator for tabs in screenshot
        indicatorWeight: 3,
        labelColor: AppColors.black,
        unselectedLabelColor: AppColors.cFF6F767E,
        labelStyle: AppTypography.base.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        unselectedLabelStyle: AppTypography.base.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            color: AppColors.cFFF8F9FD,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Identity Verification Summary',
                    style: AppTypography.base.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cFF1A1D1F,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Cross-verify the bank account holder name with previously verified identity documents.',
                    style: AppTypography.base.copyWith(
                      fontSize: 16,
                      color: AppColors.cFF6F767E,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 48),
                  _buildVerificationCard(
                    icon: Icons.contact_mail_outlined,
                    label: 'NAME ON PAN CARD',
                    name: widget.driverName.toUpperCase(),
                    iconBg: AppColors.cFFE9FBF3,
                    iconColor: AppColors.cFF10B981,
                  ),
                  SizedBox(height: 24),
                  _buildVerificationCard(
                    icon: Icons.fingerprint_rounded,
                    label: 'NAME ON AADHAR CARD',
                    name: widget.driverName.toUpperCase(),
                    iconBg: AppColors.cFFE9FBF3,
                    iconColor: AppColors.cFF10B981,
                  ),
                  SizedBox(height: 48),
                  _buildGuidelinesBox(),
                ],
              ),
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: AppColors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(
          width: 450,
          child: Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(40),
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
            color: AppColors.cFFF8F9FD,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(40),
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
                          AppColors.cFFE9FBF3,
                          AppColors.cFF10B981,
                        ),
                        SizedBox(height: 24),
                        _buildIdentityPreviewBox(isCamera: true),
                      ],
                    ),
                  ),
                  SizedBox(width: 32),
                  // Document Extraction
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSourceBadge(
                          'DOCUMENT EXTRACTION (DL)',
                          'Source: DL_Front.jpg',
                          AppColors.cFFF1F5F9,
                          AppColors.cFF64748B,
                        ),
                        SizedBox(height: 24),
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
        Container(width: 1, color: AppColors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(
          width: 450,
          child: Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(40),
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
          style: AppTypography.base.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: AppColors.cFF1A1D1F,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: AppTypography.base.copyWith(
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: isCamera
            ? Container(
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.cFF10B981.withOpacity(0.35),
                    width: 3,
                    style: BorderStyle.none, // Placeholder for dash effect
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomPaint(
                    painter: _DashPainter(
                      color: AppColors.cFF10B981.withOpacity(0.5),
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
        Text(
          'Verify Document Details',
          style: AppTypography.base.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.cFF1A1D1F,
          ),
        ),
        SizedBox(height: 44),
        _buildSectionLabel('NAME'),
        SizedBox(height: 12),
        _buildTextField('Vikram Seth'),
        SizedBox(height: 32),
        _buildSectionLabel('AGE'),
        SizedBox(height: 12),
        _buildTextField('24'),
        SizedBox(height: 32),
        _buildSectionLabel('GENDER'),
        SizedBox(height: 12),
        _buildTextField('Male'),
        SizedBox(height: 32),
        _buildSectionLabel('IFSC CODE'),
        SizedBox(height: 12),
        _buildTextField('HDFC0001245'),
        SizedBox(height: 48),
        _buildSectionLabel('EVALUATION NOTES'),
        SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        SizedBox(height: 32),
        Divider(height: 1),
        SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: AppColors.cFFEF4444,
                icon: Icons.cancel_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: AppColors.cFF10B981,
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
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.base.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.cFF6F767E,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  name,
                  style: AppTypography.base.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cFF1A1D1F,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cFFE9FBF3,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.cFFD1FAE5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.cFF10B981,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  'VERIFIED',
                  style: AppTypography.base.copyWith(
                    color: AppColors.cFF065F46,
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
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cFFEFF6FF,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cFFDBEAFE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.cFF2563EB,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Verification Guidelines',
                style: AppTypography.base.copyWith(
                  color: AppColors.cFF1E40AF,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          ...[
            'The Account Holder Name must exactly match the verified names above.',
            'Small spelling variations may be accepted as per local compliance rules.',
            'Ensure the IFSC Code matches the branch location if applicable.',
          ].map(
            (text) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: AppTypography.base.copyWith(
                        color: AppColors.cFF3B82F6,
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
          border: Border.all(color: AppColors.grey.shade100),
        ),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            size: 80,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _buildFileNameTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cFF33383F,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: AppTypography.base.copyWith(
          color: AppColors.white,
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
        Text(
          'Verify Document Details',
          style: AppTypography.base.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.cFF1A1D1F,
          ),
        ),
        SizedBox(height: 44),
        _buildSectionLabel('NAME'),
        SizedBox(height: 12),
        _buildTextField('Vikram Seth'),
        SizedBox(height: 32),
        _buildSectionLabel('BANK NAME'),
        SizedBox(height: 12),
        _buildTextField('HDFC Bank'),
        SizedBox(height: 32),
        _buildSectionLabel('ACCOUNT NUMBER'),
        SizedBox(height: 12),
        _buildTextField('50100422938104'),
        SizedBox(height: 32),
        _buildSectionLabel('IFSC CODE'),
        SizedBox(height: 12),
        _buildTextField('HDFC0001245'),
        SizedBox(height: 48),
        _buildSectionLabel('EVALUATION NOTES'),
        SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        SizedBox(height: 32),
        Divider(height: 1),
        SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: AppColors.cFFEF4444,
                icon: Icons.cancel_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: AppColors.cFF10B981,
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
            color: AppColors.cFFF8F9FD,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      _buildImageBox(),
                      SizedBox(height: 32),
                      _buildImageBox(),
                      SizedBox(height: 48),
                      _buildFileNameTag(fileTag),
                    ],
                  ),
                ),
                Positioned(right: 32, top: 32, child: _ZoomControls()),
              ],
            ),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: AppColors.grey.shade200),
        // Right Side: Verification Panel (Scrollable)
        SizedBox(
          width: 450,
          child: Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(40),
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
        Text(
          'Verify Document Details',
          style: AppTypography.base.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.cFF1A1D1F,
          ),
        ),
        SizedBox(height: 40),
        _buildSectionLabel(fieldLabel),
        SizedBox(height: 12),
        _buildTextField(fieldValue),
        SizedBox(height: 40),
        SizedBox(height: 32),
        _buildSectionLabel('EVALUATION NOTES'),
        SizedBox(height: 12),
        _buildTextArea('Enter your notes here...'),
        SizedBox(height: 32),
        Divider(height: 1),
        SizedBox(height: 32),
        _buildSectionLabel('REJECTION REASONS'),
        SizedBox(height: 24),
        ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionBtn(
                label: 'REJECT',
                color: AppColors.cFFEF4444,
                icon: Icons.cancel_outlined,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionBtn(
                label: 'APPROVE',
                color: AppColors.cFF10B981,
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
      style: AppTypography.base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        color: AppColors.cFF1A1D1F,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      style: AppTypography.base.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.cFF1A1D1F,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.cFF22C55E, width: 2),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 6,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.base.copyWith(color: AppColors.cFF9A9FA5, fontSize: 14),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.cFF22C55E, width: 2),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    final isSelected = _rejectionReasons[label] ?? false;
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            _rejectionReasons[label] = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? AppColors.cFF22C55E
                  : AppColors.grey.shade200,
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
                  activeColor: AppColors.cFF22C55E,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                label,
                style: AppTypography.base.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.black : AppColors.cFF6F767E,
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
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        textStyle: AppTypography.base.copyWith(
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
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBtn(Icons.zoom_in_outlined),
          SizedBox(height: 12),
          _buildBtn(Icons.zoom_out_outlined),
          SizedBox(height: 12),
          _buildBtn(Icons.refresh_rounded),
          SizedBox(height: 12),
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
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grey.shade100),
      ),
      child: Icon(icon, color: AppColors.cFF1A1D1F, size: 20),
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
      Radius.circular(12),
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




