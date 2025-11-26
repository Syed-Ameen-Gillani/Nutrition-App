import 'package:flutter/material.dart';
import 'package:nutrovite/features/chat_bot/models/nutrients_data.dart';

class NutrientsSourcesScreen extends StatelessWidget {
  const NutrientsSourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutrient Sources',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: ListView.builder(
          itemCount: listOfNutients.length,
          itemBuilder: (context, index) {
            final nutrient = listOfNutients[index];
            return NutrientCard(
              name: nutrient.name,
              subtitle: nutrient.subtitle,
              onTap: () {
                _showSourcesBottomSheet(context, nutrient.name);
              },
            );
          },
        ),
      ),
    );
  }

  void _showSourcesBottomSheet(BuildContext context, String nutrientName) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final sources = _nutrientSources[nutrientName] ?? [];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$nutrientName rich foods',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'These foods are commonly known to be good sources of $nutrientName.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (sources.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'No specific sources listed yet for this nutrient.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: sources.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final source = sources[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  colorScheme.primary.withOpacity(0.08),
                              child: Icon(
                                source.icon,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              source.food,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (source.portion != null &&
                                    source.portion!.isNotEmpty)
                                  Text(
                                    source.portion!,
                                    style:
                                        theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                if (source.note != null &&
                                    source.note!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      source.note!,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class NutrientCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback onTap;

  const NutrientCard({
    required this.name,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nutrient Name and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            // Button on the Right Side with Arrow on Right
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sources',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NutrientSource {
  final String food;
  final String? portion;
  final String? note;
  final IconData icon;

  const _NutrientSource({
    required this.food,
    this.portion,
    this.note,
    required this.icon,
  });
}

// Simple, static mapping of nutrients to common food sources.
// This keeps everything local and fast, and avoids extra API calls.
const Map<String, List<_NutrientSource>> _nutrientSources = {
  'Calcium': [
    _NutrientSource(
      food: 'Milk & yogurt',
      portion: '1 cup (240 ml)',
      note: 'Dairy products are classic, highly bioavailable sources of calcium.',
      icon: Icons.local_drink_rounded,
    ),
    _NutrientSource(
      food: 'Cheese',
      portion: '30 g slice',
      note: 'Hard cheeses like cheddar are especially rich.',
      icon: Icons.lunch_dining_rounded,
    ),
    _NutrientSource(
      food: 'Leafy greens',
      portion: '1 cup cooked spinach or kale',
      note: 'Also adds fiber and magnesium.',
      icon: Icons.grass_rounded,
    ),
  ],
  'Fiber': [
    _NutrientSource(
      food: 'Oats & whole grains',
      portion: '1 cup cooked oats / 1 slice whole grain bread',
      note: 'Great for breakfast and blood sugar control.',
      icon: Icons.breakfast_dining_rounded,
    ),
    _NutrientSource(
      food: 'Beans & lentils',
      portion: '1/2–1 cup cooked',
      note: 'High in both fiber and plant protein.',
      icon: Icons.rice_bowl_rounded,
    ),
    _NutrientSource(
      food: 'Fruits (apple, pear, berries)',
      portion: '1 medium fruit or 1/2 cup berries',
      note: 'Leave the skin on when possible for more fiber.',
      icon: Icons.apple_rounded,
    ),
  ],
  'Potassium': [
    _NutrientSource(
      food: 'Banana',
      portion: '1 medium banana',
      note: 'A classic, convenient source of potassium.',
      icon: Icons.local_grocery_store_rounded,
    ),
    _NutrientSource(
      food: 'Potato (with skin)',
      portion: '1 medium baked potato',
      note: 'Keep the skin for maximum potassium and fiber.',
      icon: Icons.local_dining_rounded,
    ),
    _NutrientSource(
      food: 'Spinach & leafy greens',
      portion: '1 cup cooked',
      note: 'Also supports iron and magnesium intake.',
      icon: Icons.grass_rounded,
    ),
  ],
  'Vitamin B12': [
    _NutrientSource(
      food: 'Fish & seafood',
      portion: '90–100 g cooked',
      note: 'Salmon, trout, and sardines are excellent sources.',
      icon: Icons.set_meal_rounded,
    ),
    _NutrientSource(
      food: 'Eggs',
      portion: '1–2 eggs',
      note: 'Also provide protein and healthy fats.',
      icon: Icons.egg_rounded,
    ),
    _NutrientSource(
      food: 'Fortified cereals / plant milks',
      portion: 'Check label for B12 content',
      note: 'Important for vegetarians and vegans.',
      icon: Icons.bakery_dining_rounded,
    ),
  ],
  'Iron': [
    _NutrientSource(
      food: 'Red meat',
      portion: '90 g cooked',
      note: 'Heme iron is well absorbed.',
      icon: Icons.lunch_dining_rounded,
    ),
    _NutrientSource(
      food: 'Lentils & beans',
      portion: '1/2–1 cup cooked',
      note:
          'Pair with vitamin C–rich foods (like lemon or tomatoes) to improve absorption.',
      icon: Icons.rice_bowl_rounded,
    ),
    _NutrientSource(
      food: 'Spinach',
      portion: '1 cup cooked',
      note: 'Contains non‑heme iron and many other micronutrients.',
      icon: Icons.grass_rounded,
    ),
  ],
  'Vitamin D': [
    _NutrientSource(
      food: 'Fatty fish (salmon, mackerel)',
      portion: '90–100 g cooked',
      note: 'One of the richest natural sources of vitamin D.',
      icon: Icons.set_meal_rounded,
    ),
    _NutrientSource(
      food: 'Fortified milk / yogurt',
      portion: '1 cup (240 ml)',
      note: 'Check packaging for vitamin D fortification.',
      icon: Icons.local_drink_rounded,
    ),
    _NutrientSource(
      food: 'Egg yolks',
      portion: '1–2 eggs',
      note: 'Moderate source; useful as part of a varied diet.',
      icon: Icons.egg_rounded,
    ),
  ],
  'Vitamin E': [
    _NutrientSource(
      food: 'Nuts & seeds (almonds, sunflower seeds)',
      portion: '30 g handful',
      note: 'Powerful antioxidant and healthy fats.',
      icon: Icons.emoji_food_beverage_rounded,
    ),
    _NutrientSource(
      food: 'Vegetable oils (sunflower, safflower)',
      portion: '1 tbsp',
      note: 'Use in moderation as part of cooking.',
      icon: Icons.oil_barrel_rounded,
    ),
    _NutrientSource(
      food: 'Avocado',
      portion: '1/2 medium avocado',
      note: 'Also provides fiber and heart‑healthy fats.',
      icon: Icons.lunch_dining_rounded,
    ),
  ],
  'Zinc': [
    _NutrientSource(
      food: 'Meat & poultry',
      portion: '90 g cooked',
      note: 'Beef and chicken are reliable zinc sources.',
      icon: Icons.dinner_dining_rounded,
    ),
    _NutrientSource(
      food: 'Chickpeas & lentils',
      portion: '1/2–1 cup cooked',
      note: 'Great for plant‑based diets.',
      icon: Icons.rice_bowl_rounded,
    ),
    _NutrientSource(
      food: 'Pumpkin seeds',
      portion: '2 tbsp',
      note: 'Easy to sprinkle over salads or oats.',
      icon: Icons.emoji_food_beverage_rounded,
    ),
  ],
  'Magnesium': [
    _NutrientSource(
      food: 'Nuts & seeds',
      portion: '30 g handful',
      note: 'Almonds, cashews, and pumpkin seeds are rich choices.',
      icon: Icons.emoji_food_beverage_rounded,
    ),
    _NutrientSource(
      food: 'Whole grains (brown rice, quinoa)',
      portion: '1/2–1 cup cooked',
      note: 'Support heart and metabolic health.',
      icon: Icons.rice_bowl_rounded,
    ),
    _NutrientSource(
      food: 'Leafy greens',
      portion: '1 cup cooked',
      note: 'Spinach and Swiss chard stand out for magnesium.',
      icon: Icons.grass_rounded,
    ),
  ],
  'Omega-3 Fatty Acids': [
    _NutrientSource(
      food: 'Fatty fish (salmon, sardines)',
      portion: '90–100 g cooked',
      note: 'Excellent EPA & DHA sources for brain and heart.',
      icon: Icons.set_meal_rounded,
    ),
    _NutrientSource(
      food: 'Flaxseeds & chia seeds',
      portion: '1–2 tbsp ground',
      note: 'Provide ALA omega‑3; great in smoothies or oats.',
      icon: Icons.emoji_food_beverage_rounded,
    ),
    _NutrientSource(
      food: 'Walnuts',
      portion: '30 g handful',
      note: 'Simple snack rich in ALA omega‑3.',
      icon: Icons.bakery_dining_rounded,
    ),
  ],
};

