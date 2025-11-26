import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nutrovite/core/extensions/datetime_extensions.dart';
import 'package:nutrovite/features/home/models/family.dart';
import 'package:nutrovite/features/home/views/family_member_dashboard.dart';
import 'package:nutrovite/features/settings/views/add_family.dart';
import 'package:nutrovite/features/settings/views/profile_screen.dart';
import 'package:nutrovite/main.dart';

class FamilyNutritionScreen extends StatelessWidget {
  static const route = '/family';
  const FamilyNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final localUser = LocalUser.of(context).localUser;
    FamilyMember me = FamilyMember(
      memberId: firebaseUser.uid,
      name: firebaseUser.displayName != null &&
              firebaseUser.displayName!.isNotEmpty
          ? firebaseUser.displayName!
          : 'Your Name',
      gender: localUser!.gender,
      dob: localUser!.dateOfBirth.toDateTimeObject()!,
      maritalStatus: localUser!.maritalStatus,
      lactationStatus: localUser!.lactationStatus,
      familyStatus: 'Guardian',
      city: localUser!.city,
      photo: firebaseUser.photoURL ?? '',
      userId: firebaseUser.uid,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: Text(
                'Yourself',
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FamilyMemberCard(
                member: me,
                onEdit: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FamilyMemberDetails(member: me),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Text(
                'Family',
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('familyMembers')
                  .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final familyMembers = snapshot.data!.docs.map((doc) {
                    return FamilyMember.fromFirestore(doc);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: familyMembers.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final familyMember = familyMembers[index];
                      return FamilyMemberCard(
                        member: familyMember,
                        onDelete: () =>
                            deleteFamilyMember(familyMember.memberId),
                        onEdit: () => editFamilyMember(context, familyMember),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            FamilyMemberDetails.route,
                            arguments: familyMember,
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    'No family members!',
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Method to delete a family member
  Future<void> deleteFamilyMember(String familyMemberId) async {
    try {
      await FirebaseFirestore.instance
          .collection('familyMembers')
          .doc(familyMemberId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting family member: $e');
    }
  }

  // Method to edit a family member
  void editFamilyMember(BuildContext context, FamilyMember familyMember) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFamilyMemberScreen(familyMember: familyMember),
      ),
    );
  }
}

class FamilyMemberCard extends StatelessWidget {
  final FamilyMember member;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  final Widget? child;

  const FamilyMemberCard({
    super.key,
    required this.member,
    this.onDelete,
    this.onEdit,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: member.photo.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: member.photo,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 30,
                      ),
              ),
              title: Text(
                member.name,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              subtitle: Text(
                member.familyStatus,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    InkWell(
                      onTap: onEdit,
                      child: Icon(
                        Icons.edit_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryFixedVariant,
                      ),
                    ),
                  if (onDelete != null) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryFixedVariant,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:nutrovite/features/home/models/family.dart';
// import 'package:nutrovite/features/home/views/family_member_details.dart';
// import 'package:nutrovite/features/settings/views/add_family.dart';

// class FamilyNutritionScreen extends StatefulWidget {
//   const FamilyNutritionScreen({super.key});

//   @override
//   State<FamilyNutritionScreen> createState() => _FamilyNutritionScreenState();
// }

// class _FamilyNutritionScreenState extends State<FamilyNutritionScreen> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Family Nutrition'),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50.0),
//           child: SegmentedControl(
//             selectedIndex: _selectedIndex,
//             onValueChanged: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//           ),
//         ),
//       ),
//       body: _selectedIndex == 0 ? _buildYourself() : _buildFamilyMembers(),
//     );
//   }

//   Widget _buildYourself() {
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     return Center(
//       child: ListTile(
//         leading: CircleAvatar(
//           radius: 25,
//           backgroundColor: Colors.grey.shade200,
//           child: ClipOval(
//             child: CachedNetworkImage(
//               imageUrl: firebaseUser?.photoURL ?? '',
//               placeholder: (context, url) => const CircularProgressIndicator(),
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               width: 60,
//               height: 60,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         title: Text(
//           firebaseUser?.displayName ?? 'Your Name',
//           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                 color: Theme.of(context).colorScheme.onSurface,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         subtitle: Text(
//           firebaseUser?.email ?? 'Your Email',
//           style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                 color: Theme.of(context).colorScheme.onSurface,
//               ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFamilyMembers() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('familyMembers')
//           .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasData) {
//           final familyMembers = snapshot.data!.docs.map((doc) {
//             return FamilyMember.fromFirestore(doc);
//           }).toList();

//           return ListView.builder(
//             itemCount: familyMembers.length,
//             padding: const EdgeInsets.all(8.0),
//             itemBuilder: (context, index) {
//               final familyMember = familyMembers[index];
//               return FamilyMemberCard(
//                 member: familyMember,
//                 onDelete: () => deleteFamilyMember(familyMember.uid),
//                 onEdit: () => editFamilyMember(familyMember),
//               );
//             },
//           );
//         }
//         return Center(
//           child: Text(
//             'No family members!',
//             style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
//           ),
//         );
//       },
//     );
//   }

//   // Method to delete a family member
//   Future<void> deleteFamilyMember(String familyMemberId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('familyMembers')
//           .doc(familyMemberId)
//           .delete();
//     } catch (e) {
//       debugPrint('Error deleting family member: $e');
//     }
//   }

//   // Method to edit a family member
//   void editFamilyMember(FamilyMember familyMember) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddFamilyMemberScreen(familyMember: familyMember),
//       ),
//     );
//   }
// }

// class SegmentedControl extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onValueChanged;

//   const SegmentedControl({
//     super.key,
//     required this.selectedIndex,
//     required this.onValueChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () => onValueChanged(0),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                 decoration: BoxDecoration(
//                   color: selectedIndex == 0
//                       ? Theme.of(context).colorScheme.primary
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Yourself',
//                     style: TextStyle(
//                       color: selectedIndex == 0
//                           ? Theme.of(context).colorScheme.surface
//                           : Theme.of(context).colorScheme.onSurface,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: GestureDetector(
//               onTap: () => onValueChanged(1),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 12.0),
//                 decoration: BoxDecoration(
//                   color: selectedIndex == 1
//                       ? Theme.of(context).colorScheme.primary
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Family Members',
//                     style: TextStyle(
//                       color: selectedIndex == 1
//                           ? Theme.of(context).colorScheme.surface
//                           : Theme.of(context).colorScheme.onSurface,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FamilyMemberCard extends StatelessWidget {
//   final FamilyMember member;
//   final VoidCallback onDelete;
//   final VoidCallback onEdit;
//   final VoidCallback? onTap;
//   final Widget? child;

//   const FamilyMemberCard({
//     super.key,
//     required this.member,
//     required this.onDelete,
//     required this.onEdit,
//     this.child,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 0,
//       child: InkWell(
//         onTap: onTap ??
//             () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FamilyMemberDetails(member: member),
//                 ),
//               );
//             },
//         child: SizedBox(
//           height: 100,
//           child: Center(
//             child: ListTile(
//               leading: CircleAvatar(
//                 radius: 25,
//                 backgroundColor: Colors.grey.shade200,
//                 child: ClipOval(
//                   child: CachedNetworkImage(
//                     imageUrl: member.photo,
//                     placeholder: (context, url) =>
//                         const CircularProgressIndicator(),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error),
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 member.name,
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               subtitle: Text(
//                 member.familyStatus,
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface,
//                     ),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.edit,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     onPressed: onEdit,
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.delete_outline_rounded,
//                       color: Theme.of(context).colorScheme.error,
//                     ),
//                     onPressed: onDelete,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
