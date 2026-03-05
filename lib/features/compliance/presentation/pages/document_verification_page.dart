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

class _DocumentVerificationPageState extends State<DocumentVerificationPage> {
  final Map<String, bool> _rejectionReasons = {
    'Expired Document': false,
    'Blurry Image / Unreadable': false,
    'Name Mismatch': false,
    'Incorrect Document Type': false,
  };

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'New Documents - ${widget.driverName}',
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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      width: double.infinity,
      child: const TabBar(
        isScrollable: true,
        indicatorColor: AppColors.primary,
        indicatorWeight: 4,
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xFF6F767E),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Outfit',
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Outfit',
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
        Expanded(flex: 3, child: _buildDocumentPreview()),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel
        SizedBox(width: 450, child: _buildVerificationPanel()),
      ],
    );
  }

  Widget _buildDocumentPreview() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: const Color(0xFFF8F9FD),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: _buildImageBox(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: _buildImageBox(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildFileNameTag(),
              ],
            ),
          ),
          const SizedBox(width: 32),
          _buildZoomControls(),
        ],
      ),
    );
  }

  Widget _buildImageBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            size: 64,
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }

  Widget _buildFileNameTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF33383F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'DL_FRONT & Back_VIKRAM_SETH.JPG',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildActionButton(Icons.zoom_in_outlined),
        const SizedBox(height: 16),
        _buildActionButton(Icons.zoom_out_outlined),
        const SizedBox(height: 16),
        _buildActionButton(Icons.refresh_rounded),
        const SizedBox(height: 16),
        _buildActionButton(Icons.fullscreen_rounded),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 54,
      height: 54,
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
      child: Icon(icon, color: const Color(0xFF6F767E), size: 24),
    );
  }

  Widget _buildVerificationPanel() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify Document Details',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1D1F),
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 48),
          _buildFieldLabel('LICENSE NUMBER'),
          const SizedBox(height: 12),
          _buildTextField('DL-2023089421'),
          const SizedBox(height: 32),
          _buildFieldLabel('EVALUATION NOTES'),
          const SizedBox(height: 12),
          _buildTextArea('Enter your notes here...'),
          const SizedBox(height: 40),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 40),
          _buildFieldLabel('REJECTION REASONS'),
          const SizedBox(height: 24),
          ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
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
              const SizedBox(width: 20),
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
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1A1D1F),
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFF1A1D1F),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint) {
    return TextField(
      maxLines: 7,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBDC2C8), fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
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
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? AppColors.primary.withOpacity(0.04)
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
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
