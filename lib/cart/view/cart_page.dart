import 'package:bikex/cart/cubit/cubit.dart';
import 'package:bikex/cart/widgets/widgets.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shopping cart page displaying cart items, coupon input, and order summary
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.isEmpty) {
          return const _EmptyCartView();
        }

        return Column(
          children: [
            // Cart items list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const Divider(
                  color: AppTheme.borderColor01,
                  height: 0.5,
                ),

                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartItemCard(
                    cartItem: item,
                    onIncrement: () {
                      context.read<CartCubit>().incrementQuantity(
                        item.product.id,
                      );
                    },
                    onDecrement: () {
                      context.read<CartCubit>().decrementQuantity(
                        item.product.id,
                      );
                    },
                  );
                },
              ),
            ),

            // Bottom section with coupon and summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Coupon input
                  CouponInputField(
                    onApply: (code) {
                      context.read<CartCubit>().applyCoupon(code);
                    },
                    appliedCouponCode: state.appliedCoupon?.code,
                    errorMessage: state.couponError,
                  ),
                  const SizedBox(height: 20),

                  // Order summary
                  OrderSummaryCard(
                    subtotal: state.subtotal,
                    deliveryFee: state.deliveryFee,
                    discount: state.discount,
                    discountPercent: state.discountPercent,
                    total: state.total,
                    hasFreeShipping: state.hasFreeShipping,
                  ),
                  const SizedBox(height: 24),

                  // Checkout button
                  GradientCheckoutButton(
                    onPressed: () {
                      // TODO: Navigate to checkout
                      showToast(
                        message: 'Proceeding to checkout...',
                        type: .success,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Empty cart view
class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundSurfaceColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: AppTheme.textDescColor,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add some products to get started',
            style: TextStyle(
              color: AppTheme.textDescColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
