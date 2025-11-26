import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/features/auth/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Isar _isar;

  AuthRepository(this._isar);

  Future<UserModel> createUser({
    required String name,
    required String email,
    required String password,
    required String age,
    required String gender,
    required String dob,
    required String city,
    String lactationStatus = 'None',
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Create UserModel instance
        final newUser = UserModel(
          uid: user.uid,
          name: name,
          email: email,
          dateOfBirth: dob,
          gender: gender,
          city: city,
          lactationStatus: lactationStatus,
          maritalStatus: 'Unmarried',
          photoUrl: '',
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        await _auth.currentUser!.updateDisplayName(newUser.name);
        // Save to local Isar database
        await _isar.writeTxn(() async {
          // Remove any existing user model
          final existingUsers = await _isar.userModels.where().findAll();
          final ids = existingUsers.map((user) => user.id).toList();
          await _isar.userModels.deleteAll(ids);
          // Insert the new user model
          await _isar.userModels.put(newUser);
        });

        return newUser;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to create user');
    }
  }

  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Fetch user details from Firestore
        final docSnapshot =
            await _firestore.collection('users').doc(user.uid).get();
        final UserModel existingUser =
            UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
        // Save to local Isar database
        await _isar.writeTxn(() async {
          // Remove any existing user model
          final existingUsers = await _isar.userModels.where().findAll();
          final ids = existingUsers.map((user) => user.id).toList();
          await _isar.userModels.deleteAll(ids);
          // Insert the new user model
          await _isar.userModels.put(existingUser);
        });

        return existingUser;
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signOut() async {
    try {
      // Clear user data from Isar
      await _isar.writeTxn(() async {
        final existingUsers = await _isar.userModels.where().findAll();
        final ids = existingUsers.map((user) => user.id).toList();
        await _isar.userModels.deleteAll(ids);
      });

      // Sign out from Firebase Auth
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to sign out');
    }
  }

  Future<UserModel?> getSavedUser() async {
    try {
      // Retrieve the saved user model from Isar
      final user = await _isar.userModels.where().findFirst();
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}



// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:nutrovite/features/home/models/constants.dart';
//
// class AuthRepository {
//   static const String baseUrl = ServerConstants.baseUrl;
//
//   Future<String> createUser({
//     required String name,
//     required String email,
//     required String password,
//     required String age,
//     required String gender,
//     required String dob,
//     required String province,
//   }) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/user/create'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'name': name,
//         'email': email,
//         'password': password,
//         'age': age,
//         'Areyou': gender,
//         'DoB': dob,
//         'Province': province,
//       }),
//     );
//
//     log('=============================');
//     log(response.body);
//     log(response.statusCode.toString());
//
//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       return responseData['user']
//           ['otpToken']; // Extract the token from the response
//     } else {
//       throw Exception('Failed to create user');
//     }
//   }
//
//   Future<void> verifyOtp({
//     required String code,
//     required String token,
//   }) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/user/otp'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token', // Add the token to the headers
//       },
//       body: jsonEncode(<String, String>{
//         'code': code,
//       }),
//     );
//
//     log('=============================');
//     log(response.body);
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to verify OTP');
//     }
//   }
//
//   Future<Map<String, dynamic>> signin({
//     required String email,
//     required String password,
//   }) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/user/signin'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'email': email,
//         'password': password,
//       }),
//     );
//
//     log('=============================');
//     log(response.body);
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to sign in');
//     }
//
//     return jsonDecode(response.body);
//   }
// }
