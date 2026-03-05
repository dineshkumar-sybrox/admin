import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../presentation/widgets/admin_scaffold.dart';

class DocumentVerificationPage extends StatelessWidget {
  final String driverName;
  final String documentId;

  const DocumentVerificationPage({
    super.key,
    this.driverName = 'Vikram Seth',
    this.documentId = '#DOC-8801',
  });

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'New Documents - $driverName',
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  6,
                  (index) => _buildVerificationContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: const TabBar(
        isScrollable: true,
        indicatorColor: AppColors.primary,
        indicatorWeight: 4,
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFF6F767E),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        tabs: [
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

  Widget _buildVerificationContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Side: Document Preview
        Expanded(flex: 2, child: _buildDocumentPreview()),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(width: 400, child: _buildVerificationPanel()),
      ],
    );
  }

  Widget _buildDocumentPreview() {
    return Container(
      padding: const EdgeInsets.all(32),
      color: const Color(0xFFF8F9FD),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildFileNameTag(),
            ],
          ),
          Positioned(right: 0, top: 0, child: _buildZoomControls()),
        ],
      ),
    );
  }

  Widget _buildFileNameTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF33383F),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Text(
        'DL_FRONT & Back_VIKRAM_SETH.JPG',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Column(
      children: [
        _buildActionButton(Icons.zoom_in_outlined),
        const SizedBox(height: 12),
        _buildActionButton(Icons.zoom_out_outlined),
        const SizedBox(height: 12),
        _buildActionButton(Icons.rotate_right_outlined),
        const SizedBox(height: 12),
        _buildActionButton(Icons.fullscreen_outlined),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF6F767E), size: 24),
    );
  }

  Widget _buildVerificationPanel() {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify Document Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 32),
          _buildFieldLabel('LICENSE NUMBER'),
          const SizedBox(height: 12),
          _buildTextField('DL-2023089421'),
          const SizedBox(height: 32),
          _buildFieldLabel('EVALUATION NOTES'),
          const SizedBox(height: 12),
          _buildTextArea('Enter your notes here...'),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),
          _buildFieldLabel('REJECTION REASONS'),
          const SizedBox(height: 16),
          _buildCheckboxItem('Expired Document'),
          _buildCheckboxItem('Blurry Image / Unreadable'),
          _buildCheckboxItem('Name Mismatch'),
          _buildCheckboxItem('Incorrect Document Type'),
          const Spacer(),
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
                  color: AppColors.primary,
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1A1D1F),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9EA5AD)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (val) {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F767E),
              ),
            ),
          ],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
