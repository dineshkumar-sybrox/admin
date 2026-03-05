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
        // Left Side: Document Preview (Scrollable)
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: _buildDocumentPreview(),
          ),
        ),
        // Vertical Divider
        Container(width: 1, color: Colors.grey.shade200),
        // Right Side: Verification Panel (Scrollable)
        SizedBox(
          width: 450,
          child: SingleChildScrollView(child: _buildVerificationPanel()),
        ),
      ],
    );
  }

  Widget _buildDocumentPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildImageBox('FRONT VIEW'),
              const SizedBox(height: 40),
              _buildImageBox('BACK VIEW'),
              const SizedBox(height: 48),
              _buildFileNameTag(),
            ],
          ),
        ),
        const SizedBox(width: 32),
        _buildZoomControls(),
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
          aspectRatio: 1.4, // Slightly larger looking
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

  Widget _buildFileNameTag() {
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
      child: const Text(
        'DL_FRONT & Back_VIKRAM_SETH.JPG',
        style: TextStyle(
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

  Widget _buildVerificationPanel() {
    return Container(
      padding: const EdgeInsets.all(48),
      color: Colors.white,
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
          _buildFieldLabel('LICENSE NUMBER'),
          const SizedBox(height: 16),
          _buildTextField('DL-2023089421'),
          const SizedBox(height: 40),
          _buildFieldLabel('EVALUATION NOTES'),
          const SizedBox(height: 16),
          _buildTextArea('Enter your notes here...'),
          const SizedBox(height: 48),
          const Divider(height: 1, thickness: 1.5),
          const SizedBox(height: 48),
          _buildFieldLabel('REJECTION REASONS'),
          const SizedBox(height: 28),
          ..._rejectionReasons.keys.map((reason) => _buildCheckboxItem(reason)),
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
      ),
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
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
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
