import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_button.dart';
import 'package:bikex/core/widgets/toast.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

/// Text input field for coupon codes with Apply button
class CouponInputField extends StatefulWidget {
  const CouponInputField({
    required this.onApply,
    this.appliedCouponCode,
    this.errorMessage,
    super.key,
  });

  final void Function(String code) onApply;
  final String? appliedCouponCode;
  final String? errorMessage;

  @override
  State<CouponInputField> createState() => _CouponInputFieldState();
}

class _CouponInputFieldState extends State<CouponInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.appliedCouponCode ?? '');
  }

  @override
  void didUpdateWidget(CouponInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appliedCouponCode != oldWidget.appliedCouponCode &&
        widget.appliedCouponCode != null) {
      _controller.text = widget.appliedCouponCode!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasAppliedCoupon = widget.appliedCouponCode != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 44,
          decoration: AppTheme.boxDecoration01,

          child: Row(
            children: [
              // Text field
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: !hasAppliedCoupon,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: hasAppliedCoupon
                        ? widget.appliedCouponCode
                        : 'Enter coupon code',
                    hintStyle: TextStyle(
                      color: hasAppliedCoupon
                          ? AppTheme.textColor
                          : AppTheme.textDescColor,
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 16,
                    ),
                  ),
                ),
              ),

              PrimaryButton(
                title: 'Apply',
                onTap: () {
                  if (_controller.text.trim().isEmpty ||
                      widget.errorMessage != null) {
                    showToast(
                      message: widget.errorMessage!,
                      type: .error,
                    );
                    return;
                  }
                  widget.onApply(_controller.text.trim());
                },
              ),
            ],
          ),
        ),

        // // Error message
        // if (widget.errorMessage != null)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8, left: 16),
        //     child: Text(
        //       widget.errorMessage!,
        //       style: const TextStyle(
        //         color: Colors.red,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
