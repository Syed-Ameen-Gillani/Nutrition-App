// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nutrovite/features/home/view_models/form_fields.dart';
// import 'package:nutrovite/features/settings/bloc/gemini_api.dart';
// import 'package:nutrovite/features/chat_bot/repositories/chat_repository.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class CustomButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onPressed;
//   final Color backgroundColor;
//   final Color foregroundColor;

//   const CustomButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.foregroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       width: MediaQuery.of(context).size.width * 0.7,
//       height: MediaQuery.of(context).size.height * 0.07,
//       child: FilledButton.icon(
//         icon: Icon(
//           icon,
//           size: 18,
//         ),
//         onPressed: onPressed,
//         style: FilledButton.styleFrom(
//           backgroundColor: backgroundColor,
//           foregroundColor: foregroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         label: Text(
//           label,
//           style: const TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

// class UpdateApiKeyScreen extends StatefulWidget {
//   const UpdateApiKeyScreen({super.key});

//   @override
//   State<UpdateApiKeyScreen> createState() => _UpdateApiKeyScreenState();
// }

// class _UpdateApiKeyScreenState extends State<UpdateApiKeyScreen> {
//   bool _isEditing = false;
//   final _apiKeyController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isSubmitting = false;

//   // Function to toggle editing mode
//   void _toggleEditing() {
//     setState(() {
//       _isEditing = !_isEditing;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     final currentApiKey = context.read<GeminiApiCubit>().state;
//     _apiKeyController.text = currentApiKey ?? ''; // Load current API key
//   }

//   @override
//   void dispose() {
//     _apiKeyController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveApiKey() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isSubmitting = true;
//       });

//       final newApiKey = _apiKeyController.text.trim();
//       context.read<GeminiApiCubit>().setGeminiApiKey(newApiKey);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('API key updated successfully')),
//       );

//       _isSubmitting = false;
//       _toggleEditing();
//     }
//   }

//   // void _clearApiKey() {
//   //   context.read<GeminiApiCubit>().clearGeminiApiKey();
//   //   _apiKeyController.clear();

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(content: Text('API key cleared')),
//   //   );
//   // // }

//   // Future<void> _viewAvailableModels() async {
//   //   final apiKey = context.read<GeminiApiCubit>().state;
//   //   if (apiKey == null || apiKey.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Please set an API key first')),
//   //     );
//   //     return;
//   //   }

//   //   try {
//   //     // Show loading dialog
//   //     showDialog(
//   //       context: context,
//   //       barrierDismissible: false,
//   //       builder: (context) => const AlertDialog(
//   //         content: Row(
//   //           children: [
//   //             CircularProgressIndicator(),
//   //             SizedBox(width: 20),
//   //             Text('Loading available models...'),
//   //           ],
//   //         ),
//   //       ),
//   //     );

//   //     // final modelNames = await ChatRepository.getWorkingModels(apiKey);

//   //     // Close loading dialog
//   //     if (mounted) Navigator.of(context).pop();

//   //     // Show models dialog
//   //     if (mounted) {
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => AlertDialog(
//   //           title: const Text('Working Gemini Models'),
//   //           content: SizedBox(
//   //             width: double.maxFinite,
//   //             height: 400,
//   //             child: ListView.builder(
//   //               itemCount: modelNames.length,
//   //               itemBuilder: (context, index) {
//   //                 final modelName = modelNames[index];
//   //                 final isCurrentModel = modelName == 'gemini-2.0-flash';

//   //                 return Card(
//   //                   color: isCurrentModel
//   //                       ? Theme.of(context)
//   //                           .colorScheme
//   //                           .primaryContainer
//   //                           .withOpacity(0.3)
//   //                       : null,
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.all(12.0),
//   //                     child: Row(
//   //                       children: [
//   //                         Icon(
//   //                           isCurrentModel
//   //                               ? Icons.check_circle
//   //                               : Icons.circle_outlined,
//   //                           color: isCurrentModel
//   //                               ? Theme.of(context).colorScheme.primary
//   //                               : Theme.of(context)
//   //                                   .colorScheme
//   //                                   .onSurfaceVariant,
//   //                           size: 20,
//   //                         ),
//   //                         const SizedBox(width: 12),
//   //                         Expanded(
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text(
//   //                                 modelName,
//   //                                 style: TextStyle(
//   //                                   fontWeight: isCurrentModel
//   //                                       ? FontWeight.bold
//   //                                       : FontWeight.normal,
//   //                                   fontSize: 16,
//   //                                 ),
//   //                               ),
//   //                               if (isCurrentModel) ...[
//   //                                 const SizedBox(height: 4),
//   //                                 Text(
//   //                                   'Currently in use',
//   //                                   style: TextStyle(
//   //                                     fontSize: 12,
//   //                                     color:
//   //                                         Theme.of(context).colorScheme.primary,
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ],
//   //                           ),
//   //                         ),
//   //                         Chip(
//   //                           label: const Text('✅ Working'),
//   //                           backgroundColor: Colors.green.withOpacity(0.1),
//   //                           labelStyle: const TextStyle(fontSize: 12),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //           ),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () => Navigator.of(context).pop(),
//   //               child: const Text('Close'),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     // Close loading dialog if still open
//   //     if (mounted) Navigator.of(context).pop();

//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error loading models: $e')),
//   //       );
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textColor = theme.colorScheme.onSurface;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Update API Key',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//             color: textColor,
//           ),
//         ),
//         centerTitle: true,
//         actions: _isEditing
//             ? [
//                 _isSubmitting
//                     ? const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           width: 23,
//                           height: 23,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                           ),
//                         ))
//                     : IconButton(
//                         icon: const Icon(Icons.done_outlined),
//                         onPressed: _saveApiKey,
//                       ),
//               ]
//             : [],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: ProfileField(
//                     controller: _apiKeyController,
//                     label: 'Gemini API Key',
//                     validator: (value) {
//                       return null;
//                     },
//                     icon: Icons.vpn_key,
//                     enabled: _isEditing,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 icon: Icons.edit_rounded,
//                 label: _isEditing ? 'Save API key' : 'Edit API key',
//                 onPressed: _toggleEditing,
//                 backgroundColor:
//                     theme.colorScheme.secondaryContainer.withOpacity(0.5),
//                 foregroundColor: theme.colorScheme.onSurface,
//               ),
//               const SizedBox(height: 10),
//               CustomButton(
//                 icon: Icons.list_alt_rounded,
//                 label: 'View Available Models',
//                 onPressed: _viewAvailableModels,
//                 backgroundColor:
//                     theme.colorScheme.primaryContainer.withOpacity(0.5),
//                 foregroundColor: theme.colorScheme.onSurface,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// }
