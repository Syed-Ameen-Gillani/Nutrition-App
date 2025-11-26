import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:nutrovite/core/utils/data.dart';
import 'package:nutrovite/features/auth/models/user_model.dart';
import 'package:nutrovite/features/home/view_models/form_fields.dart';
import 'package:nutrovite/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseUser = FirebaseAuth.instance.currentUser!;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  bool isLoading = true;
  bool isSubmitting = false;
  String gender = "Male";
  String status = "None";
  UserModel? user;
  DateTime? selectedDate;
  File? _imageFile;
  String? _imageUrl;
  String maritalStatus = "Unmarried";
  String city = "Islamabad";
  String lactationStatus = "None";

  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      // Save the form state and process data
      _formKey.currentState!.save();

      final profileData = user!.copyWith(
        name: _nameController.text,
        email: _emailController.text,
        dateOfBirth: _dobController.text,
        gender: gender,
        lactationStatus: gender != 'Female' ? 'None' : lactationStatus,
        maritalStatus: maritalStatus, // Marital Status included
        city: city,
        photoUrl: _imageUrl ?? firebaseUser.photoURL ?? '',
      );



      await _uploadImage();
      await _sendDataToServer(profileData);

      setState(() {
        isSubmitting = false;
      });

      toggleEditing();
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(firebaseUser.uid);
    await ref.putFile(_imageFile!);
    _imageUrl = await ref.getDownloadURL();

    await firebaseUser.updatePhotoURL(_imageUrl);
  }

  Future<void> _sendDataToServer(UserModel profileData) async {
    try {
      await firebaseUser.updateDisplayName(_nameController.text);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set(profileData.toMap(), SetOptions(merge: true));

      await isar.writeTxn(() async {
        // Remove any existing user model
        final existingUsers = await isar.userModels.where().findAll();
        final ids = existingUsers.map((user) => user.id).toList();
        await isar.userModels.deleteAll(ids);

        // Insert the new user model
        await isar.userModels.put(profileData);
      });

      log('User data updated successfully');
    } catch (e) {
      log('Error updating user data: $e');
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'Lactation':
        return const Icon(Icons.local_hospital_outlined);
      case 'Pregnancy':
        return const Icon(Icons.pregnant_woman_outlined);
      default:
        return const Icon(Icons.clear);
    }
  }

  void loadData() async {
    user = await isar.userModels.where().findFirst();

    if (user != null) {
      setState(() {
        _nameController.text = user!.name;
        _emailController.text = user!.email;
        _dobController.text = user!.dateOfBirth;
        gender = user!.gender;
        city = user!.city;
        maritalStatus = user!.maritalStatus; // Load marital status
        lactationStatus = user!.lactationStatus;
        _cityController.text = user!.city;
        _imageUrl = user!.photoUrl;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      setState(() {
        _imageFile = file;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: isEditing
            ? [
                IconButton(
                  icon: isSubmitting
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.done_outlined),
                  onPressed: isSubmitting ? null : _saveProfile,
                ),
              ]
            : [],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : _imageUrl != null
                                  ? CachedNetworkImageProvider(_imageUrl!)
                                  : const CachedNetworkImageProvider(
                                      'https://via.placeholder.com/150'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: toggleEditing,
                        child: Text(isEditing ? 'Cancel' : 'Edit Profile'),
                      ),
                      const SizedBox(height: 20),
                      ProfileField(
                        label: 'Name',
                        controller: _nameController,
                        icon: Icons.person_outline,
                        enabled: isEditing,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      ProfileField(
                        label: 'Email',
                        controller: _emailController,
                        icon: Icons.alternate_email,
                        enabled: isEditing,
                        validator: (value) {
                          if (value == null ||
                              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      ProfileField(
                        label: 'DOB',
                        controller: _dobController,
                        icon: Icons.calendar_today_outlined,
                        enabled: isEditing,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date of birth';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed:
                              isEditing ? () => _selectDate(context) : null,
                        ),
                      ),
                      CustomDropdown(
                        selectedValue: city,
                        label: 'City',
                        icon: const Icon(Icons.location_city_outlined),
                        items: cities,
                        enabled: isEditing,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              city = value;
                            });
                          }
                        },
                      ),
                      CustomDropdown(
                        selectedValue: gender,
                        label: 'Gender',
                        icon: const Icon(Icons.person_outline),
                        items: genders,
                        enabled: isEditing,
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                      ),
                      CustomDropdown(
                        selectedValue: maritalStatus,
                        label: 'Marital Status',
                        icon: const Icon(Icons.favorite_outline),
                        items: const <String>[
                          'Unmarried',
                          'Married',
                        ],
                        enabled: isEditing,
                        onChanged: (String? newValue) {
                          setState(() {
                            maritalStatus = newValue!;
                          });
                        },
                      ),
                      if (gender == 'Female' && maritalStatus == 'Married')
                        CustomDropdown(
                          selectedValue: lactationStatus,
                          label: 'Lactation Status',
                          icon: _getStatusIcon(lactationStatus),
                          items: const <String>[
                            'None',
                            'Pregnant',
                            'Lactating'
                          ],
                          enabled: isEditing,
                          onChanged: (String? newValue) {
                            setState(() {
                              lactationStatus = newValue!;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}



// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:isar/isar.dart';
// import 'package:nutrovite/core/utils/data.dart';
// import 'package:nutrovite/features/auth/models/user_model.dart';
// import 'package:nutrovite/features/home/view_models/form_fields.dart';
// import 'package:nutrovite/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final firebaseUser = FirebaseAuth.instance.currentUser!;
//   bool isEditing = false;
//   bool isLoading = true;
//   String gender = "Male";
//   String status = "None";
//   UserModel? user;
//   DateTime? selectedDate;
//   File? _imageFile;
//   String? _imageUrl;
//   String maritalStatus = "Unmarried";
//   String city = "Islamabad";
//   String lactationStatus = "None";

//   final _formKey = GlobalKey<FormState>();

//   // Controllers for text fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();

//   void toggleEditing() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }

//   void _saveProfile() async {
//     await _uploadImage();
//     if (_formKey.currentState!.validate()) {
//       // Save the form state and process data
//       _formKey.currentState!.save();

//       final profileData = user!.copyWith(
//         name: _nameController.text,
//         email: _emailController.text,
//         dateOfBirth: _dobController.text,
//         gender: gender,
//         lactationStatus: lactationStatus,
//         maritalStatus: maritalStatus, // Marital Status included
//         city: city,
//         photoUrl: _imageUrl ?? firebaseUser.photoURL ?? '',
//       );
//       _sendDataToServer(profileData);
//       toggleEditing();
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_imageFile == null) return;

//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('profile_images')
//         .child(firebaseUser.uid);
//     await ref.putFile(_imageFile!);
//     _imageUrl = await ref.getDownloadURL();

//     await firebaseUser.updatePhotoURL(_imageUrl);
//   }

//   void _sendDataToServer(UserModel profileData) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .set(profileData.toMap(), SetOptions(merge: true));

//       await isar.writeTxn(() async {
//         // Remove any existing user model
//         final existingUsers = await isar.userModels.where().findAll();
//         final ids = existingUsers.map((user) => user.id).toList();
//         await isar.userModels.deleteAll(ids);
//         // Insert the new user model
//         await isar.userModels.put(profileData);
//       });

//       log('User data updated successfully');
//     } catch (e) {
//       log('Error updating user data: $e');
//     }
//   }

//   Icon _getStatusIcon(String status) {
//     switch (status) {
//       case 'Lactation':
//         return const Icon(Icons.local_hospital_outlined);
//       case 'Pregnancy':
//         return const Icon(Icons.pregnant_woman_outlined);
//       default:
//         return const Icon(Icons.clear);
//     }
//   }

//   void loadData() async {
//     user = await isar.userModels.where().findFirst();

//     if (user != null) {
//       setState(() {
//         _nameController.text = user!.name;
//         _emailController.text = user!.email;
//         _dobController.text = user!.dateOfBirth;
//         gender = user!.gender;
//         city = user!.city;
//         maritalStatus = user!.maritalStatus; // Load marital status
//         lactationStatus = user!.lactationStatus;
//         _cityController.text = user!.city;
//         _imageUrl = user!.photoUrl;
//       });
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   // Date picker function
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
//       });
//     }
//   }

//   // Function to pick image from gallery
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 10,
//     );
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       setState(() {
//         _imageFile = file;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         elevation: 0,
//         actions: isEditing
//             ? [
//                 IconButton(
//                   icon: const Icon(Icons.done_outlined),
//                   onPressed: _saveProfile,
//                 ),
//               ]
//             : [],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24.0, vertical: 16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: CircleAvatar(
//                           radius: 60,
//                           backgroundImage: _imageFile != null
//                               ? FileImage(_imageFile!)
//                               : (_imageUrl != null
//                                       ? NetworkImage(_imageUrl!)
//                                       : const NetworkImage(
//                                           'https://via.placeholder.com/150'))
//                                   as ImageProvider,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: toggleEditing,
//                         child: Text(isEditing ? 'Cancel' : 'Edit Profile'),
//                       ),
//                       const SizedBox(height: 20),
//                       ProfileField(
//                         label: 'Name',
//                         controller: _nameController,
//                         icon: Icons.person_outline,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       ProfileField(
//                         label: 'Email',
//                         controller: _emailController,
//                         icon: Icons.alternate_email,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null ||
//                               !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       ProfileField(
//                         label: 'DOB',
//                         controller: _dobController,
//                         icon: Icons.calendar_today_outlined,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the date of birth';
//                           }
//                           return null;
//                         },
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.calendar_today),
//                           onPressed:
//                               isEditing ? () => _selectDate(context) : null,
//                         ),
//                       ),
//                       CustomDropdown(
//                         selectedValue: gender,
//                         label: 'Gender',
//                         icon: const Icon(Icons.person_outline),
//                         items: genders,
//                         enabled: isEditing,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             gender = newValue!;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       if (gender == 'Female')
//                         CustomDropdown(
//                           selectedValue: status,
//                           label: 'Status',
//                           icon: _getStatusIcon(status),
//                           items: const <String>[
//                             'None',
//                             'Lactation',
//                             'Pregnancy'
//                           ],
//                           enabled: isEditing,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               status = newValue!;
//                             });
//                           },
//                         ),
//                       ProfileField(
//                         label: 'City',
//                         controller: _cityController,
//                         icon: Icons.location_city_outlined,
//                         enabled: isEditing,
//                         onChanged: (value) {
//                           setState(() {
//                             city = value!;
//                           });
//                         },
//                         validator: (p0) =>
//                             p0!.isEmpty ? 'City is required' : null,
//                       ),
//                       CustomDropdown(
//                         selectedValue: maritalStatus,
//                         label: 'Marital Status',
//                         icon: const Icon(Icons.favorite_outline),
//                         items: const <String>[
//                           'Unmarried',
//                           'Married',
//                           'Divorced',
//                           'Widowed'
//                         ],
//                         enabled: isEditing,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             maritalStatus = newValue!;
//                           });
//                         },
//                       ),
//                       if (gender == 'Female' && maritalStatus == 'Married')
//                         CustomDropdown(
//                           selectedValue: lactationStatus,
//                           label: 'Lactation Status',
//                           icon: const Icon(Icons.local_hospital_outlined),
//                           items: const <String>[
//                             'None',
//                             'Pregnant',
//                             'Lactating'
//                           ],
//                           enabled: isEditing,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               lactationStatus = newValue!;
//                             });
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _dobController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }
// }


// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:isar/isar.dart';
// import 'package:nutrovite/core/utils/data.dart';
// import 'package:nutrovite/features/auth/models/user_model.dart';
// import 'package:nutrovite/features/home/view_models/form_fields.dart';
// import 'package:nutrovite/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final firebaseUser = FirebaseAuth.instance.currentUser!;
//   bool isEditing = false;
//   bool isLoading = true;
//   String gender = "Male";
//   String status = "None";
//   UserModel? user;
//   DateTime? selectedDate;
//   File? _imageFile;
//   String? _imageUrl;
//   String maritalStatus = "Unmarried";
//   String city = "Islamabad";
//   String lactationStatus = "None";

//   final _formKey = GlobalKey<FormState>();

//   // Controllers for text fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();

//   void toggleEditing() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }

//   void _saveProfile() async {
//     await _uploadImage();
//     if (_formKey.currentState!.validate()) {
//       // Save the form state and process data
//       _formKey.currentState!.save();

//       final profileData = user!.copyWith(
//         name: _nameController.text,
//         email: _emailController.text,
//         dateOfBirth: _dobController.text,
//         gender: gender,
//         lactationStatus: lactationStatus,
//         maritalStatus: maritalStatus,
//         city: city,
//         photoUrl: _imageUrl ?? firebaseUser.photoURL ?? '',
//       );
//       _sendDataToServer(profileData);
//       toggleEditing();
//     }
//   }

//   Future<void> _uploadImage() async {
//     if (_imageFile == null) return;

//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('profile_images')
//         .child(firebaseUser.uid);
//     await ref.putFile(_imageFile!);
//     _imageUrl = await ref.getDownloadURL();

//     await firebaseUser.updatePhotoURL(_imageUrl);
//   }

//   void _sendDataToServer(UserModel profileData) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .set(profileData.toMap(), SetOptions(merge: true));
//       log('User data updated successfully');
//     } catch (e) {
//       log('Error updating user data: $e');
//     }
//   }

//   Icon _getStatusIcon(String status) {
//     switch (status) {
//       case 'Lactation':
//         return const Icon(Icons.local_hospital_outlined);
//       case 'Pregnancy':
//         return const Icon(Icons.pregnant_woman_outlined);
//       default:
//         return const Icon(Icons.clear);
//     }
//   }

//   void loadData() async {
//     user = await isar.userModels.where().findFirst();

//     if (user != null) {
//       setState(() {
//         _nameController.text = user!.name;
//         _emailController.text = user!.email;
//         _dobController.text = user!.dateOfBirth;
//         gender = user!.gender;
//         city = user!.city;
//         maritalStatus = user!.maritalStatus;
//         lactationStatus = user!.lactationStatus;
//         _cityController.text = user!.city;
//         _imageUrl = user!.photoUrl;
//       });
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   // Date picker function
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
//       });
//     }
//   }

//   // Function to pick image from gallery
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 10,
//     );
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       setState(() {
//         _imageFile = file;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         elevation: 0,
//         actions: isEditing
//             ? [
//                 IconButton(
//                   icon: const Icon(Icons.done_outlined),
//                   onPressed: _saveProfile,
//                 ),
//               ]
//             : [],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24.0, vertical: 16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: CircleAvatar(
//                           radius: 60,
//                           backgroundImage: _imageFile != null
//                               ? FileImage(_imageFile!)
//                               : (_imageUrl != null
//                                   ? NetworkImage(_imageUrl!)
//                                   : const NetworkImage(
//                                       'https://via.placeholder.com/150')) as ImageProvider,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: toggleEditing,
//                         child: Text(isEditing ? 'Cancel' : 'Edit Profile'),
//                       ),
//                       const SizedBox(height: 20),
//                       ProfileField(
//                         label: 'Name',
//                         controller: _nameController,
//                         icon: Icons.person_outline,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       ProfileField(
//                         label: 'Email',
//                         controller: _emailController,
//                         icon: Icons.alternate_email,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null ||
//                               !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       ProfileField(
//                         label: 'DOB',
//                         controller: _dobController,
//                         icon: Icons.calendar_today_outlined,
//                         enabled: isEditing,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the date of birth';
//                           }
//                           return null;
//                         },
//                         suffixIcon: IconButton(
//                           icon: const Icon(Icons.calendar_today),
//                           onPressed:
//                               isEditing ? () => _selectDate(context) : null,
//                         ),
//                       ),
//                       CustomDropdown(
//                         selectedValue: gender,
//                         label: 'Gender',
//                         icon: const Icon(Icons.person_outline),
//                         items: genders,
//                         enabled: isEditing,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             gender = newValue!;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       if (gender == 'Female')
//                         CustomDropdown(
//                           selectedValue: status,
//                           label: 'Status',
//                           icon: _getStatusIcon(status), // Dynamic icon for status
//                           items: const <String>[
//                             'None',
//                             'Lactation',
//                             'Pregnancy'
//                           ],
//                           enabled: isEditing,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               status = newValue!;
//                             });
//                           },
//                         ),
//                       ProfileField(
//                         label: 'City',
//                         controller: _cityController,
//                         icon: Icons.location_city_outlined,
//                         enabled: isEditing,
//                         onChanged: (value) {
//                           setState(() {
//                             city = value!;
//                           });
//                         },
//                         validator: (p0) =>
//                             p0!.isEmpty ? 'City is required' : null,
//                       ),
//                       if (gender == 'Female' && maritalStatus == 'Married')
//                         CustomDropdown(
//                           selectedValue: lactationStatus,
//                           label: 'Lactation Status',
//                           icon: const Icon(Icons.local_hospital_outlined),
//                           items: const <String>[
//                             'None',
//                             'Pregnant',
//                             'Lactating'
//                           ],
//                           enabled: isEditing,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               lactationStatus = newValue!;
//                             });
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }
// }
