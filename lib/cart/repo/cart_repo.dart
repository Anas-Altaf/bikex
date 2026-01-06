import 'package:bikex/cart/models/models.dart';

/// Interface for cart repository
abstract class CartRepo {
  /// Get a coupon by its code
  Coupon? getCouponByCode(String code);

  /// Get all available coupons (for admin/testing)
  List<Coupon> getAllCoupons();
}

/// Mock implementation of CartRepo with hardcoded coupons
class MockCartRepo implements CartRepo {
  MockCartRepo();

  /// Mock coupons data
  static const List<Coupon> _mockCoupons = [
    Coupon(
      code: 'BIKE10',
      discountPercent: 10,
      description: '10% off your order',
    ),
    Coupon(
      code: 'BIKE20',
      discountPercent: 20,
      description: '20% off your order',
    ),
    Coupon(
      code: 'BIKE30',
      discountPercent: 30,
      description: '30% off your order',
    ),
    Coupon(
      code: 'WELCOME',
      discountPercent: 15,
      description: '15% off for new customers',
    ),
    Coupon(
      code: 'SUMMER',
      discountPercent: 25,
      description: 'Summer sale - 25% off',
    ),
  ];

  @override
  Coupon? getCouponByCode(String code) {
    try {
      return _mockCoupons.firstWhere(
        (c) => c.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  List<Coupon> getAllCoupons() {
    return List.unmodifiable(_mockCoupons);
  }
}
