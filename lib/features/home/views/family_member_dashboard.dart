import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/home/models/family.dart';
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
    final recommendations = _generateRecommendations(age);
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    log(widget.member.memberId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          '${widget.member.name} Details',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            _buildProfileInfo(context, onSurfaceColor),
            const SizedBox(height: 10),
            _buildNutrientRecommendations(
              context,
              recommendations,
              onSurfaceColor,
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

  Widget _buildNutrientRecommendations(BuildContext context,
      Map<String, double> recommendations, Color onSurfaceColor) {
    // Define the units for each nutrient
    final Map<String, String> units = {
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
              'Recommended Nutrients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: onSurfaceColor,
                  ),
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              border: TableBorder.all(width: 0, color: Colors.transparent),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: onSurfaceColor,
                                  ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          'Recommended',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: onSurfaceColor,
                                  ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Consumed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: onSurfaceColor,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...recommendations.entries.map((entry) => TableRow(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              entry.key,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: onSurfaceColor,
                                  ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${entry.value.toStringAsFixed(1)} ${units[entry.key] ?? ''}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: onSurfaceColor,
                                  ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${nutritionData[entry.key]?.toStringAsFixed(1) ?? '0'} ${units[entry.key] ?? ''}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: onSurfaceColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
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

  Map<String, double> _generateRecommendations(int age) {
    String gender = widget.member.gender;
    String lactationStatus = widget.member.lactationStatus;
    log('Lactation: $lactationStatus Gender: $gender  Age: $age');

    final recommendations = <String, double>{};

    // Fetch nutrient values based on the provided data set
    final nutrientData = _getRecommendedNutrients(age, gender, lactationStatus);

    for (var entry in nutrientData.entries) {
      recommendations[entry.key] =
          entry.value; // Fetch appropriate nutrient data for the individual.
    }

    return recommendations;
  }

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
}
