import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Gradient checkout button with arrow icon
class GradientCheckoutButton extends StatelessWidget {
  const GradientCheckoutButton({
    required this.onPressed,
    this.label = 'Checkout',
    super.key,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 174,
        height: 44,
        decoration: AppTheme.boxDecoration01,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Arrow icon in gradient box
            Container(
              
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient2,
                borderRadius: BorderRadius.circular(10),
               
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 28,
              ),
            ),
        
            // Label
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textDescColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  
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
