import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/models/family.dart';
import 'package:nutrovite/features/source_api/source_neutrant.dart';
import 'package:nutrovite/features/source_api/source_repository.dart';

class SourceNeutrantScreen extends StatefulWidget {
  const SourceNeutrantScreen({super.key, required this.member});
  final FamilyMember member;

  @override
  State<SourceNeutrantScreen> createState() => _SourceNeutrantScreenState();
}

class _SourceNeutrantScreenState extends State<SourceNeutrantScreen> {
  List<SourceNeutrant> sourceNeutrants = [];
  List<SourceNeutrant> filteredNeutrants = [];
  List<SourceNeutrant> selectedFavorites = [];
  
  bool isLoading = true;
  bool hasLoadedSavedData = false;
  bool hasError = false;
  String? errorMessage;
  
  String selectedFilter = 'All';

  // Nutrient totals
  final Map<String, double> totals = {
    'price': 0,
    'water': 0,
    'vitaminD': 0,
    'omega3': 0,
    'vitaminB12': 0,
    'fiber': 0,
    'vitE': 0,
    'calcium': 0,
    'iron': 0,
    'magnesium': 0,
    'potassium': 0,
  };

  final SourceNeutrantRepository _repository = SourceNeutrantRepository();

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  /// Initialize screen with error handling
  Future<void> _initializeScreen() async {
    await fetchSourceNeutrants();
  }

