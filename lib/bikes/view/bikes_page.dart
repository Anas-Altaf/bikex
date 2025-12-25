import 'package:bikex/bikes/widgets/diagonal_card_clipper.dart';
import 'package:bikex/bikes/widgets/hero_card.dart';
import 'package:bikex/bikes/widgets/ladder_row.dart';
import 'package:flutter/material.dart';

class BikesPage extends StatelessWidget {
  const BikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeroCard(),
        LadderRow(),
      ],
    );
  }
}
