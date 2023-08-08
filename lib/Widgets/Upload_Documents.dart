// PLease resolve  this code because when it completed file don't print Succesfull in showdialogy? then rewrite the correct complete?


// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// // Upload documents to Firebase Storage and Firestore

// Future<void> uploadDocument(BuildContext context) async {
//   List<String> allowedExtensions = [
//     'doc',
//     'docx',
//     'xls',
//     'xlsx',
//     'ppt',
//     'pptx',
//     'pdf'
//   ];

//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user = auth.currentUser;
//   if (user == null) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Login In'),
//           content: const Text('User is not logged in.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//     print('User is not logged in.');
//     return;
//   }

//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: allowedExtensions,
//   );

//   if (result != null) {
//     PlatformFile file = result.files.first;
//     String? extension = file.extension;

//     if (extension != null && allowedExtensions.contains(extension)) {
//       try {
//         Reference storageReference = FirebaseStorage.instance
//             .ref()
//             .child('documents/${user.uid}/${file.name}');
//         UploadTask uploadTask = storageReference.putFile(File(file.path!));

//         TaskSnapshot taskSnapshot = await uploadTask;
//         String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//         // Store document info in Firestore
//         await FirebaseFirestore.instance
//             .collection('documents')
//             .doc(user.uid)
//             .collection('files')
//             .doc(file.name)
//             .set({
//           'name': file.name,
//           'type': extension,
//           'url': downloadUrl,
//         });

//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Success'),
//               content: const Text('File uploaded successfully.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//         print('File uploaded successfully');
//       } catch (error) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Error'),
//               content: const Text('Failed to upload the document.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//         print('Failed to upload document: $error');
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Invalid File Type'),
//             content: const Text(
//               'Only doc, docx, xls, xlsx, ppt, pptx, and pdf files are allowed.',
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       print(
//           'Invalid file type. Only doc, docx, xls, xlsx, ppt, pptx, and pdf files are allowed.');
//     }
//   } else {
//     // User canceled the picker
//     print('User canceled document selection');
//   }
// }


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// Upload documents to Firebase Storage and Firestore

Future<void> uploadDocument(BuildContext context) async {
  List<String> allowedExtensions = [
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'pdf'
  ];

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  if (user == null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login In'),
          content: const Text('User is not logged in.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    print('User is not logged in.');
    return;
  }

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    String? extension = file.extension;

    if (extension != null && allowedExtensions.contains(extension)) {
      try {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('documents/${user.uid}/${file.name}');
            //.child('documents/<span class="math-inline">\{user\.uid\}/</span>{file.name}');
        UploadTask uploadTask = storageReference.putFile(File(file.path!));

        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Store document info in Firestore
        await FirebaseFirestore.instance
            .collection('documents')
            .doc(user.uid)
            .collection('files')
            .doc(file.name)
            .set({
          'name': file.name,
          'type': extension,
          'url': downloadUrl,
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('File uploaded successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        print('File uploaded successfully');
      } catch (error) {
        print('Failed to upload document: $error');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to upload the document.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid File Type'),
            content: const Text(
              'Only doc, docx, xls, xlsx, ppt, pptx, and pdf files are allowed.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(
          'Invalid file type. Only doc, docx, xls, xlsx, ppt, pptx, and pdf files are allowed.');
    }
  } else {
    // User canceled the picker
    print('User canceled document selection');
  }
}