  /// Fetch source neutrants with comprehensive error handling
  Future<void> fetchSourceNeutrants() async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
      hasError = false;
      errorMessage = null;
    });

    log('🔍 Fetching source neutrants for member: ${widget.member.name}');
    
    try {
      final fetchedData = await _repository.getSourceOfNeutrents();

      if (!mounted) return;

      if (fetchedData == null || fetchedData.isEmpty) {
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = 'No food sources available';
        });
        log('⚠️ No data available for source neutrants');
        return;
      }

      setState(() {
        sourceNeutrants = List<SourceNeutrant>.from(fetchedData);
        filteredNeutrants = List<SourceNeutrant>.from(sourceNeutrants);
        isLoading = false;
        hasError = false;
      });
      
      log('✅ Fetched ${sourceNeutrants.length} source neutrants successfully');
      
      // Load saved data after successful fetch
      await _loadSavedData();
      
    } on DioException catch (e) {
      log('❌ DioException: ${e.type}', error: e);
      
      if (!mounted) return;
      
      String message;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message = 'Connection timeout. Please check your internet.';
          break;
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            message = 'Food source data not found. Please contact support.';
          } else if (statusCode == 500) {
            message = 'Server error. Please try again later.';
          } else {
            message = 'Server error (${statusCode ?? 'Unknown'})';
          }
          break;
        case DioExceptionType.cancel:
          message = 'Request cancelled';
          break;
        case DioExceptionType.connectionError:
          message = 'No internet connection';
          break;
        default:
          message = 'Network error. Please try again.';
      }
      
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = message;
      });
      
    } catch (e, stackTrace) {
      log('❌ Unexpected error: $e', error: e, stackTrace: stackTrace);
      
      if (!mounted) return;
      
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'An unexpected error occurred';
      });
    }
  }

  /// Load saved data for member
  Future<void> _loadSavedData() async {
    if (sourceNeutrants.isEmpty) return;
    
    log('📂 Loading saved data for member: ${widget.member.name}');
    
    try {
      final savedSelection = await _repository.loadSavedData(
        widget.member.memberId.toString(),
      );

      if (!mounted) return;

      if (savedSelection != null) {
        setState(() {
          selectedFavorites = sourceNeutrants
              .where((source) => savedSelection.sourceIds.contains(source.sId))
              .toList();

          totals['price'] = savedSelection.totalPrice;
          hasLoadedSavedData = true;
        });
        
        _updateTotals();
        log('✅ Loaded saved data with ${selectedFavorites.length} items');
      } else {
        log('ℹ️ No saved data found');
      }
    } catch (e) {
      log('❌ Error loading saved data: $e');
      // Don't show error to user, just log it
    }
  }

  /// Apply filter to food sources
  void applyFilter(String filter) {
    log('🔎 Applying filter: $filter');
    
    setState(() {
      selectedFilter = filter;

      if (filter == 'All') {
        filteredNeutrants = List.from(sourceNeutrants);
      } else {
        filteredNeutrants = sourceNeutrants
            .where((source) {
              final likelyToEat = source.source?.likelyToEatIn?.toLowerCase() ?? '';
              return likelyToEat.contains(filter.toLowerCase());
            })
            .toList();
      }
    });
    
    log('📊 Filtered items count: ${filteredNeutrants.length}');
  }

  /// Toggle favorite selection
  void toggleFavorite(SourceNeutrant sourceNeutrant, bool? isSelected) {
    log('⭐ Toggling: ${sourceNeutrant.source?.foodName}, selected: $isSelected');
    
    setState(() {
      if (isSelected == true) {
        if (!selectedFavorites.contains(sourceNeutrant)) {
          selectedFavorites.add(sourceNeutrant);
        }
      } else {
        selectedFavorites.remove(sourceNeutrant);
      }
    });

    _updateTotals();
    _saveSelection();
  }

  /// Update nutrient totals
  void _updateTotals() {
    log('🧮 Updating totals based on ${selectedFavorites.length} items');
    
    // Reset all totals
    totals.updateAll((key, value) => 0);

    // Calculate totals from selected favorites
    for (var item in selectedFavorites) {
      totals['price'] = (totals['price'] ?? 0) + (item.price ?? 0);
      totals['water'] = (totals['water'] ?? 0) + (item.source?.water ?? 0);
      totals['vitaminD'] = (totals['vitaminD'] ?? 0) + (item.source?.vitaminD ?? 0);
      totals['omega3'] = (totals['omega3'] ?? 0) + (item.source?.omega3FattyAcid ?? 0);
      totals['vitaminB12'] = (totals['vitaminB12'] ?? 0) + (item.source?.vitaminB12 ?? 0);
      totals['fiber'] = (totals['fiber'] ?? 0) + (item.source?.fiber ?? 0);
      totals['vitE'] = (totals['vitE'] ?? 0) + (item.source?.vitE ?? 0);
      totals['calcium'] = (totals['calcium'] ?? 0) + (item.source?.calcium ?? 0);
      totals['iron'] = (totals['iron'] ?? 0) + (item.source?.iron ?? 0);
      totals['magnesium'] = (totals['magnesium'] ?? 0) + (item.source?.magnesium ?? 0);
      totals['potassium'] = (totals['potassium'] ?? 0) + (item.source?.potassium ?? 0);
    }
    
    log('💰 Total price: ${totals['price']}');
  }

  /// Save selection to database
  Future<void> _saveSelection() async {
    log('💾 Saving selection for member: ${widget.member.name}');
    
    try {
      await _repository.saveSelection(
        widget.member.memberId,
        selectedFavorites,
        totals['price'] ?? 0,
        totals['water'] ?? 0,
        totals['vitaminD'] ?? 0,
        totals['omega3'] ?? 0,
        totals['vitaminB12'] ?? 0,
        totals['fiber'] ?? 0,
        totals['vitE'] ?? 0,
        totals['calcium'] ?? 0,
        totals['iron'] ?? 0,
        totals['magnesium'] ?? 0,
        totals['potassium'] ?? 0,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selection saved successfully'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      log('✅ Selection saved successfully');
    } catch (e) {
      log('❌ Error saving selection: $e');
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save selection'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Sources Gallery'),
        actions: [
          if (!isLoading && !hasError)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              tooltip: 'Filter by meal',
              onSelected: applyFilter,
              itemBuilder: (context) {
                return [
                  _buildFilterMenuItem('All', Icons.restaurant),
                  _buildFilterMenuItem('Breakfast', Icons.breakfast_dining),
                  _buildFilterMenuItem('Lunch', Icons.lunch_dining),
                  _buildFilterMenuItem('Dinner', Icons.dinner_dining),
                ];
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  /// Build filter menu item
  PopupMenuItem<String> _buildFilterMenuItem(String label, IconData icon) {
    final isSelected = selectedFilter == label;
    
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  /// Build main body content
  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading food sources...'),
          ],
        ),
      );
    }

    if (hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage ?? 'An error occurred',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: fetchSourceNeutrants,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (filteredNeutrants.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'No food sources found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                selectedFilter == 'All'
                    ? 'No food sources available'
                    : 'No $selectedFilter options available',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (selectedFilter != 'All') ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => applyFilter('All'),
                  child: const Text('Show all foods'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Filter indicator
        if (selectedFilter != 'All')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Showing $selectedFilter items (${filteredNeutrants.length})',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => applyFilter('All'),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),

        // List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filteredNeutrants.length,
            itemBuilder: (context, index) {
              final item = filteredNeutrants[index];
              final isSelected = selectedFavorites.contains(item);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: CheckboxListTile(
                  title: Text(
                    item.source?.foodName ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'Price: ${item.price?.toStringAsFixed(2) ?? '0.00'} PKR',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.source?.likelyToEatIn != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Best for: ${item.source!.likelyToEatIn}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                  value: isSelected,
                  onChanged: (value) => toggleFavorite(item, value),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              );
            },
          ),
        ),

        // Total section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected Items:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${selectedFavorites.length}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${totals['price']?.toStringAsFixed(2) ?? '0.00'} PKR',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}