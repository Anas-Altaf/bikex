import 'package:equatable/equatable.dart';

/// Represents a shipping address
class ShippingAddress extends Equatable {
  const ShippingAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
  });

  final String id;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  /// Full formatted address
  String get fullAddress => '$street, $city, $state $zipCode';

  /// Short address for display
  String get shortAddress => '$city, $state';

  ShippingAddress copyWith({
    String? id,
    String? name,
    String? phone,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    bool? isDefault,
  }) {
    return ShippingAddress(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    street,
    city,
    state,
    zipCode,
    isDefault,
  ];
}
