import 'package:equatable/equatable.dart';

/// Product model for bikes
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    this.images = const [],
    this.specifications = const {},
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  
  /// List of image assets for product carousel
  final List<String> images;

  /// Flexible specifications map (color, size, weight, etc.)
  final Map<String, String> specifications;

  /// Copy with method for immutability
  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? description,
    List<String>? images,
    Map<String, String>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      specifications: specifications ?? this.specifications,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        price,
        description,
        images,
        specifications,
      ];
}
