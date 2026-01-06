import 'package:bikex/bikes/models/product.dart';
import 'package:bikex/cart/models/models.dart';
import 'package:bikex/cart/repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

/// Cubit for managing shopping cart state
class CartCubit extends Cubit<CartState> {
  CartCubit({required CartRepo cartRepo})
    : _cartRepo = cartRepo,
      super(const CartState());

  final CartRepo _cartRepo;

  /// Add a product to the cart
  /// If product already exists, increment quantity
  void addItem(Product product) {
    final existingItem = state.getItemByProductId(product.id);

    if (existingItem != null) {
      // Increment quantity of existing item
      incrementQuantity(product.id);
    } else {
      // Add new item
      final newItem = CartItem(product: product);
      emit(
        state.copyWith(
          items: [...state.items, newItem],
          clearError: true,
        ),
      );
    }
  }

  /// Remove a product from the cart entirely
  void removeItem(String productId) {
    final updatedItems = state.items
        .where((item) => item.product.id != productId)
        .toList();
    emit(state.copyWith(items: updatedItems, clearError: true));
  }

  /// Increment quantity of a cart item
  void incrementQuantity(String productId) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems, clearError: true));
  }

  /// Decrement quantity of a cart item
  /// Removes item if quantity reaches 0
  void decrementQuantity(String productId) {
    final item = state.getItemByProductId(productId);
    if (item == null) return;

    if (item.quantity <= 1) {
      // Remove item if quantity would be 0
      removeItem(productId);
    } else {
      // Decrement quantity
      final updatedItems = state.items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(quantity: item.quantity - 1);
        }
        return item;
      }).toList();
      emit(state.copyWith(items: updatedItems, clearError: true));
    }
  }

  /// Apply a coupon code
  void applyCoupon(String code) {
    if (code.isEmpty) {
      emit(
        state.copyWith(
          couponError: 'Please enter a coupon code',
          clearCoupon: true,
        ),
      );
      return;
    }

    final coupon = _cartRepo.getCouponByCode(code);
    if (coupon != null) {
      emit(
        state.copyWith(
          appliedCoupon: coupon,
          clearError: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          couponError: 'Invalid coupon code',
          clearCoupon: true,
        ),
      );
    }
  }

  /// Remove the applied coupon
  void removeCoupon() {
    emit(state.copyWith(clearCoupon: true, clearError: true));
  }

  /// Clear all items from the cart
  void clearCart() {
    emit(const CartState());
  }
}
