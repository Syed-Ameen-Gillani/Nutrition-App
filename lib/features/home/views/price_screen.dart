import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/repositories/repositories.dart';
import 'package:nutrovite/features/home/models/price_model.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceListScreenState createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  PriceList? _priceList; // Variable to hold the price list data
  bool _isLoading = true; // Loading indicator
  bool _isDisposed = false; // Indicator for widget disposal

  final NutroviteApi _apiService = NutroviteApi(); // Use NutroviteApi

  @override
  void initState() {
    super.initState();
    _fetchPriceListData(); // Fetch price list data when the widget initializes
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark the widget as disposed
    super.dispose();
  }

  // Method to fetch price list data from the API
  Future<void> _fetchPriceListData() async {
    try {
      PriceList priceListData = await _apiService.fetchPriceListData();

      if (!_isDisposed && mounted) {
        setState(() {
          _priceList =
              priceListData; // Update the state with fetched price list data
          _isLoading = false; // Set loading to false
        });
      }
    } catch (e) {
      if (!_isDisposed && mounted) {
        setState(() {
          _isLoading = false; // Set loading to false on error
        });
      }
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Price List Information'),
      // ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : _priceList != null && _priceList!.data != null
              ? ListView.builder(
                  itemCount: _priceList!.data!.length, // Number of items
                  itemBuilder: (context, index) {
                    // Access the data at the given index
                    PriceData data = _priceList!.data![index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: ListTile(
                        title:
                            Text(data.name ?? 'Unknown'), // Display item name
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Unit: ${data.unit ?? 'N/A'}'), // Display unit
                            Text('NID: ${data.nid ?? 'N/A'}'), // Display NID
                            ...data.price!.map((price) {
                              return Text(
                                  'Province: ${price.province}, Price: ${price.price}');
                              // ignore: unnecessary_to_list_in_spreads
                            }).toList(), // Display price list
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
