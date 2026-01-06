import 'package:bikex/checkout/models/models.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Card displaying shipping address with tap to select
class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard({
    required this.address,
    required this.onTap,
    super.key,
  });

  final ShippingAddress? address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppTheme.secondaryCardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.borderColor01,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Shipping',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Address',
              style: TextStyle(
                color: AppTheme.primaryUpColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Address content or placeholder
            if (address != null) ...[
              Text(
                address!.name,
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address!.fullAddress,
                style: const TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address!.phone,
                style: const TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 13,
                ),
              ),
            ] else ...[
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Tap to add address',
                  style: TextStyle(
                    color: AppTheme.textDescColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }
}
