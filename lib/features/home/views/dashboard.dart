import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrovite/features/home/view_models/navigation_cubit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardCardLarge(
              title: 'Family Nutrition',
              subtitle: 'Manage nutrition for your family members efficiently.',
              imageUrl: 'assets/images/family_nutrition_2.png',
              onTap: () {
                // Navigate to the last tab (Family Tab)
                context.read<NavigationCubit>().navigateToTab(1);
              },
            ),
            const SizedBox(height: 12),
            DashboardCardLarge(
              title: 'Top 10 Nutrients',
              subtitle: 'Check out the top 10 essential nutrients.',
              imageUrl: 'assets/images/nutritions.png',
              onTap: () => Navigator.of(context).pushNamed('/sources'),
            ),
            // const SizedBox(height: 12),
            // DashboardCardLarge(
            //   title: 'Intake Information',
            //   subtitle: 'Manage and track your nutrient intake with ease.',
            //   imageUrl: 'assets/images/nutritions.png',
            //   onTap: () => Navigator.of(context).pushNamed('/intakeInfo'),
            // ),
            const SizedBox(height: 12),
            DashboardCardLarge(
              title: 'Recipes',
              subtitle: 'Explore the recipes for balance diet.',
              imageUrl: 'assets/images/recipes.png',
              onTap: () => Navigator.of(context).pushNamed('/food_api_screen'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class DashboardCardLarge extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const DashboardCardLarge({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 6),
            // Subtitle
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            // Full-width Squared Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover, // Ensures the image fills the square
              ),
            ),
            // Action Button
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Explore',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0), // Reduced padding
          child: Row(
            children: [
              // Card Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12), // Reduced spacing
              // Card Image with slightly larger size
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imageUrl,
                  width: 100, // Increased width
                  height: 100, // Increased height
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
