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
    return SourceNeutrant(
      sId: json['_id'],
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      quantity: (json['quantity'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      unit: json['unit'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
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
    return Source(
      sId: json['_id'],
      fId: json['f_id'],
      foodName: json['foodName'],
      category: json['category'],
      likelyToEatIn: json['likelyToEatIn'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'],
      water: (json['water'] as num?)?.toDouble(),
      vitaminD: (json['vitaminD'] as num?)?.toDouble(),
      omega3FattyAcid: (json['omega3FattyAcid'] as num?)?.toDouble(),
      vitaminB12: (json['vitaminB12'] as num?)?.toDouble(),
      fiber: (json['fiber'] as num?)?.toDouble(),
      vitE: (json['vitE'] as num?)?.toDouble(),
      calcium: (json['calcium'] as num?)?.toDouble(),
      iron: (json['iron'] as num?)?.toDouble(),
      magnesium: (json['magnesium'] as num?)?.toDouble(),
      potassium: (json['potassium'] as num?)?.toDouble(),
      iV: json['__v'],
      image: json['image'],
    );
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
    return City(
      sId: json['_id'],
      name: json['name'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    return data;
  }
}
