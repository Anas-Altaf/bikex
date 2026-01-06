import 'package:bikex/checkout/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_state.dart';

/// Cubit for managing checkout flow
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState()) {
    _loadMockAddresses();
  }

  /// Load mock addresses for demo
  void _loadMockAddresses() {
    const mockAddresses = [
      ShippingAddress(
        id: '1',
        name: 'John Doe',
        phone: '+1 234 567 8900',
        street: '123 Main Street',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
        isDefault: true,
      ),
      ShippingAddress(
        id: '2',
        name: 'John Doe',
        phone: '+1 234 567 8900',
        street: '456 Oak Avenue',
        city: 'Los Angeles',
        state: 'CA',
        zipCode: '90001',
      ),
    ];

    // Set the default address as selected
    final defaultAddress = mockAddresses.firstWhere(
      (a) => a.isDefault,
      orElse: () => mockAddresses.first,
    );

    emit(
      state.copyWith(
        addresses: mockAddresses,
        selectedAddress: defaultAddress,
      ),
    );
  }

  /// Select an address for shipping
  void selectAddress(ShippingAddress address) {
    emit(state.copyWith(selectedAddress: address));
  }

  /// Add a new address
  void addAddress(ShippingAddress address) {
    final updatedAddresses = [...state.addresses, address];
    emit(
      state.copyWith(
        addresses: updatedAddresses,
        selectedAddress: address,
      ),
    );
  }

  /// Place the order
  Future<void> placeOrder() async {
    emit(state.copyWith(isLoading: true));

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 500));

    emit(
      state.copyWith(
        isLoading: false,
        orderPlaced: true,
      ),
    );
  }

  /// Reset order state
  void resetOrder() {
    emit(state.copyWith(orderPlaced: false));
  }
}
