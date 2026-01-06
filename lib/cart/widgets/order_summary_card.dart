import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Card displaying order summary with subtotal, delivery, discount, and total
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.discountPercent,
    required this.total,
    required this.hasFreeShipping,
    super.key,
  });

  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double discountPercent;
  final double total;
  final bool hasFreeShipping;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Free shipping message
        if (hasFreeShipping)
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(
                'Your bag qualifies for free shipping',
                style: TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 15,
                ),
              ),
            ),
          ),

        // Subtotal row
        _SummaryRow(
          label: 'Subtotal:',
          value: '\$${subtotal.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),

        // Delivery fee row
        _SummaryRow(
          label: 'Delivery Fee:',
          value: deliveryFee == 0
              ? r'$0'
              : '\$${deliveryFee.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),

        // Discount row
        _SummaryRow(
          label: 'Discount:',
          value: discountPercent > 0 ? '${discountPercent.toInt()}%' : '0%',
          valueColor: discountPercent > 0 ? AppTheme.primaryUpColor : null,
        ),
        const SizedBox(height: 16),

        // Total row
        _SummaryRow(
          label: 'Total:',
          value: '\$${total.toStringAsFixed(2)}',
          isTotal: true,
        ),
      ],
    );
  }
}

/// Individual summary row
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textColor.withAlpha((2.55 * 87).toInt()),
            fontSize:15,
            fontWeight: .bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
                valueColor ??
                (isTotal ? AppTheme.primaryUpColor : AppTheme.textDescColor),
            fontSize: isTotal ? 17 : 15,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
