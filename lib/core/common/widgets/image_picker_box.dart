// import 'dart:io';

// import 'package:chat_app/core/constants/colors.dart';
// import 'package:chat_app/core/constants/constants.dart';
// import 'package:chat_app/core/extensions/context_extension.dart';
// import 'package:chat_app/core/utils/utils.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class ImagePickerBox extends StatelessWidget {
//   const ImagePickerBox({
//     required this.image,
//     required this.setSelectedImage,
//     this.imageUrl,
//     this.height = kBannerHt,
//     super.key,
//   });

//   final File? image;
//   final String? imageUrl;
//   final void Function(File file) setSelectedImage;
//   final double height;

//   static Future<FilePickerResult?> pickImage() async {
//     final image = await FilePicker.platform.pickFiles(type: FileType.image);
//     return image;
//   }

//   Future<void> selectImage(BuildContext context) async {
//     final pickedImage = await pickImage();
//     if (pickedImage == null || pickedImage.count == 0) {
//       if (!context.mounted) return;
//       AppSnackbar.message(context, 'Please pick an image!');
//       return;
//     }

//     setSelectedImage(File(pickedImage.files[0].path!));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: kBR),
//       child: InkWell(
//         onTap: () => selectImage(context),
//         borderRadius: BorderRadius.circular(kBR),
//         child: Ink(
//           height: height,
//           width: context.w,
//           decoration: BoxDecoration(
//             color: AppColors.listTile,
//             borderRadius: BorderRadius.circular(kBR),
//             image: imageUrl != null
//                 ? DecorationImage(
//                     image: NetworkImage(imageUrl!),
//                     fit: BoxFit.cover,
//                   )
//                 : null,
//           ),
//           child: image == null
//               ? const Center(
//                   child: Icon(
//                     Icons.add_photo_alternate_outlined,
//                     size: 40,
//                   ),
//                 )
//               : ClipRRect(
//                   borderRadius: BorderRadius.circular(kBR),
//                   child: Image.file(image!, fit: BoxFit.cover),
//                 ),
//         ),
//       ),
//     );
//   }
// }
