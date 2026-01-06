part of 'checkout_cubit.dart';

/// State for the checkout flow
class CheckoutState extends Equatable {
  const CheckoutState({
    this.addresses = const [],
    this.selectedAddress,
    this.isLoading = false,
    this.orderPlaced = false,
  });

  final List<ShippingAddress> addresses;
  final ShippingAddress? selectedAddress;
  final bool isLoading;
  final bool orderPlaced;

  /// Whether an address is selected
  bool get hasSelectedAddress => selectedAddress != null;

  CheckoutState copyWith({
    List<ShippingAddress>? addresses,
    ShippingAddress? selectedAddress,
    bool? isLoading,
    bool? orderPlaced,
    bool clearSelectedAddress = false,
  }) {
    return CheckoutState(
      addresses: addresses ?? this.addresses,
      selectedAddress: clearSelectedAddress
          ? null
          : (selectedAddress ?? this.selectedAddress),
      isLoading: isLoading ?? this.isLoading,
      orderPlaced: orderPlaced ?? this.orderPlaced,
    );
  }

  @override
  List<Object?> get props => [
    addresses,
    selectedAddress,
    isLoading,
    orderPlaced,
  ];
}
