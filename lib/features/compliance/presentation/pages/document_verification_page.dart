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
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: 1,
    ); // Vehicle RC is index 1
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
                _buildPlaceholderTab('Driving License'),
                _buildVerificationContent(),
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

  Widget _buildPlaceholderTab(String name) {
    return Center(child: Text('$name content coming soon...'));
  }

  Widget _buildVerificationContent() {
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
                      _buildFileNameTag('RC_FRONT & Back_VIKRAM_SETH.JPG'),
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
              child: _buildVerificationPanel(),
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

  Widget _buildVerificationPanel() {
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
        _buildSectionLabel('VEHICLE NUMBER'),
        const SizedBox(height: 12),
        _buildTextField('TN02 BY4447'),
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
