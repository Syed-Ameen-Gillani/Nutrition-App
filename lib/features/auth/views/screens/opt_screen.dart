// import 'package:flutter/material.dart';
// import 'package:nutrovite/core/extensions/media_query_extensions.dart';
// import 'package:nutrovite/features/auth/repositories/auth_repository.dart';
// import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';
// import 'package:nutrovite/features/auth/views/widgets/auth_textfield.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _otpController = TextEditingController();
//   late String _token;
//   bool _isLoading = false; // Add this line

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     dynamic arguments = ModalRoute.of(context)?.settings.arguments;
//     if (arguments != null) {
//       _token = arguments as String;
//     } else {
//       _token = ''; // or handle the case when there's no token
//     }
//   }

//   void _verifyOtp() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true; // Start loading
//       });

//       final apiService = AuthRepository();
//       try {
//         await apiService.verifyOtp(
//           code: _otpController.text,
//           token: _token,
//         );
//         Navigator.pushNamed(context, '/signin'); // Navigate to sign-in screen
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to verify OTP')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false; // Stop loading
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Verify OTP',
//                     style: context.tTheme.displayMedium!.copyWith(
//                       color: context.cScheme.onPrimaryContainer,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   NeutroviteTextField(
//                       controller: _otpController,
//                       label: 'OTP',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter the OTP';
//                         }
//                         return null;
//                       }),
//                   const SizedBox(height: 40),
//                   _isLoading
//                       ? const CircularProgressIndicator() // Show loading indicator
//                       : CustomSubmitButton(
//                           label: 'Verify OTP',
//                           onPressed: _verifyOtp,
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:nutrovite/core/extensions/media_query_extensions.dart';
// // import 'package:nutrovite/features/auth/repositories/auth_repository.dart';
// // import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';
// // import 'package:nutrovite/features/auth/views/widgets/auth_textfield.dart';
// // import 'package:nutrovite/core/widgets/gradient_background.dart';
// //
// // class OtpScreen extends StatefulWidget {
// //   const OtpScreen({super.key});
// //
// //   @override
// //   State<OtpScreen> createState() => _OtpScreenState();
// // }
// //
// // class _OtpScreenState extends State<OtpScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _otpController = TextEditingController();
// //   late String _token;
// //   bool _isLoading = false; // Add this line
// //
// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     _token = ModalRoute.of(context)!.settings.arguments as String;
// //   }
// //
// // void _verifyOtp() async {
// //   if (_formKey.currentState!.validate()) {
// //     setState(() {
// //       _isLoading = true; // Start loading
// //     });
// //
// //     final apiService = AuthRepository();
// //     try {
// //       await apiService.verifyOtp(
// //         code: _otpController.text,
// //         token: _token,
// //       );
// //       Navigator.pushNamed(context, '/signin'); // Navigate to sign-in screen
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Failed to verify OTP')),
// //       );
// //     } finally {
// //       setState(() {
// //         _isLoading = false; // Stop loading
// //       });
// //     }
// //   }
// // }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Form(
// //             key: _formKey,
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'Verify OTP',
// //                     style: context.tTheme.displayMedium!.copyWith(
// //                       color: context.cScheme.onPrimaryContainer,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 40),
// //                   NeutroviteTextField(
// //                       controller: _otpController,
// //                       label: 'OTP',
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter the OTP';
// //                         }
// //                         return null;
// //                       }),
// //                   const SizedBox(height: 40),
// //                   _isLoading
// //                       ? const CircularProgressIndicator() // Show loading indicator
// //                       : CustomSubmitButton(
// //                     label: 'Verify OTP',
// //                     onPressed: _verifyOtp,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
