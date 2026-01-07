import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bikex/cart/cubit/cubit.dart';
import 'package:bikex/checkout/cubit/cubit.dart';
import 'package:bikex/checkout/widgets/widgets.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/custom_app_bar.dart';
import 'package:bikex/core/widgets/slide_to_action_button.dart';
import 'package:bikex/core/widgets/toast.dart';
import 'package:bikex/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

/// Checkout page with shipping address and slide to proceed
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(),
      child: const _CheckoutPageContent(),
    );
  }
}

class _CheckoutPageContent extends StatelessWidget {
  const _CheckoutPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'Checkout',
        iconType: .cross,
        onTap: () => context.pop(),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.orderPlaced) {
            // Get cart state before clearing
            final cartState = context.read<CartCubit>().state;

            // Add order to orders cubit
            context.read<OrdersCubit>().addOrder(
              items: cartState.items,
              total: cartState.total,
            );

            // Clear cart
            context.read<CartCubit>().clearCart();

            showToast(
              message: 'Order placed successfully!',
              type: ToastificationType.success,
            );
            // Navigate to home with tab=0 to go to Bikes tab
            context.go('/home?tab=0');
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                const SizedBox(height: 20),

                // Shipping address card with animation
                FadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: ShippingAddressCard(
                    address: state.selectedAddress,
                    onTap: () => AddressBottomSheet.show(context),
                  ),
                ),

                const Spacer(),

                // Slide to proceed button with animation
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SlideToActionButton(
                      label: 'Proceed',
                      disabled: !state.hasSelectedAddress,
                      onSlideComplete: () {
                        unawaited(context.read<CheckoutCubit>().placeOrder());
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
