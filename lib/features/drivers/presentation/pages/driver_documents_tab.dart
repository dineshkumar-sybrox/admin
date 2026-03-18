import 'package:flutter/material.dart';
import 'package:admin/core/theme/app_typography.dart';
import 'package:admin/core/theme/app_colors.dart';

class DriverDocumentsTab extends StatelessWidget {
  const DriverDocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _DocumentGrid(),
        ],
      ),
    );
  }
}

class _DocumentGrid extends StatelessWidget {
  const _DocumentGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 40,
      children: const [
        _DocumentTile(label: 'Driving License'),
        _DocumentTile(label: 'Vehicle RC'),
        _DocumentTile(label: 'Aadhar Card'),
        _DocumentTile(label: 'Pan Card'),
        _DocumentTile(label: 'Bank Details'),
      ],
    );
  }
}

class _DocumentTile extends StatelessWidget {
  final String label;

  const _DocumentTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _DocumentPreviewDialog(label: label),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cFFE5E7EB),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.base.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentPreviewDialog extends StatelessWidget {
  final String label;

  const _DocumentPreviewDialog({required this.label});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 500),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.2),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            _PreviewBox(),
            const SizedBox(height: 16),
            _PreviewBox(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cFF1F2937,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'DL_FRONT & BACK_VIKRAM_SETH.jpg',
                style: AppTypography.base.copyWith(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 120,
              height: 36,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.cFFE5E7EB),
                  ),
                ),
                child: Text(
                  'Back',
                  style: AppTypography.base.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cFFE5E7EB),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
