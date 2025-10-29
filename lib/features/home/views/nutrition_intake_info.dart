import 'package:flutter/material.dart';
import 'package:nutrovite/features/home/models/nutrition_intake.dart';
import 'package:nutrovite/features/home/repositories/repositories.dart';

class NutritionIntakeInfo extends StatefulWidget {
  const NutritionIntakeInfo({super.key});

  @override
  State<NutritionIntakeInfo> createState() => _NutritionIntakeInfoState();
}

class _NutritionIntakeInfoState extends State<NutritionIntakeInfo> {
  NutritionIntakes? _nutrovite;
  bool _isLoading = true;
  bool _showFilters = false;
  String _selectedNutrientFilter = "All";
  String _selectedGroupFilter = "All";
  final NutroviteApi _apiService = NutroviteApi();
  // final ScrollController _scrollController = ScrollController();
  // double _lastScrollPosition = 0;

  final List<String> _nutrientFilters = [
    'All',
    'Iron',
    'Fiber',
    'Calcium',
    'Omega-3 Fatty Acids',
    'Vitamin D',
    'Vitamin E',
    'Vitamin B12',
    'Water',
    'Magnesium',
    'Potassium',
  ];

  final List<String> _groupFilters = [
    'All',
    'Child',
    'Adult',
    'Pregnancy',
    'Lactation',
    'Infant'
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   double currentScrollPosition = _scrollController.position.pixels;

  //   if (_scrollController.position.userScrollDirection ==
  //           ScrollDirection.reverse &&
  //       currentScrollPosition > _lastScrollPosition) {
  //     // Scrolling down, hide filters
  //     if (_showFilters) {
  //       setState(() {
  //         _showFilters = false;
  //       });
  //     }
  //   } else if (_scrollController.position.userScrollDirection ==
  //           ScrollDirection.forward &&
  //       currentScrollPosition < _lastScrollPosition) {
  //     // Scrolling up, show filters
  //     if (!_showFilters) {
  //       setState(() {
  //         _showFilters = true;
  //       });
  //     }
  //   }

  //   _lastScrollPosition = currentScrollPosition;
  // }

  Future<void> _fetchData() async {
    try {
      NutritionIntakes nutroviteData = await _apiService.fetchNutritionData();
      setState(() {
        _nutrovite = nutroviteData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Data> _filterNutrients() {
    List<Data> filteredList = _nutrovite!.data!;

    if (_selectedNutrientFilter != "All") {
      filteredList = filteredList.where((data) {
        return data.nId?.name?.toLowerCase() ==
            _selectedNutrientFilter.toLowerCase();
      }).toList();
    }

    if (_selectedGroupFilter != "All") {
      filteredList = filteredList.where((data) {
        return data.group?.toLowerCase() == _selectedGroupFilter.toLowerCase();
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Info'),
        actions: [
          IconButton(
            icon: Icon(
              _showFilters
                  ? Icons.filter_alt_off_rounded
                  : Icons.filter_alt_rounded,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
        bottom: _showFilters
            ? PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 100.0,
                  child: _buildFilters(),
                ),
              )
            : null,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _nutrovite != null && _nutrovite!.data != null
              ? ListView.builder(
                  // controller: _scrollController, // Commented out
                  itemCount: _filterNutrients().length,
                  itemBuilder: (context, index) {
                    Data nutrition = _filterNutrients()[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          nutrition.nId?.name ?? 'Unknown',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                                'Male Daily Nutrition: ${nutrition.mDailyNutritions ?? 'N/A'}'),
                            Text(
                                'Female Daily Nutrition: ${nutrition.fDailyNutritions ?? 'N/A'}'),
                            Text('Age: ${nutrition.age ?? 'N/A'}'),
                            Text('Group: ${nutrition.group ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('No data available')),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // Nutrient Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _nutrientFilters.map((filter) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  labelPadding: const EdgeInsets.all(0),
                  pressElevation: 1.0,
                  backgroundColor: Colors.transparent, // this doesn't work
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  label: Text(filter),
                  selected: _selectedNutrientFilter == filter,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedNutrientFilter = filter;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        // Group Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _groupFilters.map((group) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  labelPadding: const EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  label: Text(group),
                  selected: _selectedGroupFilter == group,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedGroupFilter = group;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // _scrollController.dispose(); // Commented out
    super.dispose();
  }
}
