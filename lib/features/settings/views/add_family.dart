import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrovite/core/utils/data.dart';
import 'package:nutrovite/features/home/models/family.dart';
import 'package:nutrovite/features/home/view_models/form_fields.dart';
import 'package:uuid/uuid.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  final FamilyMember? familyMember;

  const AddFamilyMemberScreen({super.key, this.familyMember});

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  bool isEditing = false;
  bool isLoading = false; // Added isLoading variable
  String gender = "Male";
  String maritalStatus = "Unmarried";
  String lactationStatus = "None";
  String familyStatus = "Son";
  String city = "Karachi"; // Default city
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();

  File? _imageFile; // To store the selected image
  String? _imageUrl; // To store the URL of the uploaded image

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final ImagePicker _picker = ImagePicker(); // Instance of image picker

  @override
  void initState() {
    super.initState();
    if (widget.familyMember != null) {
      log(widget.familyMember!.memberId);
      isEditing = true;
      _nameController.text = widget.familyMember!.name;
      _dobController.text =
          DateFormat('yyyy-MM-dd').format(widget.familyMember!.dob);
      selectedDate = widget.familyMember!.dob;
      gender = widget.familyMember!.gender;
      maritalStatus = widget.familyMember!.maritalStatus;
      lactationStatus = widget.familyMember!.lactationStatus;
      familyStatus = widget.familyMember!.familyStatus;
      city = widget.familyMember!.city;
      _imageUrl = widget.familyMember!.photo;
    }
  }

  // Function to toggle editing mode
  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
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

  // Function to upload image to Firebase Storage
  Future<String> _uploadImage() async {
    if (_imageFile == null) throw Exception('No image selected');

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref =
        FirebaseStorage.instance.ref().child('family_images').child(fileName);
    await ref.putFile(_imageFile!);
    return await ref.getDownloadURL();
  }

  // Function to save family member
  void _saveFamilyMember() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Use selectedDate if available, otherwise get from _dobController as fallback
      String formattedDob = selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : _dobController.text;

      try {
        setState(() {
          isLoading = true; // Set isLoading to true
        });

        // Upload image and get the URL
        String imageUrl = _imageUrl ?? await _uploadImage();
        final uid = const Uuid().v1();

        // Create FamilyMember object
        final familyMember = FamilyMember(
          memberId: widget.familyMember?.memberId ?? uid,
          name: _nameController.text,
          gender: gender,
          dob: DateFormat('yyyy-MM-dd').parse(formattedDob),
          maritalStatus: maritalStatus,
          lactationStatus: gender == 'Female' && maritalStatus == 'Married'
              ? lactationStatus
              : 'None',
          familyStatus: familyStatus,
          city: city,
          photo: imageUrl,
          userId: FirebaseAuth
              .instance.currentUser!.uid, // Replace with the actual user ID
        );

        log(familyMember.memberId.toString());
        // Save to Firestore
        await FirebaseFirestore.instance
            .collection('familyMembers')
            .doc(familyMember.memberId)
            .set(familyMember.toMap());

        toggleEditing();
      } catch (e) {
        log('Failed to upload image or save data: $e');
      } finally {
        setState(() {
          isLoading = false; // Set isLoading to false
        });
      }
    }
  }

  // Function to show the modal bottom sheet
  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('View Image'),
              onTap: () {
                Navigator.pop(context);
                _viewImage(); // Fullscreen view function
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Image'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(); // Call image picker
              },
            ),
          ],
        );
      },
    );
  }

  // Function to view image in full screen
  void _viewImage() {
    if (widget.familyMember != null) {
      Navigator.of(context).pushNamed(
        '/photo',
        arguments: widget.familyMember!.photo,
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.familyMember == null)
            ? const Text('New Member')
            : const Text('Update Member'),
        centerTitle: true,
        elevation: 0,
        actions: isEditing
            ? [
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ))
                    : IconButton(
                        icon: const Icon(Icons.done_outlined),
                        onPressed: _saveFamilyMember,
                      ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showImageOptions, // Show modal options
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (_imageUrl != null
                            ? NetworkImage(_imageUrl!)
                            : const NetworkImage(
                                'https://via.placeholder.com/150',
                              )) as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: toggleEditing,
                  child: Text(isEditing ? 'Cancel' : 'Add Family Member'),
                ),
                const SizedBox(height: 20),
                ProfileField(
                  label: 'Name',
                  controller: _nameController,
                  icon: Icons.person_outline,
                  enabled: isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
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
                    onPressed: isEditing ? () => _selectDate(context) : null,
                  ),
                ),
                CustomDropdown(
                  selectedValue: gender,
                  label: 'Gender',
                  icon: const Icon(Icons.person_outline),
                  items: const <String>['Male', 'Female', 'Other'],
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
                    'Divorced',
                    'Widowed'
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
                    icon: const Icon(Icons.local_hospital_outlined),
                    items: const <String>['None', 'Pregnant', 'Lactating'],
                    enabled: isEditing,
                    onChanged: (String? newValue) {
                      setState(() {
                        lactationStatus = newValue!;
                      });
                    },
                  ),
                CustomDropdown(
                  selectedValue: familyStatus,
                  label: 'Family Status',
                  icon: const Icon(Icons.people_outline),
                  items: const <String>['Father', 'Mother', 'Son', 'Daughter'],
                  enabled: isEditing,
                  onChanged: (String? newValue) {
                    setState(() {
                      familyStatus = newValue!;
                    });
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
