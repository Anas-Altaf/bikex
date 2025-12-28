import 'package:bikex/bikes/models/models.dart';

/// Repository for managing bike products
class ProductsRepo {
  ProductsRepo();

  /// Mock products data with longer descriptions
  static final List<Product> _mockProducts = [
    const Product(
      id: '1',
      name: 'Thunder Bolt',
      category: 'Electric',
      price: 1299.99,
      description: '''
The Thunder Bolt is our flagship electric bike designed for riders who demand both power and efficiency. Featuring a state-of-the-art 500W brushless motor that delivers smooth, silent acceleration up to 28 mph.

The integrated 48V lithium-ion battery provides an impressive 80km range on a single charge, making it perfect for daily commutes and weekend adventures alike. The sleek Midnight Blue frame is crafted from lightweight aluminum alloy with internal cable routing for a clean, modern aesthetic.

Advanced features include regenerative braking, LCD display with trip computer, USB charging port, and integrated LED lighting system. Whether you're conquering hills or cruising through city streets, the Thunder Bolt delivers an unparalleled electric riding experience.''',
      imageAsset: 'assets/images/cycle_01.png',
      specifications: {
        'Color': 'Midnight Blue',
        'Size': 'Medium',
        'Weight': '22 kg',
        'Range': '80 km',
        'Motor': '500W',
        'Battery': '48V 14Ah Lithium-ion',
        'Top Speed': '28 mph',
        'Charge Time': '4-5 hours',
      },
    ),
    const Product(
      id: '2',
      name: 'Road Master',
      category: 'Road',
      price: 899.99,
      description: '''
The Road Master is engineered for speed enthusiasts who crave performance without compromise. Built around a ultra-lightweight carbon fiber frame weighing just 8.5 kg, this bike is designed to fly.

The aerodynamic tube profiles minimize drag while the responsive geometry puts you in an aggressive, efficient riding position. Equipped with Shimano 105 22-speed groupset for precise, reliable shifting across any terrain.

Premium components include Continental Grand Prix tires for exceptional grip and low rolling resistance, Mavic Aksium wheelset, and ergonomic handlebar tape. Whether training for your next race or enjoying a spirited weekend ride, the Road Master delivers pure road cycling excellence.''',
      imageAsset: 'assets/images/cycle_02.png',
      specifications: {
        'Color': 'Racing Red',
        'Size': 'Large',
        'Weight': '8.5 kg',
        'Frame': 'Carbon Fiber',
        'Gears': '22 Speed Shimano 105',
        'Wheelset': 'Mavic Aksium',
        'Brakes': 'Dual-pivot caliper',
        'Tires': 'Continental GP 25c',
      },
    ),
    const Product(
      id: '3',
      name: 'Trail Blazer',
      category: 'Mountain',
      price: 1099.99,
      description: '''
Conquer any terrain with the Trail Blazer, our most versatile mountain bike designed for serious off-road adventures. The full suspension system with 150mm front and 140mm rear travel absorbs everything from roots and rocks to drops and jumps.

The hydroformed aluminum frame strikes the perfect balance between strength and weight, while the slack 66-degree head angle provides confident handling on steep descents. Wide 29-inch tubeless-ready wheels roll over obstacles with ease.

Features include SRAM GX Eagle 12-speed drivetrain, hydraulic disc brakes with 180mm rotors, dropper seatpost ready frame, and internal cable routing. Take on the gnarliest trails with confidence.''',
      imageAsset: 'assets/images/cycle_03.png',
      specifications: {
        'Color': 'Forest Green',
        'Size': 'Medium',
        'Weight': '14 kg',
        'Suspension': 'Full - 150mm/140mm',
        'Tires': '29 inch Tubeless',
        'Drivetrain': 'SRAM GX Eagle 12-speed',
        'Brakes': 'Hydraulic Disc 180mm',
        'Head Angle': '66 degrees',
      },
    ),
    const Product(
      id: '4',
      name: 'City Cruiser',
      category: 'Urban',
      price: 599.99,
      description: '''
The City Cruiser redefines urban mobility with its perfect blend of comfort, style, and practicality. The step-through aluminum frame makes mounting and dismounting effortless, while the upright riding position reduces strain on your back and neck.

Designed for the daily commuter, it features a spacious rear basket, full-length fenders to keep you dry, and an integrated LED lighting system powered by the hub dynamo - no batteries needed. The puncture-resistant tires and low-maintenance internal 7-speed hub ensure a worry-free ride.

Additional features include a cushioned saddle with suspension seatpost, ergonomic grips, and a kickstand. Available in Matte Black, the City Cruiser is your reliable partner for everyday urban adventures.''',
      imageAsset: 'assets/images/cycle_04.png',
      specifications: {
        'Color': 'Matte Black',
        'Size': 'Medium',
        'Weight': '12 kg',
        'Basket': 'Included',
        'Lights': 'LED Front & Rear (Dynamo)',
        'Gears': '7-speed Internal Hub',
        'Fenders': 'Full Length',
        'Tires': 'Puncture Resistant',
      },
    ),
    const Product(
      id: '5',
      name: 'Volt Rider',
      category: 'Electric',
      price: 1499.99,
      description: '''
Experience the future of cycling with the Volt Rider, our premium electric bike packed with smart technology. The powerful 750W mid-drive motor provides natural, intuitive assistance that feels like an extension of your own power.

The high-capacity 52V battery delivers an exceptional 100km range, while the smart connectivity allows you to track rides, adjust settings, and receive OTA updates through the companion app. The torque sensor provides responsive, natural-feeling pedal assist across 5 power levels.

Premium features include integrated GPS tracking, anti-theft alarm, automatic lights, and a color LCD display. The sleek silver frame houses all electronics seamlessly, creating a sophisticated urban machine that turns heads.''',
      imageAsset: 'assets/images/cycle_01.png',
      specifications: {
        'Color': 'Silver',
        'Size': 'Large',
        'Weight': '24 kg',
        'Range': '100 km',
        'Motor': '750W Mid-drive',
        'Battery': '52V 17.5Ah',
        'Display': 'Color LCD',
        'Connectivity': 'Bluetooth/GPS',
      },
    ),
    const Product(
      id: '6',
      name: 'Speed Demon',
      category: 'Road',
      price: 1199.99,
      description: '''
The Speed Demon is built for one purpose: pure speed. Every component has been selected and optimized to shave seconds off your personal best. The aero-optimized carbon frame weighs a mere 7.8 kg and features truncated airfoil tube shapes.

Shimano Ultegra R8000 22-speed groupset delivers race-proven shifting performance, while the full carbon fork and seatpost further reduce weight and absorb road vibrations. Deep-section Fulcrum Racing wheels cut through the air with minimal resistance.

Race-ready features include hidden cable routing, direct-mount brakes, and integration points for power meters. Whether competing in crits or chasing Strava KOMs, the Speed Demon is your weapon of choice.''',
      imageAsset: 'assets/images/cycle_02.png',
      specifications: {
        'Color': 'White',
        'Size': 'Small',
        'Weight': '7.8 kg',
        'Frame': 'Aero Carbon Fiber',
        'Gears': '22 Speed Ultegra R8000',
        'Wheelset': 'Fulcrum Racing 50mm',
        'Brakes': 'Direct-mount caliper',
        'Fork': 'Full Carbon Aero',
      },
    ),
    const Product(
      id: '7',
      name: 'Rock Hopper',
      category: 'Mountain',
      price: 949.99,
      description: '''
Built tough for riders who push limits, the Rock Hopper is an aggressive hardtail designed for technical terrain. The 130mm RockShox Recon fork soaks up impacts while the rigid rear end delivers efficient power transfer for climbing.

The geometry is optimized for modern trail riding with a short stem, wide bars, and compatible with 1x drivetrains. The SRAM SX Eagle 12-speed provides a huge gear range for any gradient, while the powerful Shimano hydraulic disc brakes inspire confidence on steep descents.

Tubeless-ready 27.5-inch wheels offer a nimble, playful feel, perfect for tight switchbacks and technical features. Internal dropper post routing keeps your options open for future upgrades.''',
      imageAsset: 'assets/images/cycle_03.png',
      specifications: {
        'Color': 'Orange',
        'Size': 'Large',
        'Weight': '15 kg',
        'Suspension': 'Front 130mm RockShox',
        'Tires': '27.5 inch 2.4" wide',
        'Drivetrain': 'SRAM SX Eagle 12-speed',
        'Brakes': 'Shimano Hydraulic Disc',
        'Frame': 'Aluminum Alloy',
      },
    ),
    const Product(
      id: '8',
      name: 'Urban Glide',
      category: 'Urban',
      price: 449.99,
      description: '''
Minimalist design meets maximum functionality in the Urban Glide. This stylish city bike features a classic cream colorway with brown leather accents that evoke vintage charm while delivering modern performance.

The lightweight steel frame provides a smooth, comfortable ride, while the swept-back handlebars and cushioned saddle ensure relaxed ergonomics for leisurely rides. The classic brass bell adds a touch of nostalgia and alerts pedestrians gracefully.

Practical features include matching cream fenders, a front basket ready mount, and a sturdy rear rack for panniers. The low-maintenance single-speed drivetrain with coaster brake keeps things simple and reliable.''',
      imageAsset: 'assets/images/cycle_04.png',
      specifications: {
        'Color': 'Cream',
        'Size': 'Medium',
        'Weight': '11 kg',
        'Fenders': 'Included',
        'Bell': 'Classic Brass',
        'Frame': 'Chromoly Steel',
        'Drivetrain': 'Single Speed',
        'Brakes': 'Front caliper + Coaster',
      },
    ),
  ];

  /// Get all products
  List<Product> getProducts() {
    return List.unmodifiable(_mockProducts);
  }

  /// Get product by ID
  Product? getProductById(String id) {
    try {
      return _mockProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get products by category
  List<Product> getProductsByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      return getProducts();
    }
    return _mockProducts
        .where(
          (p) => p.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  /// Get unique categories
  List<String> getCategories() {
    final categories = _mockProducts.map((p) => p.category).toSet().toList();
    return ['All', ...categories];
  }
}
