import 'package:isar/isar.dart';

part 'nutrition_intake.g.dart';

@collection
class NutritionIntakes {
  Id id = Isar.autoIncrement; // Automatically generated ID
  int? status;
  String? message;
  int? count;
  List<Data>? data;

  NutritionIntakes({
    this.status,
    this.message,
    this.count,
    this.data,
  });

  // Deserialize JSON to NutritionIntakes object
  NutritionIntakes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  // Serialize NutritionIntakes object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['message'] = message;
    result['count'] = count;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

@embedded // Denotes that this is an embedded object, not a top-level collection
class Data {
  String? sId;
  NId? nId;
  String? mDailyNutritions;
  String? fDailyNutritions;
  String? age;
  String? group;
  int? iV;

  Data({
    this.sId,
    this.nId,
    this.mDailyNutritions,
    this.fDailyNutritions,
    this.age,
    this.group,
    this.iV,
  });

  // Deserialize JSON to Data object
  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nId = json['n_id'] != null ? NId.fromJson(json['n_id']) : null;
    mDailyNutritions = json['m_daily_nutritions'];
    fDailyNutritions = json['f_daily_nutritions'];
    age = json['age'];
    group = json['Group'];
    iV = json['__v'];
  }

  // Serialize Data object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['_id'] = sId;
    if (nId != null) {
      result['n_id'] = nId!.toJson();
    }
    result['m_daily_nutritions'] = mDailyNutritions;
    result['f_daily_nutritions'] = fDailyNutritions;
    result['age'] = age;
    result['Group'] = group;
    result['__v'] = iV;
    return result;
  }
}

@embedded
class NId {
  String? sId;
  String? name;
  int? iV;
  String? createdAt;
  String? updatedAt;

  NId({
    this.sId,
    this.name,
    this.iV,
    this.createdAt,
    this.updatedAt,
  });

  // Deserialize JSON to NId object
  NId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  // Serialize NId object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['_id'] = sId;
    result['name'] = name;
    result['__v'] = iV;
    result['createdAt'] = createdAt;
    result['updatedAt'] = updatedAt;
    return result;
  }
}
