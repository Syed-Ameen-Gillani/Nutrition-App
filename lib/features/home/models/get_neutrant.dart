class GetNutrient {
  int? status;
  String? message;
  List<Neutrant>? data;

  GetNutrient({this.status, this.message, this.data});

  GetNutrient.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Neutrant>[];
      json['data'].forEach((v) {
        data!.add(Neutrant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Neutrant {
  String? sId;
  String? name;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Neutrant({this.sId, this.name, this.iV, this.createdAt, this.updatedAt});

  Neutrant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
