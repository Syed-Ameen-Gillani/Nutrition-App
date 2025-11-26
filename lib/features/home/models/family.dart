import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';

part 'family.g.dart';

@collection
class FamilyMember {
  Id id = Isar.autoIncrement;
  final String memberId;
  final String name;
  final String gender;
  final DateTime dob;
  final String maritalStatus;
  final String lactationStatus;
  final String familyStatus;
  final String city;
  final String photo;
  final String userId; // To identify which user this family member belongs to

  FamilyMember({
    required this.memberId,
    required this.name,
    required this.gender,
    required this.dob,
    required this.maritalStatus,
    required this.lactationStatus,
    required this.familyStatus,
    required this.city,
    required this.photo,
    required this.userId,
  });

  // Factory constructor to create a FamilyMember from Firestore document
  factory FamilyMember.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FamilyMember(
      memberId: data['memberId'],
      name: data['name'] ?? '',
      gender: data['gender'] ?? '',
      dob: (data['dob'] as Timestamp).toDate(),
      maritalStatus: data['maritalStatus'] ?? '',
      lactationStatus: data['lactationStatus'] ?? 'None',
      familyStatus: data['familyStatus'] ?? '',
      city: data['city'] ?? '',
      photo: data['photo'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId, // Add this line to include memberId
      'name': name,
      'gender': gender,
      'dob': Timestamp.fromDate(dob),
      'maritalStatus': maritalStatus,
      'lactationStatus': lactationStatus,
      'familyStatus': familyStatus,
      'city': city,
      'photo': photo,
      'userId': userId,
    };
  }
}
