import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/repositories/repositories.dart';
import 'package:nutrovite/features/home/models/province_model.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProvinceScreenState createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  Province? _province; // Variable to hold the province data
  bool _isLoading = true; // Loading indicator
  bool _isDisposed = false; // Indicator for widget disposal

  final NutroviteApi _apiService = NutroviteApi(); // Use NutroviteApi

  @override
  void initState() {
    super.initState();
    _fetchProvinceData(); // Fetch province data when the widget initializes
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark the widget as disposed
    super.dispose();
  }

  // Method to fetch province data from the API
  Future<void> _fetchProvinceData() async {
    try {
      // Fetching data using NutroviteApi
      Province provinceData = await _apiService.fetchProvinceData();

      // Check if the widget is still mounted before calling setState
      if (!_isDisposed && mounted) {
        setState(() {
          _province =
              provinceData; // Update the state with fetched province data
          _isLoading = false; // Set loading to false
        });
      }
    } catch (e) {
      // Handle errors
      if (!_isDisposed && mounted) {
        setState(() {
          _isLoading = false; // Set loading to false on error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Province Information'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : _province != null && _province!.data != null
              ? ListView.builder(
                  itemCount: _province!.data!.length, // Number of items
                  itemBuilder: (context, index) {
                    // Access the state data at the given index
                    PState state = _province!.data![index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        title:
                            Text(state.name ?? 'Unknown'), // Display state name
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Created At: ${state.createdAt ?? 'N/A'}'), // Display created date
                            Text(
                                'Updated At: ${state.updatedAt ?? 'N/A'}'), // Display updated date
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No data available')), // Handle no data scenario
    );
  }
}
