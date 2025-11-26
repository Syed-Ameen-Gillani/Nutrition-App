class PriceList {
  bool? success;
  List<PriceData>? data;

  PriceList({this.success, this.data});

  PriceList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PriceData>[];
      json['data'].forEach((v) {
        data!.add(PriceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PriceData {
  String? sId;
  String? name;
  String? unit;
  String? image;
  String? nid;
  List<Price>? price;

  PriceData({this.sId, this.name, this.unit, this.image, this.nid, this.price});

  PriceData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    unit = json['unit'];
    image = json['image'];
    nid = json['nid'];
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add(Price.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['unit'] = unit;
    data['image'] = image;
    data['nid'] = nid;
    if (price != null) {
      data['price'] = price!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Price {
  String? province;
  int? price;

  Price({this.province, this.price});

  Price.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['province'] = province;
    data['price'] = price;
    return data;
  }
}
