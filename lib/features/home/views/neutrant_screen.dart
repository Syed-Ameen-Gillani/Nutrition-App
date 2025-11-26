// screens/nutrient_screen.dart
import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/models/get_neutrant.dart';
import 'package:nutrovite/features/home/repositories/repositories.dart';

class NutrientScreen extends StatefulWidget {
  const NutrientScreen({super.key});

  @override
  State<NutrientScreen> createState() => _NutrientScreenState();
}

class _NutrientScreenState extends State<NutrientScreen> {
  GetNutrient? _getNutrient;
  bool _isLoading = true;
  bool _isDisposed = false;

  final NutroviteApi _apiService = NutroviteApi();

  @override
  void initState() {
    super.initState();
    _fetchNutrientData();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // Method to fetch nutrient data from the API
  Future<void> _fetchNutrientData() async {
    try {
      // Fetching data using NutroviteApi
      GetNutrient nutrientData = await _apiService.fetchNutrientData();

      // Check if the widget is still mounted before calling setState
      if (!_isDisposed && mounted) {
        setState(() {
          _getNutrient = nutrientData;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors
      if (!_isDisposed && mounted) {
        setState(() {
          _isLoading = false; // Set loading to false on error
        });
      }
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrient Information'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _getNutrient != null && _getNutrient!.data != null
              ? ListView.builder(
                  itemCount: _getNutrient!.data!.length,
                  itemBuilder: (context, index) {
                    // Access the nutrient data at the given index
                    Neutrant nutrient = _getNutrient!.data![index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(nutrient.name ?? 'Unknown'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Created At: ${nutrient.createdAt ?? 'N/A'}'),
                            Text('Updated At: ${nutrient.updatedAt ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No data available')),
    );
  }
}
