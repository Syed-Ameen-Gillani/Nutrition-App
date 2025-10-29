import 'package:isar/isar.dart';

part 'member_source.g.dart';

@collection
class SourceSelection {
  Id id = Isar.autoIncrement;

  String familyMemberUid;
  String selectedDate;
  List<String> sourceIds;

  double totalPrice;
  double totalWater;
  double totalVitaminD;
  double totalOmega3FattyAcid;
  double totalVitaminB12;
  double totalFiber;
  double totalVitE;
  double totalCalcium;
  double totalIron;
  double totalMagnesium;
  double totalPotassium;

  SourceSelection({
    required this.familyMemberUid,
    required this.selectedDate,
    required this.sourceIds,
    required this.totalPrice,
    required this.totalWater,
    required this.totalVitaminD,
    required this.totalOmega3FattyAcid,
    required this.totalVitaminB12,
    required this.totalFiber,
    required this.totalVitE,
    required this.totalCalcium,
    required this.totalIron,
    required this.totalMagnesium,
    required this.totalPotassium,
  });
}
