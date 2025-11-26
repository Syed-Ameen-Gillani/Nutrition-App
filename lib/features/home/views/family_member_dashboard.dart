import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/home/models/family.dart';
import 'package:nutrovite/features/home/services/nutrition_recommendation_service.dart';
import 'package:nutrovite/features/home/widgets/nutrition_progress_indicator.dart';
import 'package:nutrovite/features/source_api/source_neutrant.dart';
import 'package:nutrovite/features/source_api/source_repository.dart';

class FamilyMemberDetails extends StatefulWidget {
  static const route = 'familyMemberDetails';
  final FamilyMember member;

  const FamilyMemberDetails({
    super.key,
    required this.member,
  });

  @override
  State<FamilyMemberDetails> createState() => _FamilyMemberDetailsState();
}

class _FamilyMemberDetailsState extends State<FamilyMemberDetails> {
  final SourceNeutrantRepository _repository = SourceNeutrantRepository();
  Map<String, double> nutritionData = {};
  List<SourceNeutrant> consumedSources = [];

  @override
  void initState() {
    super.initState();
    _fetchNutritionData();
  }

  Future<void> _fetchNutritionData() async {
    final savedSelection =
        await _repository.loadSavedData(widget.member.memberId);
    if (savedSelection != null) {
      // Fetch consumed sources details
      consumedSources =
          await _repository.fetchSourceDetails(savedSelection.sourceIds);
      setState(() {
        nutritionData = {
          'Iron': savedSelection.totalIron,
          'Fiber': savedSelection.totalFiber,
          'Calcium': savedSelection.totalCalcium,
          'Omega-3 Fatty Acids': savedSelection.totalOmega3FattyAcid,
          'Vitamin D': savedSelection.totalVitaminD,
          'Vitamin E': savedSelection.totalVitE,
          'Vitamin B12': savedSelection.totalVitaminB12,
          'Water': savedSelection.totalWater,
          'Magnesium': savedSelection.totalMagnesium,
          'Potassium': savedSelection.totalPotassium,
        };
      });
    } else {
      setState(() {
        nutritionData = {
          'Iron': 0,
          'Fiber': 0,
          'Calcium': 0,
          'Omega-3 Fatty Acids': 0,
          'Vitamin D': 0,
          'Vitamin E': 0,
          'Vitamin B12': 0,
          'Water': 0,
          'Magnesium': 0,
          'Potassium': 0,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final age = DateTime.now().year - widget.member.dob.year;
    log(age.toString());
    
    // Use the new recommendation service
    final recommendations = NutritionRecommendationService.generateRecommendations(
      age: age,
      gender: widget.member.gender,
      lactationStatus: widget.member.lactationStatus,
      activityLevel: 'moderate', // Could be made configurable
    );
    
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    log(widget.member.memberId);

    // Define units for nutrients
    final units = {
      'Iron': 'mg',
      'Fiber': 'g',
      'Calcium': 'mg',
      'Omega-3 Fatty Acids': 'mg',
      'Vitamin D': 'IU',
      'Vitamin E': 'mg',
      'Vitamin B12': 'µg',
      'Water': 'L',
      'Magnesium': 'mg',
      'Potassium': 'mg',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          '${widget.member.name} Details',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showNutritionInfo(context),
            tooltip: 'Nutrition Guidelines',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            _buildProfileInfo(context, onSurfaceColor),
            const SizedBox(height: 10),
            // Add nutrition summary card
            NutritionSummaryCard(
              recommended: recommendations,
              consumed: nutritionData,
              units: units,
            ),
            const SizedBox(height: 10),
            _buildEnhancedNutrientRecommendations(
              context,
              recommendations,
              units,
            ),
            if (consumedSources.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildConsumedSources(context, onSurfaceColor),
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/addsource', arguments: widget.member);
        },
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, Color onSurfaceColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width * 0.40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.member.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onSurfaceColor,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.member.familyStatus,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    DateFormat('yyyy-MM-dd').format(widget.member.dob),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.member.maritalStatus,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.member.lactationStatus,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.member.city,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: context.width * 0.35,
              height: context.width * 0.35,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.member.photo,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: onSurfaceColor,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedNutrientRecommendations(
    BuildContext context,
    Map<String, double> recommendations,
    Map<String, String> units,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Nutrition Goals',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () => _showNutrientHelp(context),
                  tooltip: 'Learn about nutrients',
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...recommendations.entries.map((entry) {
              final consumed = nutritionData[entry.key] ?? 0;
              final unit = units[entry.key] ?? '';
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: NutritionProgressIndicator(
                  nutrientName: entry.key,
                  recommended: entry.value,
                  consumed: consumed,
                  unit: unit,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildConsumedSources(BuildContext context, Color onSurfaceColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              'Consumed Sources',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: onSurfaceColor,
                  ),
            ),
            const SizedBox(height: 12),
            ...consumedSources.map(
              (source) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  title: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    source.source!.foodName.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  trailing: Text(
                    source.price.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                  subtitle: Text(
                    source.source!.quantity.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: onSurfaceColor,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Legacy method - replaced by NutritionRecommendationService
  // ignore: unused_element
  Map<String, double> _getRecommendedNutrients(
      int age, String gender, String lactationStatus) {
    Map<String, double> nutrientRecommendations = {
      'Iron': 0,
      'Fiber': 0,
      'Calcium': 0,
      'Omega-3 Fatty Acids': 0,
      'Vitamin D': 0,
      'Vitamin E': 0,
      'Vitamin B12': 0,
      'Water': 0,
      'Magnesium': 0,
      'Potassium': 0,
    };

    // Age and gender-based recommendations
    if (age < 1) {
      nutrientRecommendations['Iron'] = 11.0;
      nutrientRecommendations['Fiber'] = 19.0;
      nutrientRecommendations['Calcium'] = 260.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 0.5;
      nutrientRecommendations['Vitamin D'] = 400.0;
      nutrientRecommendations['Vitamin E'] = 4.0;
      nutrientRecommendations['Vitamin B12'] = 0.4;
      nutrientRecommendations['Water'] = 0.7;
      nutrientRecommendations['Magnesium'] = 30.0;
      nutrientRecommendations['Potassium'] = 400.0;
    } else if (age >= 1 && age <= 3) {
      nutrientRecommendations['Iron'] = 7.0;
      nutrientRecommendations['Fiber'] = 19.0;
      nutrientRecommendations['Calcium'] = 700.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 0.7;
      nutrientRecommendations['Vitamin D'] = 600.0;
      nutrientRecommendations['Vitamin E'] = 6.0;
      nutrientRecommendations['Vitamin B12'] = 0.9;
      nutrientRecommendations['Water'] = 1.3;
      nutrientRecommendations['Magnesium'] = 80.0;
      nutrientRecommendations['Potassium'] = 2000.0;
    } else if (age >= 4 && age <= 8) {
      nutrientRecommendations['Iron'] = 10.0;
      nutrientRecommendations['Fiber'] = 25.0;
      nutrientRecommendations['Calcium'] = 1000.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 0.9;
      nutrientRecommendations['Vitamin D'] = 600.0;
      nutrientRecommendations['Vitamin E'] = 7.0;
      nutrientRecommendations['Vitamin B12'] = 1.2;
      nutrientRecommendations['Water'] = 1.7;
      nutrientRecommendations['Magnesium'] = 130.0;
      nutrientRecommendations['Potassium'] = 2300.0;
    } else if (age >= 9 && age <= 13) {
      nutrientRecommendations['Iron'] = gender == 'female' ? 8.0 : 11.0;
      nutrientRecommendations['Fiber'] = gender == 'female' ? 26.0 : 31.0;
      nutrientRecommendations['Calcium'] = 1300.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 1.2;
      nutrientRecommendations['Vitamin D'] = 600.0;
      nutrientRecommendations['Vitamin E'] = 11.0;
      nutrientRecommendations['Vitamin B12'] = 1.8;
      nutrientRecommendations['Water'] = 2.4;
      nutrientRecommendations['Magnesium'] = 240.0;
      nutrientRecommendations['Potassium'] = 2500.0;
    } else if (age >= 14 && age <= 18) {
      nutrientRecommendations['Iron'] = gender == 'female' ? 15.0 : 11.0;
      nutrientRecommendations['Fiber'] = gender == 'female' ? 26.0 : 38.0;
      nutrientRecommendations['Calcium'] = 1300.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 1.6;
      nutrientRecommendations['Vitamin D'] = 600.0;
      nutrientRecommendations['Vitamin E'] = 15.0;
      nutrientRecommendations['Vitamin B12'] = 2.4;
      nutrientRecommendations['Water'] = 3.3;
      nutrientRecommendations['Magnesium'] = 410.0;
      nutrientRecommendations['Potassium'] = 3000.0;
    } else if (age >= 19) {
      nutrientRecommendations['Iron'] = gender == 'female' ? 18.0 : 8.0;
      nutrientRecommendations['Fiber'] = gender == 'female' ? 25.0 : 30.0;
      nutrientRecommendations['Calcium'] = 1000.0;
      nutrientRecommendations['Omega-3 Fatty Acids'] = 1.6;
      nutrientRecommendations['Vitamin D'] = 600.0;
      nutrientRecommendations['Vitamin E'] = 15.0;
      nutrientRecommendations['Vitamin B12'] = 2.4;
      nutrientRecommendations['Water'] = 3.7;
      nutrientRecommendations['Magnesium'] = 420.0;
      nutrientRecommendations['Potassium'] = 3400.0;
    }

    // Adjust based on lactation status or pregnancy
    if (lactationStatus == 'Pregnancy') {
      nutrientRecommendations['Iron'] = 27; // Increased iron during pregnancy
      nutrientRecommendations['Calcium'] = 1300; // Increased calcium intake
      nutrientRecommendations['Omega-3 Fatty Acids'] = 1.4; // Adjusted omega-3s
      nutrientRecommendations['Vitamin D'] = 600; // Adjusted vitamin D
      nutrientRecommendations['Vitamin E'] = 15.0;
      nutrientRecommendations['Vitamin B12'] = 2.6;
      nutrientRecommendations['Water'] = 3.0;
      nutrientRecommendations['Magnesium'] = 350.0;
      nutrientRecommendations['Potassium'] = 2900.0;
    } else if (lactationStatus == 'Lactation') {
      nutrientRecommendations['Iron'] = 9; // Adjust iron during lactation
      nutrientRecommendations['Calcium'] =
          1000; // Adjust calcium during lactation
      nutrientRecommendations['Vitamin D'] =
          600; // Adjust vitamin D during lactation
      nutrientRecommendations['Vitamin E'] = 19.0;
      nutrientRecommendations['Vitamin B12'] = 2.8;
      nutrientRecommendations['Water'] = 3.8;
      nutrientRecommendations['Magnesium'] = 310.0;
      nutrientRecommendations['Potassium'] = 3100.0;
    } else if (gender == 'female' && lactationStatus == 'None') {
      nutrientRecommendations['Iron'] =
          18; // Higher iron needs for non-lactating females
    } else if (gender == 'male') {
      nutrientRecommendations['Iron'] = 8; // Males typically require less iron
    }

    return nutrientRecommendations;
  }

  void _showNutritionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nutrition Guidelines'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recommendations are based on:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('• Dietary Reference Intakes (DRI)'),
              const Text('• Age and gender-specific needs'),
              const Text('• Special conditions (pregnancy, lactation)'),
              const Text('• Activity level adjustments'),
              const SizedBox(height: 16),
              Text(
                'Status Indicators:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildStatusLegend(context, 'Deficient', Colors.red, '< 67% of goal'),
              _buildStatusLegend(context, 'Adequate', Colors.green, '67-133% of goal'),
              _buildStatusLegend(context, 'Excessive', Colors.orange, '> 133% of goal'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLegend(BuildContext context, String status, Color color, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text('$status: $description'),
        ],
      ),
    );
  }

  void _showNutrientHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nutrient Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNutrientInfo('Iron', 'Essential for oxygen transport and energy production'),
              _buildNutrientInfo('Fiber', 'Supports digestive health and blood sugar control'),
              _buildNutrientInfo('Calcium', 'Critical for bone health and muscle function'),
              _buildNutrientInfo('Omega-3 Fatty Acids', 'Support heart and brain health'),
              _buildNutrientInfo('Vitamin D', 'Important for bone health and immune function'),
              _buildNutrientInfo('Vitamin E', 'Antioxidant that protects cells from damage'),
              _buildNutrientInfo('Vitamin B12', 'Essential for nerve function and red blood cell formation'),
              _buildNutrientInfo('Water', 'Maintains hydration and supports all body functions'),
              _buildNutrientInfo('Magnesium', 'Supports muscle and nerve function, bone health'),
              _buildNutrientInfo('Potassium', 'Regulates blood pressure and supports heart health'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String name, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
