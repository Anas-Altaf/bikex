import 'package:bikex/bikes/widgets/hero_card.dart';
import 'package:bikex/bikes/widgets/ladder_row.dart';
import 'package:bikex/bikes/widgets/product_card.dart';
import 'package:bikex/bikes/widgets/products_list.dart';
import 'package:flutter/material.dart';

class BikesPage extends StatelessWidget {
  const BikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: HeroCard()),
        SliverToBoxAdapter(child: LadderRow()),
        ProductsList(),
      ],
    );
  }
}
