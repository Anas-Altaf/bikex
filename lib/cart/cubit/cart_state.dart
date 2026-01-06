part of 'cart_cubit.dart';

/// State for the shopping cart
class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.appliedCoupon,
    this.couponError,
  });

  /// List of items in the cart
  final List<CartItem> items;

  /// Currently applied coupon (if any)
  final Coupon? appliedCoupon;

  /// Error message if coupon validation fails
  final String? couponError;

  /// Total number of items in cart (sum of quantities)
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Number of unique products in cart
  int get uniqueItemCount => items.length;

  /// Subtotal before discounts
  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Delivery fee (free for orders over $50)
  double get deliveryFee => subtotal >= 50 ? 0 : 9.99;

  /// Discount amount based on applied coupon
  double get discount => appliedCoupon?.calculateDiscount(subtotal) ?? 0;

  /// Discount percentage for display
  double get discountPercent => appliedCoupon?.discountPercent ?? 0;

  /// Final total after discounts and delivery
  double get total => subtotal - discount + deliveryFee;

  /// Whether the cart is empty
  bool get isEmpty => items.isEmpty;

  /// Whether a coupon is currently applied
  bool get hasCoupon => appliedCoupon != null;

  /// Check if cart qualifies for free shipping
  bool get hasFreeShipping => subtotal >= 50;

  /// Get cart item by product ID
  CartItem? getItemByProductId(String productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (_) {
      return null;
    }
  }

  /// Create a copy with updated values
  CartState copyWith({
    List<CartItem>? items,
    Coupon? appliedCoupon,
    String? couponError,
    bool clearCoupon = false,
    bool clearError = false,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      couponError: clearError ? null : (couponError ?? this.couponError),
    );
  }

  @override
  List<Object?> get props => [items, appliedCoupon, couponError];
}
