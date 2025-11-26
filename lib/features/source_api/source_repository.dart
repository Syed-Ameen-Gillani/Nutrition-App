import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/core/extensions/datetime_extensions.dart';
import 'package:nutrovite/features/home/models/member_source.dart';
import 'package:nutrovite/features/source_api/source_neutrant.dart';
import 'package:nutrovite/main.dart';

class SourceNeutrantRepository {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 10),
  ));
  final Isar _isar = isar;

  Future<List<SourceNeutrant>?> getSourceOfNeutrents() async {
    // Try to fetch from Isar first
    List<SourceNeutrant> localData =
        await _isar.sourceNeutrants.where().findAll();

    // Remove duplicates based on foodName if local data exists
    if (localData.isNotEmpty) {
      log('Data fetched from Isar');
      List<SourceNeutrant> uniqueData = _removeDuplicatesByFoodName(localData);
      return uniqueData;
    }

    // Fetch from API if Isar has no data
    try {
      final response =
          await _dio.get('https://neovatus.onrender.com/api/prices');

      if (response.statusCode == 200 && response.data != null) {
        // Safely access the data with null checks
        final responseData = response.data;
        if (responseData is! Map<String, dynamic>) {
          log('Invalid response format: not a map');
          return null;
        }

        final dataList = responseData['data'];
        if (dataList == null) {
          log('No data field in response');
          return null;
        }

        if (dataList is! List) {
          log('Data field is not a list');
          return null;
        }

        log('Data fetched from API: ${dataList.length} items');

        // Safely parse each item
        List<SourceNeutrant> sourceNeutrants = [];
        for (var item in dataList) {
          try {
            if (item is Map<String, dynamic>) {
              sourceNeutrants.add(SourceNeutrant.fromJson(item));
            }
          } catch (e) {
            log('Error parsing item: $e');
            // Continue with other items
          }
        }

        if (sourceNeutrants.isEmpty) {
          log('No valid items could be parsed');
          return null;
        }

        // Remove duplicates based on foodName
        List<SourceNeutrant> uniqueData =
            _removeDuplicatesByFoodName(sourceNeutrants);

        // Save the unique data to Isar
        try {
          await _isar.writeTxn(() async {
            await _isar.sourceNeutrants.putAll(uniqueData);
          });
        } catch (e) {
          log('Error saving to Isar: $e');
          // Still return the data even if saving fails
        }

        return uniqueData;
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } catch (e, stackTrace) {
      log('Exception caught: $e');
      log('Stacktrace: $stackTrace');
      return null;
    }
  }

  List<SourceNeutrant> _removeDuplicatesByFoodName(
      List<SourceNeutrant> sourceNeutrants) {
    // Create a Set to track foodNames and filter duplicates
    final Set<String> seenFoodNames = {};

    return sourceNeutrants.where((neutrant) {
      // Check if the foodName is unique, if so add to the set
      final foodName = neutrant.source?.foodName;
      if (foodName != null && !seenFoodNames.contains(foodName)) {
        seenFoodNames.add(foodName);
        return true;
      }
      return false;
    }).toList();
  }

  Future<SourceSelection?> loadSavedData(String memberId) async {
    final today = DateTime.now().toDateString();

    // Fetch today's data for the member
    final savedSelection = await _isar.sourceSelections
        .filter()
        .familyMemberUidEqualTo(memberId)
        .selectedDateEqualTo(today)
        .findFirst();

    return savedSelection;
  }

  Future<void> saveSelection(
      String memberId,
      List<SourceNeutrant> selectedFavorites,
      double totalPrice,
      double totalWater,
      double totalVitaminD,
      double totalOmega3FattyAcid,
      double totalVitaminB12,
      double totalFiber,
      double totalVitE,
      double totalCalcium,
      double totalIron,
      double totalMagnesium,
      double totalPotassium) async {
    final isarDb = isar;
    final today = DateTime.now().toDateString();

    final sourceIds =
        selectedFavorites.map((source) => source.sId.toString()).toList();

    // Check if today's data already exists and update if found
    final existingSelection = await isarDb.sourceSelections
        .filter()
        .familyMemberUidEqualTo(memberId)
        .selectedDateEqualTo(today)
        .findFirst();

    if (existingSelection != null) {
      log('Updating existing selection for today');
      existingSelection.sourceIds = sourceIds;
      existingSelection.totalPrice = totalPrice;
      existingSelection.totalWater = totalWater;
      existingSelection.totalVitaminD = totalVitaminD;
      existingSelection.totalOmega3FattyAcid = totalOmega3FattyAcid;
      existingSelection.totalVitaminB12 = totalVitaminB12;
      existingSelection.totalFiber = totalFiber;
      existingSelection.totalVitE = totalVitE;
      existingSelection.totalCalcium = totalCalcium;
      existingSelection.totalIron = totalIron;
      existingSelection.totalMagnesium = totalMagnesium;
      existingSelection.totalPotassium = totalPotassium;

      await isarDb.writeTxn(() async {
        await isarDb.sourceSelections.put(existingSelection);
      });
    } else {
      log('Saving new selection for today');
      final newSelection = SourceSelection(
        familyMemberUid: memberId,
        selectedDate: today,
        sourceIds: sourceIds,
        totalPrice: totalPrice,
        totalWater: totalWater,
        totalVitaminD: totalVitaminD,
        totalOmega3FattyAcid: totalOmega3FattyAcid,
        totalVitaminB12: totalVitaminB12,
        totalFiber: totalFiber,
        totalVitE: totalVitE,
        totalCalcium: totalCalcium,
        totalIron: totalIron,
        totalMagnesium: totalMagnesium,
        totalPotassium: totalPotassium,
      );

      await isarDb.writeTxn(() async {
        await isarDb.sourceSelections.put(newSelection);
      });
    }

    log('Selection saved successfully');
  }


  Future<List<SourceNeutrant>> fetchSourceDetails(
      List<String> sourceIds) async {
    if (sourceIds.isEmpty) {
      return [];
    }
    return await _isar.sourceNeutrants.filter().anyOf(sourceIds,
        (query, sourceId) {
      return query.sIdEqualTo(sourceId);
    }).findAll();
  }
}
