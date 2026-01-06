import 'package:equatable/equatable.dart';

/// Represents a discount coupon
class Coupon extends Equatable {
  const Coupon({
    required this.code,
    required this.discountPercent,
    this.description = '',
  });

  /// Coupon code (e.g., "BIKE10")
  final String code;

  /// Discount percentage (e.g., 10 for 10%)
  final double discountPercent;

  /// Optional description of the coupon
  final String description;

  /// Calculate discount amount for a given subtotal
  double calculateDiscount(double subtotal) {
    return subtotal * (discountPercent / 100);
  }

  @override
  List<Object?> get props => [code, discountPercent, description];
}
