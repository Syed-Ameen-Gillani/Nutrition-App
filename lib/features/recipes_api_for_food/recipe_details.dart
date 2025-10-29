import 'package:flutter/material.dart';
import 'package:nutrovite/features/recipes_api_for_food/model_recipes.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipes recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
          size: 22,
        ),
        centerTitle: true,
        title: Text(recipe.name ?? 'Recipe Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  recipe.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            const SizedBox(height: 16.0),
            Text(
              recipe.name ?? 'No name',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ), // Consistent style
            ),
            const SizedBox(height: 8.0),
            Text(
              'Meal Type: ${recipe.mealType?.join(', ') ?? 'Not available'}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ), // Consistent style
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: recipe.tags!
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Instructions:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8.0),
            for (var instruction in recipe.instructions!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '• $instruction',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            const SizedBox(height: 16.0),
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8.0),
            for (var ingredient in recipe.ingredients!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '• $ingredient',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.star,
                    size: 24.0, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4.0),
                Text(
                  '${recipe.rating} (${recipe.reviewCount} reviews)',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
