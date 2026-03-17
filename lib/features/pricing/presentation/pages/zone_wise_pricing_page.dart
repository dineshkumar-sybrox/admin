import 'package:flutter/material.dart';
import '../widgets/zone_map_widget.dart';

class ZoneWisePricingPage extends StatefulWidget {
  const ZoneWisePricingPage({super.key});

  @override
  State<ZoneWisePricingPage> createState() => _ZoneWisePricingPageState();
}

class _ZoneWisePricingPageState extends State<ZoneWisePricingPage> {
  bool cabEnabled = true;
  bool autoEnabled = true;
  bool bikeEnabled = true;
  bool gstApplyTotal = true;
  bool dynamicPlatformFee = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSelectLocation(),
          const SizedBox(height: 24),
          _buildBasePriceConfiguration(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildGstConfiguration()),
              const SizedBox(width: 24),
              Expanded(child: _buildPlatformFee()),
            ],
          ),
          const SizedBox(height: 40),
          _buildFooter(),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Last audited by Admin on FEB 24, 2026 - 04:30 pm',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zone-wise Pricing',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1C1E),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Configure base rates, taxes, and platform fees for specific operational zones.',
          style: TextStyle(color: Color(0xFF5E6366), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSelectLocation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF00A86B),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Select Location',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                _buildDropdown('Target City'),
                const SizedBox(width: 16),
                _buildDropdown('Target Area'),
              ],
            ),
            const SizedBox(height: 24),
            const ZoneMapWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  Widget _buildBasePriceConfiguration() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.local_offer_outlined, color: Color(0xFF00A86B)),
                SizedBox(width: 8),
                Text(
                  'Base Price Configuration',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildVehicleCard(
                    icon: Icons.directions_car,
                    label: 'CAB',
                    isEnabled: cabEnabled,
                    onToggle: (v) => setState(() => cabEnabled = v),
                    minFare: '120',
                    basePrice: '50',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVehicleCard(
                    icon: Icons.electric_rickshaw,
                    label: 'AUTO RICKSHAW',
                    isEnabled: autoEnabled,
                    onToggle: (v) => setState(() => autoEnabled = v),
                    minFare: '35',
                    basePrice: '12',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVehicleCard(
                    icon: Icons.directions_bike,
                    label: 'BIKE TAXI',
                    isEnabled: bikeEnabled,
                    onToggle: (v) => setState(() => bikeEnabled = v),
                    minFare: '25',
                    basePrice: '8',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard({
    required IconData icon,
    required String label,
    required bool isEnabled,
    required Function(bool) onToggle,
    required String minFare,
    required String basePrice,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF1E293B)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                ),
              ),
              const Spacer(),
              Switch(
                value: isEnabled,
                onChanged: onToggle,
                activeColor: const Color(0xFF00A86B),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInputField('MIN. FARE (2 KMS)', minFare, prefix: '₹'),
          const SizedBox(height: 12),
          _buildInputField('BASE PRICE PER 1 KM', basePrice, prefix: '₹'),
        ],
      ),
    );
  }

  Widget _buildGstConfiguration() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_balance_outlined,
                  color: Color(0xFF00A86B),
                ),
                const SizedBox(width: 8),
                const Text(
                  'GST Configuration',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                _buildBadge(
                  'PER ZONE',
                  const Color(0xFFDCFCE7),
                  const Color(0xFF15803D),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInputField('Tax Percentage (%)', '5', suffix: '%'),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: gstApplyTotal,
                  onChanged: (v) => setState(() => gstApplyTotal = v!),
                  activeColor: const Color(0xFF00A86B),
                ),
                const Text(
                  'Apply to total fare (Base + Distance)',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformFee() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  color: Color(0xFF00A86B),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Platform Fee',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                _buildBadge(
                  'GLOBAL',
                  const Color(0xFFDBEAFE),
                  const Color(0xFF1D4ED8),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInputField('Fixed Service Fee', '15', prefix: '₹'),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: dynamicPlatformFee,
                  onChanged: (v) => setState(() => dynamicPlatformFee = v!),
                  activeColor: const Color(0xFF00A86B),
                ),
                const Text(
                  'Apply dynamically based on peak hours',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String initialValue, {
    String? prefix,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                Text(prefix, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: initialValue),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 8),
                Text(suffix, style: const TextStyle(color: Colors.grey)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          child: const Text(
            'Reset Changes',
            style: TextStyle(color: Color(0xFF1E293B)),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A86B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Update Pricing',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
