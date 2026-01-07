import 'package:bikex/bikes/models/models.dart';
import 'package:bikex/bikes/repo/products_repo_interface.dart';

/// Mock implementation of ProductsRepo for development/testing
/// Uses hardcoded product data
class MockProductsRepo implements ProductsRepo {
  MockProductsRepo();

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
      images: [
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
      ],
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
      images: [
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
      ],
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
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
      ],
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
    // Additional Electric bikes
    const Product(
      id: '9',
      name: 'Eco Swift',
      category: 'Electric',
      price: 1099.99,
      description: '''
The Eco Swift is the perfect entry point into electric cycling, offering premium features at an accessible price. The efficient 350W hub motor provides smooth assistance up to 20 mph, ideal for urban commuting.

The compact 36V battery integrates seamlessly into the downtube, providing 60km range while maintaining a sleek appearance. Quick-release battery allows convenient charging at home or office.

Features include a simple LED control panel, front suspension fork, and Shimano 7-speed gearing for versatility. The Eco Swift proves that sustainable transportation doesn't have to break the bank.''',
      images: [
        'assets/images/cycle_01.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_01.png',
      ],
      specifications: {
        'Color': 'Pearl White',
        'Size': 'Medium',
        'Weight': '19 kg',
        'Range': '60 km',
        'Motor': '350W Hub',
        'Battery': '36V 10Ah',
        'Top Speed': '20 mph',
        'Gears': 'Shimano 7-speed',
      },
    ),
    const Product(
      id: '10',
      name: 'Power Surge',
      category: 'Electric',
      price: 1899.99,
      description: '''
The Power Surge is built for riders who want maximum power and range. The class 3 capable 1000W motor delivers exhilarating acceleration and hill-climbing ability that rivals motorcycles.

Dual battery capability extends range up to 160km, perfect for long-distance adventures. The fat tire design provides stability and traction on any surface, from city streets to beach sand.

Advanced features include full suspension, hydraulic disc brakes, and a premium color display with navigation. The Power Surge is the ultimate electric adventure machine.''',
      images: [
        'assets/images/cycle_03.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_03.png',
      ],
      specifications: {
        'Color': 'Stealth Black',
        'Size': 'Large',
        'Weight': '32 kg',
        'Range': '160 km (dual battery)',
        'Motor': '1000W Hub',
        'Battery': '48V 20Ah (x2)',
        'Top Speed': '32 mph',
        'Tires': '4" Fat Tires',
      },
    ),
    // Additional Road bikes
    const Product(
      id: '11',
      name: 'Aero Elite',
      category: 'Road',
      price: 1599.99,
      description: '''
The Aero Elite represents the pinnacle of aerodynamic engineering. Wind tunnel tested tube profiles reduce drag by 15% compared to traditional round tubes.

The full Shimano Ultegra Di2 electronic groupset provides instant, precise shifting at the touch of a button. Deep carbon wheels enhance the aero advantage while remaining stable in crosswinds.

Competition-ready features include integrated aero cockpit, hidden brake calipers, and compatibility with power meters. The Aero Elite is your ticket to the podium.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Jet Black',
        'Size': 'Medium',
        'Weight': '7.5 kg',
        'Frame': 'Aero Carbon T800',
        'Groupset': 'Ultegra Di2 Electronic',
        'Wheelset': 'Carbon 60mm',
        'Brakes': 'Integrated Aero',
        'Cockpit': 'Integrated Carbon',
      },
    ),
    const Product(
      id: '12',
      name: 'Endurance Pro',
      category: 'Road',
      price: 999.99,
      description: '''
The Endurance Pro is designed for riders who prioritize comfort on long rides without sacrificing performance. The relaxed geometry reduces strain on your back and neck during century rides.

The carbon-aluminum hybrid frame absorbs road vibrations while remaining stiff for efficient power transfer. 28mm tires provide extra cushion and grip on varied road surfaces.

Features include Shimano 105 groupset, endurance geometry, and compatibility with wider tires up to 32mm. Perfect for sportives, gran fondos, and all-day adventures.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Navy Blue',
        'Size': 'Large',
        'Weight': '9.2 kg',
        'Frame': 'Carbon-Aluminum Hybrid',
        'Groupset': 'Shimano 105',
        'Tires': '28mm Puncture Resistant',
        'Geometry': 'Endurance',
        'Max Tire': '32mm clearance',
      },
    ),
    // Additional Mountain bikes
    const Product(
      id: '13',
      name: 'Downhill Beast',
      category: 'Mountain',
      price: 1599.99,
      description: '''
The Downhill Beast is built for gravity riders who demand the best. 200mm of travel front and rear provides bottomless suspension for the biggest hits and drops.

The slack 63-degree head angle and long wheelbase provide stability at high speeds, while the low bottom bracket keeps you planted through corners. Built-in shuttle padding protects the frame during transport.

Features include DH-specific double crown fork, ultra-strong aluminum frame, and four-piston hydraulic brakes with 200mm rotors. Designed for bike parks and DH racing.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Race Red',
        'Size': 'Medium',
        'Weight': '18 kg',
        'Travel': '200mm / 200mm',
        'Fork': 'Double Crown DH',
        'Brakes': '4-Piston 200mm rotors',
        'Head Angle': '63 degrees',
        'Frame': '7075 Aluminum',
      },
    ),
    const Product(
      id: '14',
      name: 'XC Lightning',
      category: 'Mountain',
      price: 1299.99,
      description: '''
The XC Lightning is engineered for cross-country racing. The lightweight carbon frame weighs just 950 grams, making it one of the lightest production frames available.

The 100mm suspension fork provides enough travel for rough terrain while remaining efficient on climbs. 29-inch wheels roll over obstacles and maintain speed between pedal strokes.

Features include remote lockout, 1x12 drivetrain, and race-tuned geometry. When every second counts, the XC Lightning delivers.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Lime Green',
        'Size': 'Small',
        'Weight': '10.5 kg',
        'Travel': '100mm Front',
        'Frame': 'Carbon Fiber XC',
        'Drivetrain': 'SRAM XX1 Eagle',
        'Wheels': '29" Carbon',
        'Lockout': 'Remote handlebar',
      },
    ),
    // Additional Urban bikes
    const Product(
      id: '15',
      name: 'Commuter Elite',
      category: 'Urban',
      price: 799.99,
      description: '''
The Commuter Elite is the ultimate city bike for the discerning urbanist. The lightweight aluminum frame features internal cable routing and rack/fender mounts for a clean, practical design.

The Gates Carbon belt drive requires no lubrication or maintenance, keeping your clothes clean and reducing hassle. An 8-speed internal hub provides smooth, reliable shifting in any condition.

Premium features include integrated lights, hydraulic disc brakes, and a built-in phone mount. The Commuter Elite makes every ride to work a pleasure.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_04.png',
      ],
      specifications: {
        'Color': 'Slate Grey',
        'Size': 'Large',
        'Weight': '12.5 kg',
        'Drivetrain': 'Gates Carbon Belt',
        'Gears': '8-speed Internal Hub',
        'Brakes': 'Hydraulic Disc',
        'Lights': 'Integrated LED',
        'Accessories': 'Phone Mount included',
      },
    ),
    const Product(
      id: '16',
      name: 'Folding Nomad',
      category: 'Urban',
      price: 549.99,
      description: '''
The Folding Nomad combines portability with performance. The quick-fold mechanism collapses the bike in under 15 seconds, perfect for mixed commutes involving trains, buses, or car trunks.

Despite its compact size, the Folding Nomad rides like a full-size bike thanks to the 20-inch wheels and extended handlebars. The 7-speed drivetrain handles hills while the rigid fork provides direct steering feel.

Features include a carrying bag, rear rack, and adjustable stem to fit riders of all heights. Take it anywhere life takes you.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
        'assets/images/cycle_01.png',
      ],
      specifications: {
        'Color': 'Turquoise',
        'Size': 'One Size',
        'Weight': '11.5 kg',
        'Fold Time': '15 seconds',
        'Wheels': '20"',
        'Gears': '7-speed derailleur',
        'Included': 'Carrying bag',
        'Fits Riders': '5\'0" - 6\'2"',
      },
    ),
    // ========== Additional Products (17-32) ==========
    // Electric - 2 more
    const Product(
      id: '17',
      name: 'Lightning Pro',
      category: 'Electric',
      price: 1699.99,
      description: '''
The Lightning Pro represents the cutting edge of electric bike technology. Featuring a powerful 750W Bafang mid-drive motor with torque sensing, it delivers natural, responsive assistance that adapts to your pedaling style.

The premium 630Wh battery provides up to 120km range and can be fully charged in just 3.5 hours. The carbon fiber frame combines race-level stiffness with vibration damping comfort.

Advanced features include a full-color display with GPS navigation, automatic gear shifting, and smartphone integration for ride tracking and anti-theft alerts. Experience the future of cycling today.''',
      images: [
        'assets/images/cycle_01.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_01.png',
      ],
      specifications: {
        'Color': 'Aurora Purple',
        'Size': 'Medium',
        'Weight': '20 kg',
        'Range': '120 km',
        'Motor': '750W Bafang Mid-drive',
        'Battery': '630Wh Samsung cells',
        'Display': 'Color GPS Display',
        'Features': 'Auto Shifting, App Connect',
      },
    ),
    const Product(
      id: '18',
      name: 'City Sprint E',
      category: 'Electric',
      price: 999.99,
      description: '''
The City Sprint E is designed for the modern urban commuter who values style, efficiency, and reliability. The sleek integrated battery design makes it look like a regular bike while hiding 40km of electric range.

The lightweight 250W rear hub motor provides Class 1 assistance up to 20mph, perfect for bike lanes and mixed traffic. The maintenance-free Gates belt drive keeps your clothes clean and runs silently.

Features include front and rear lights powered by the main battery, fenders, and a rear rack for panniers or a basket. Perfect for daily commutes and errands.''',
      images: [
        'assets/images/cycle_03.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_03.png',
      ],
      specifications: {
        'Color': 'Graphite',
        'Size': 'Step-Through',
        'Weight': '17 kg',
        'Range': '40 km',
        'Motor': '250W Hub',
        'Battery': '250Wh Integrated',
        'Drive': 'Gates Belt',
        'Lights': 'Integrated LED',
      },
    ),
    // Road - 2 more
    const Product(
      id: '19',
      name: 'Gran Fondo',
      category: 'Road',
      price: 1399.99,
      description: '''
The Gran Fondo is built for epic all-day rides and challenging climbs. The endurance geometry provides comfort without sacrificing efficiency, letting you ride farther with less fatigue.

The high-modulus carbon frame features strategic compliance zones that absorb road buzz while maintaining stiffness where it matters. Shimano Ultegra groupset provides reliable, race-quality shifting performance.

Equipped with tubeless-ready wheels, hydraulic disc brakes, and clearance for 32mm tires, the Gran Fondo is ready for everything from smooth tarmac to rough backroads.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Sunset Orange',
        'Size': 'Medium',
        'Weight': '8.2 kg',
        'Frame': 'High-Modulus Carbon',
        'Groupset': 'Shimano Ultegra',
        'Brakes': 'Hydraulic Disc',
        'Tire Clearance': '32mm',
        'Wheelset': 'Tubeless Ready',
      },
    ),
    const Product(
      id: '20',
      name: 'Time Trial TT',
      category: 'Road',
      price: 2199.99,
      description: '''
The Time Trial TT is purpose-built for against-the-clock racing. Every tube shape has been optimized in the wind tunnel to minimize drag and maximize speed.

The aggressive geometry puts you in the most aerodynamic position, while the integrated cockpit and hidden cables present a seamless front profile to the wind. The frame features storage compartments for nutrition and tools.

Racing features include a dedicated between-the-arms hydration system, integrated computer mount, and compatibility with all major wheel depths. When seconds matter, choose the TT.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Stealth Matte',
        'Size': 'Medium',
        'Weight': '8.8 kg',
        'Frame': 'Aero Carbon UCI Legal',
        'Groupset': 'Shimano Dura-Ace',
        'Cockpit': 'Integrated Aero',
        'Wheels': 'Deep Section',
        'Storage': 'Integrated',
      },
    ),
    // Mountain - 2 more
    const Product(
      id: '21',
      name: 'Enduro Monster',
      category: 'Mountain',
      price: 1899.99,
      description: '''
The Enduro Monster is built for riders who want to go up and go down fast. The 170mm front and 160mm rear travel provides ample suspension for aggressive descending while remaining efficient on climbs.

The modern geometry with a 64-degree head angle provides confidence on steep terrain, while the short chainstays keep the bike playful and maneuverable. The internal storage compartment holds tools and spares.

Features include a coil rear shock option, super boost hub spacing, and compatibility with mullet wheel setups. Dominate any terrain with the Enduro Monster.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Monster Green',
        'Size': 'Large',
        'Weight': '15.5 kg',
        'Travel': '170mm / 160mm',
        'Fork': 'Fox 38 Factory',
        'Shock': 'Fox DHX2 Coil',
        'Brakes': 'SRAM Code RSC 200mm',
        'Geometry': 'Enduro Race',
      },
    ),
    const Product(
      id: '22',
      name: 'Trail Scout',
      category: 'Mountain',
      price: 899.99,
      description: '''
The Trail Scout is the perfect entry into serious trail riding. With 130mm of front suspension and aggressive trail geometry, it handles technical terrain with confidence while remaining approachable for developing riders.

The aluminum frame is designed to take a beating while keeping weight reasonable. Internal cable routing gives a clean look and protects cables from damage. The 1x11 drivetrain simplifies shifting.

Equipped with tubeless-ready wheels, hydraulic disc brakes, and a dropper post ready frame, the Trail Scout is ready to grow with your skills.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Scout Blue',
        'Size': 'Medium',
        'Weight': '13.5 kg',
        'Travel': '130mm Front',
        'Fork': 'RockShox Judy',
        'Drivetrain': 'Shimano Deore 11-speed',
        'Brakes': 'Shimano MT400',
        'Frame': 'Trail Aluminum',
      },
    ),
    // Urban - 2 more
    const Product(
      id: '23',
      name: 'Metro Express',
      category: 'Urban',
      price: 649.99,
      description: '''
The Metro Express is designed for fast, efficient city riding. The flat bar road bike layout provides agility in traffic while the upright position lets you see over cars and navigate safely.

The lightweight aluminum frame and carbon fork deliver a responsive ride, while the Shimano Claris 16-speed provides enough gears for any urban terrain. The disc brakes offer reliable stopping in all weather conditions.

Practical features include hidden fender mounts, rack eyelets, and clearance for 35mm tires. The Metro Express gets you there faster.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_04.png',
      ],
      specifications: {
        'Color': 'City Silver',
        'Size': 'Large',
        'Weight': '10 kg',
        'Frame': 'Aluminum',
        'Fork': 'Carbon',
        'Groupset': 'Shimano Claris 16-speed',
        'Brakes': 'Disc',
        'Tire Clearance': '35mm',
      },
    ),
    const Product(
      id: '24',
      name: 'Cargo Hauler',
      category: 'Urban',
      price: 899.99,
      description: '''
The Cargo Hauler is built for carrying capacity. The extended rear rack and front basket provide space for groceries, work gear, or even a small pet. The step-through frame makes loading and unloading easy.

The sturdy steel frame handles up to 180kg total load capacity, while the internally geared hub provides 8 speeds with zero maintenance. The powerful drum brakes stop heavy loads safely in any weather.

Features include a center kickstand rated for loaded bikes, full lighting system, and double-sided kickstand. Replace your car with the Cargo Hauler.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
        'assets/images/cycle_01.png',
      ],
      specifications: {
        'Color': 'Utility Orange',
        'Size': 'Step-Through',
        'Weight': '22 kg',
        'Capacity': '180 kg total',
        'Gears': '8-speed Internal Nexus',
        'Brakes': 'Drum (front & rear)',
        'Rack Capacity': '50 kg rear, 15 kg front',
        'Kickstand': 'Center, rated for loads',
      },
    ),
    // Electric - 2 more
    const Product(
      id: '25',
      name: 'MTB Electric',
      category: 'Electric',
      price: 2499.99,
      description: '''
The MTB Electric combines the thrill of mountain biking with electric power. The Shimano EP8 motor delivers 85Nm of torque for conquering the steepest climbs while maintaining a natural ride feel.

The full suspension design with 150mm travel front and rear smooths out rough trails, while the 630Wh battery provides range for all-day adventures. The geometry matches our non-electric trail bikes for familiar handling.

Features include custom tune modes via the E-Tube app, walk assist for hike-a-bike sections, and a reinforced frame designed for the extra weight and power. Experience trails like never before.''',
      images: [
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
      ],
      specifications: {
        'Color': 'Trail Olive',
        'Size': 'Large',
        'Weight': '24 kg',
        'Motor': 'Shimano EP8 85Nm',
        'Battery': '630Wh',
        'Travel': '150mm / 150mm',
        'Drivetrain': 'Shimano XT 12-speed',
        'App': 'E-Tube Connect',
      },
    ),
    const Product(
      id: '26',
      name: 'Road E-Speed',
      category: 'Electric',
      price: 3299.99,
      description: '''
The Road E-Speed is our fastest electric road bike, designed for those who want to keep up with the fast group ride or extend their range for ultra-long adventures.

The lightweight Fazua Evation motor can be removed completely for a pure road bike experience when you don't need assistance. The sleek integration hides the motor and battery in the downtube for a clean aesthetic.

Ultegra Di2 electronic shifting combines seamlessly with the motor for smooth, precise gear changes. Carbon wheels complete the performance package.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Ice White',
        'Size': 'Medium',
        'Weight': '13 kg (with motor)',
        'Motor': 'Fazua Evation Removable',
        'Battery': '250Wh',
        'Groupset': 'Ultegra Di2',
        'Wheelset': 'Carbon 40mm',
        'Range': '80 km assisted',
      },
    ),
    // Road - 2 more
    const Product(
      id: '27',
      name: 'Gravel King',
      category: 'Road',
      price: 1199.99,
      description: '''
The Gravel King thrives where the pavement ends. Built for adventure on and off-road, it handles everything from smooth tarmac to rough fire roads and singletrack.

The carbon frame provides compliance for long days in the saddle while maintaining stiffness for power transfer. Clearance for 45mm tires lets you run the right rubber for any terrain. Multiple frame mounts support bikepacking gear.

Features include GRX gravel-specific groupset with wide range gearing, flared drop bars for control on descents, and dropper post compatibility.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Gravel Tan',
        'Size': 'Large',
        'Weight': '9.5 kg',
        'Frame': 'Carbon Gravel',
        'Groupset': 'Shimano GRX 2x11',
        'Tire Clearance': '45mm',
        'Bars': 'Flared Drop',
        'Mounts': 'Multiple for bags',
      },
    ),
    const Product(
      id: '28',
      name: 'Track Missile',
      category: 'Road',
      price: 899.99,
      description: '''
The Track Missile is built for the velodrome. The stiff aluminum frame and aggressive geometry put you in the optimal position for maximum power output on the boards.

The single fixed gear drivetrain with various ratio options available keeps things simple and efficient. The narrow tire clearance and tight geometry are optimized for smooth indoor surfaces.

Designed to UCI track specifications, this bike is ready for competition or high-intensity training on the track.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Track Red',
        'Size': 'Small',
        'Weight': '7.5 kg',
        'Frame': 'Track Aluminum',
        'Drivetrain': 'Fixed Gear',
        'Wheelset': 'Track Specific',
        'Compliance': 'UCI Legal',
        'Use': 'Track Only',
      },
    ),
    // Mountain - 2 more
    const Product(
      id: '29',
      name: 'Fat Bike Arctic',
      category: 'Mountain',
      price: 1099.99,
      description: '''
The Fat Bike Arctic goes where other bikes can't. The 4.8" wide tires float over snow, sand, and loose terrain that would stop regular mountain bikes in their tracks.

The rigid aluminum frame and carbon fork keep weight reasonable while providing durability for harsh conditions. The wide gear range handles everything from deep sand to frozen climbs.

Perfect for winter riding, beach cruising, or exploring trails that see little traffic. Go anywhere any time with the Fat Bike Arctic.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Arctic White',
        'Size': 'Large',
        'Weight': '16 kg',
        'Tires': '4.8" Fat',
        'Fork': 'Carbon Rigid',
        'Drivetrain': 'SRAM NX 1x12',
        'Brakes': 'Hydraulic Disc',
        'Use': 'Snow, Sand, Trail',
      },
    ),
    const Product(
      id: '30',
      name: 'Dirt Jump Pro',
      category: 'Mountain',
      price: 799.99,
      description: '''
The Dirt Jump Pro is built for big air and hard landings. The bombproof chromoly steel frame handles drops and crashes that would destroy lesser bikes.

The low, slack geometry provides stability in the air and confidence on landings. The single speed drivetrain with tensioner keeps things simple and reliable. The short travel fork smooths takeoffs and landings.

Built for pump tracks, dirt jumps, and urban riding. Includes pegs mounts for street tricks.''',
      images: [
        'assets/images/cycle_02.png',
        'assets/images/cycle_03.png',
        'assets/images/cycle_02.png',
      ],
      specifications: {
        'Color': 'Raw Steel',
        'Size': 'One Size',
        'Weight': '13 kg',
        'Frame': 'Chromoly Steel',
        'Fork': '100mm DJ/Slope',
        'Drivetrain': 'Single Speed',
        'Brakes': 'Rear Disc Only',
        'Features': 'Peg Mounts',
      },
    ),
    // Urban - 2 more
    const Product(
      id: '31',
      name: 'Fixie Classic',
      category: 'Urban',
      price: 399.99,
      description: '''
The Fixie Classic celebrates the pure simplicity of the fixed gear experience. No gears to shift, no freewheel to coast – just you and the bike working in perfect harmony.

The steel frame provides a smooth, comfortable ride quality while the flip-flop hub lets you choose between fixed gear and freewheel. The classic aesthetic fits in anywhere from city streets to coffee shops.

Minimal maintenance and maximum style make the Fixie Classic perfect for urban riders who appreciate simplicity.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_01.png',
        'assets/images/cycle_04.png',
      ],
      specifications: {
        'Color': 'Classic Black',
        'Size': 'Medium',
        'Weight': '9 kg',
        'Frame': 'Hi-Tensile Steel',
        'Hub': 'Flip-Flop',
        'Gear Ratio': '46/16',
        'Brakes': 'Front Only',
        'Style': 'Classic',
      },
    ),
    const Product(
      id: '32',
      name: 'Beach Cruiser',
      category: 'Urban',
      price: 349.99,
      description: '''
The Beach Cruiser is all about relaxed, comfortable riding. The swept-back handlebars and wide, cushioned saddle put you in an upright position perfect for scenic rides along the boardwalk.

The coaster brake provides simple, intuitive stopping power – just pedal backwards. The wide 26" balloon tires smooth out bumps and handle sandy surfaces with ease.

Available in a range of fun colors, the Beach Cruiser brings smiles wherever it goes. No complexity, pure joy.''',
      images: [
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
        'assets/images/cycle_04.png',
      ],
      specifications: {
        'Color': 'Sky Blue',
        'Size': 'One Size',
        'Weight': '15 kg',
        'Frame': 'Steel Cruiser',
        'Drivetrain': 'Single Speed',
        'Brakes': 'Coaster',
        'Tires': '26" Balloon',
        'Saddle': 'Wide Cushioned',
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
