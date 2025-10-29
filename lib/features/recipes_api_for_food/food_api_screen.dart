import 'package:flutter/material.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/recipes_api_for_food/api.dart';
import 'package:nutrovite/features/recipes_api_for_food/model_recipes.dart';
import 'package:nutrovite/features/recipes_api_for_food/recipe_details.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipes> _recipes = [];
  List<Recipes> _filteredRecipes = [];
  bool _isLoading = true;
  String _error = '';
  String _selectedMealType = 'All'; // Default to show all

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      _recipes = await ApiService().fetchRecipes();
      _filteredRecipes = _recipes; // Initially show all recipes
    } catch (e) {
      _error = 'Failed to load recipes';
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Filter recipes based on meal type
  void _filterRecipes(String mealType) {
    setState(() {
      _selectedMealType = mealType;
      if (mealType == 'All') {
        _filteredRecipes = _recipes;
      } else {
        _filteredRecipes = _recipes
            .where((recipe) =>
                recipe.mealType != null && recipe.mealType!.contains(mealType))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: context.height * 0.06,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('All'),
            _buildFilterButton('Breakfast'),
            _buildFilterButton('Lunch'),
            _buildFilterButton('Dinner'),
          ],
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface, // Updated color
          size: 22,
        ),
        title: const Text('Recipes List'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(
                  child: Text('Error: $_error',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall)) // Updated style
              : _filteredRecipes.isEmpty
                  ? const Center(child: Text('No recipes found.'))
                  : ListView.builder(
                      itemCount: _filteredRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _filteredRecipes[index];
                        return RecipeCard(recipe: recipe);
                      },
                    ),
    );
  }

  Widget _buildFilterButton(String mealType) {
    return Flexible(
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: _selectedMealType == mealType
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        ),
        onPressed: () {
          _filterRecipes(mealType);
        },
        child: Text(mealType,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: _selectedMealType == mealType
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                )), // Updated style
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipes recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (recipe.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    recipe.image!,
                    fit: BoxFit.cover,
                    height: 200.0,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 8.0),
              Text(
                recipe.name ?? 'No name',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // Updated style
              ),
              const SizedBox(height: 5),
              Text(
                'Meal Type: ${recipe.mealType?.join(', ') ?? 'Not available'}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ), // Updated style
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: recipe.tags!
                    .map((tag) => Chip(
                          elevation: 0,
                          label: Text(tag),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary), // Updated style
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
