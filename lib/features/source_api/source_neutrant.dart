import 'package:isar/isar.dart';

part 'source_neutrant.g.dart';

@Collection()
class SourceNeutrant {
  Id id = Isar.autoIncrement; // Isar primary key

  String? sId;
  Source? source;
  City? city;
  double? quantity;
  double? price;
  String? unit;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SourceNeutrant({
    this.sId,
    this.source,
    this.city,
    this.quantity,
    this.price,
    this.unit,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory SourceNeutrant.fromJson(Map<String, dynamic> json) {
    try {
      return SourceNeutrant(
        sId: json['_id']?.toString(),
        source: json['source'] != null && json['source'] is Map<String, dynamic> 
            ? Source.fromJson(json['source'] as Map<String, dynamic>) 
            : null,
        city: json['city'] != null && json['city'] is Map<String, dynamic>
            ? City.fromJson(json['city'] as Map<String, dynamic>) 
            : null,
        quantity: _parseDouble(json['quantity']),
        price: _parseDouble(json['price']),
        unit: json['unit']?.toString(),
        createdAt: json['createdAt']?.toString(),
        updatedAt: json['updatedAt']?.toString(),
        iV: _parseInt(json['__v']),
      );
    } catch (e) {
      // Return a default object if parsing fails
      return SourceNeutrant(
        sId: json['_id']?.toString() ?? 'unknown',
        source: null,
        city: null,
        quantity: 0.0,
        price: 0.0,
        unit: 'unit',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        iV: 0,
      );
    }
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['quantity'] = quantity;
    data['price'] = price;
    data['unit'] = unit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

@Embedded() // Use @Embedded() to embed the Source object
class Source {
  String? sId;
  String? fId;
  String? foodName;
  String? category;
  String? likelyToEatIn;
  double? quantity;
  String? unit;
  double? water;
  double? vitaminD;
  double? omega3FattyAcid;
  double? vitaminB12;
  double? fiber;
  double? vitE;
  double? calcium;
  double? iron;
  double? magnesium;
  double? potassium;
  int? iV;
  String? image;

  Source({
    this.sId,
    this.fId,
    this.foodName,
    this.category,
    this.likelyToEatIn,
    this.quantity,
    this.unit,
    this.water,
    this.vitaminD,
    this.omega3FattyAcid,
    this.vitaminB12,
    this.fiber,
    this.vitE,
    this.calcium,
    this.iron,
    this.magnesium,
    this.potassium,
    this.iV,
    this.image,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    try {
      return Source(
        sId: json['_id']?.toString(),
        fId: json['f_id']?.toString(),
        foodName: json['foodName']?.toString() ?? 'Unknown Food',
        category: json['category']?.toString(),
        likelyToEatIn: json['likelyToEatIn']?.toString(),
        quantity: SourceNeutrant._parseDouble(json['quantity']),
        unit: json['unit']?.toString(),
        water: SourceNeutrant._parseDouble(json['water']) ?? 0.0,
        vitaminD: SourceNeutrant._parseDouble(json['vitaminD']) ?? 0.0,
        omega3FattyAcid: SourceNeutrant._parseDouble(json['omega3FattyAcid']) ?? 0.0,
        vitaminB12: SourceNeutrant._parseDouble(json['vitaminB12']) ?? 0.0,
        fiber: SourceNeutrant._parseDouble(json['fiber']) ?? 0.0,
        vitE: SourceNeutrant._parseDouble(json['vitE']) ?? 0.0,
        calcium: SourceNeutrant._parseDouble(json['calcium']) ?? 0.0,
        iron: SourceNeutrant._parseDouble(json['iron']) ?? 0.0,
        magnesium: SourceNeutrant._parseDouble(json['magnesium']) ?? 0.0,
        potassium: SourceNeutrant._parseDouble(json['potassium']) ?? 0.0,
        iV: SourceNeutrant._parseInt(json['__v']),
        image: json['image']?.toString(),
      );
    } catch (e) {
      // Return a default source if parsing fails
      return Source(
        sId: json['_id']?.toString() ?? 'unknown',
        fId: json['f_id']?.toString(),
        foodName: json['foodName']?.toString() ?? 'Unknown Food',
        category: 'Unknown',
        likelyToEatIn: 'Any time',
        quantity: 100.0,
        unit: 'g',
        water: 0.0,
        vitaminD: 0.0,
        omega3FattyAcid: 0.0,
        vitaminB12: 0.0,
        fiber: 0.0,
        vitE: 0.0,
        calcium: 0.0,
        iron: 0.0,
        magnesium: 0.0,
        potassium: 0.0,
        iV: 0,
        image: null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['f_id'] = fId;
    data['foodName'] = foodName;
    data['category'] = category;
    data['likelyToEatIn'] = likelyToEatIn;
    data['quantity'] = quantity;
    data['unit'] = unit;
    data['water'] = water;
    data['vitaminD'] = vitaminD;
    data['omega3FattyAcid'] = omega3FattyAcid;
    data['vitaminB12'] = vitaminB12;
    data['fiber'] = fiber;
    data['vitE'] = vitE;
    data['calcium'] = calcium;
    data['iron'] = iron;
    data['magnesium'] = magnesium;
    data['potassium'] = potassium;
    data['__v'] = iV;
    data['image'] = image;
    return data;
  }
}

@Embedded() // Use @Embedded() to embed the City object
class City {
  String? sId;
  String? name;
  int? iV;

  City({this.sId, this.name, this.iV});

  factory City.fromJson(Map<String, dynamic> json) {
    try {
      return City(
        sId: json['_id']?.toString(),
        name: json['name']?.toString() ?? 'Unknown City',
        iV: SourceNeutrant._parseInt(json['__v']),
      );
    } catch (e) {
      return City(
        sId: json['_id']?.toString() ?? 'unknown',
        name: 'Unknown City',
        iV: 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    return data;
  }
}
