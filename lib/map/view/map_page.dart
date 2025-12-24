import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map,
            size: 64,
            color: AppTheme.primaryUpColor,
          ),
          SizedBox(height: 16),
          Text(
            'Map',
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Find bikes near you',
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
