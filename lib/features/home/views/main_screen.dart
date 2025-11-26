import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/views/nutrition_intake_info.dart';
import 'package:nutrovite/features/home/views/price_screen.dart';
import 'package:nutrovite/features/home/views/provinces_screen.dart';

class TestApi extends StatelessWidget {
  const TestApi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Nutrition Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NutritionIntakeInfo()),
                );
              },
              child: const Text('View Nutrition Information'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Province Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProvinceScreen()),
                );
              },
              child: const Text('View Province Information'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PriceListScreen()),
                );
              },
              child: const Text('View Price List Information'),
            ),
          ],
        ),
      ),
    );
  }
}
