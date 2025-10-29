import 'package:isar/isar.dart';
import 'dart:convert';

part 'user_model.g.dart';

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;
  late String uid;
  late String name;
  late String email;
  late String dateOfBirth;
  late String gender;
  late String city;
  late String lactationStatus;
  late String maritalStatus;
  late String photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.city,
    required this.lactationStatus,
    required this.maritalStatus,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'city': city,
      'lactationStatus': lactationStatus,
      'maritalStatus': maritalStatus,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      city: map['city'],
      lactationStatus: map['lactationStatus'],
      maritalStatus: map['maritalStatus'],
      photoUrl: map['photoUrl'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? dateOfBirth,
    String? gender,
    String? city,
    String? lactationStatus,
    String? maritalStatus,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      lactationStatus: lactationStatus ?? this.lactationStatus,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
