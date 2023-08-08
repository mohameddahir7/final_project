// import 'package:flutter/material.dart';
// import '../Utils/app_colors.dart';
// import '../Utils/app_utils.dart';

// class Favourite extends StatelessWidget {
//   const Favourite({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(
//           color: Colors.black, //change your color here
//         ),
//         centerTitle: true,
//         title: AppUtils.simpleText(
//           text: "Favourite documents",
//           style: const TextStyle(
//               fontSize: 26,
//               color: AppColors.blueColor,
//               fontWeight: FontWeight.w900),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           children: [
//             AppUtils.sizedBox(20.0, 0.0),
//             Flexible(
//               child: ListView.separated(
//                 // shrinkWrap: true,
//                 itemCount: 6,
//                 itemBuilder: (context, int index) {
//                   return AppUtils.showFavDocuments(onTap: () {});
//                 },
//                 separatorBuilder: (context, int index) {
//                   return AppUtils.sizedBox(8.0, 0.0);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import 'dashboard.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  void openDocument(Document document) async {
    if (document.url.isNotEmpty) {
      try {
        // Get temporary directory path
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        // Set file name and path
        String fileName = document.name;
        String filePath = '$tempPath/$fileName';
        // Download document from Firebase Storage
        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;
        firebase_storage.Reference ref = storage.ref().child(document.url);
        File file = File(filePath);
        await ref.writeToFile(file);
        // Open the document using a file opener
        OpenFile.open(file.path);
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to open the document.'),
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
        print('Failed to open document: $error');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Cannot open a document that is not uploaded to the cloud.',
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: AppUtils.simpleText(
          text: "Favourite documents",
          style: const TextStyle(
              fontSize: 26,
              color: AppColors.blueColor,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            AppUtils.sizedBox(20.0, 0.0),
            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // Add Map<String, dynamic>
                stream: FirebaseFirestore.instance
                    .collection('documents')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('files')
                    .where('isFavorite', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final favoriteDocuments = snapshot.data!.docs;
                    return ListView.separated(
                      itemCount: favoriteDocuments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final docData = favoriteDocuments[index].data();
                        // Handling errors for missing keys
                        String documentName = docData != null && docData.containsKey('name')
                            ? docData['name']
                            : 'Unknown Name';
                        String documentType = docData != null && docData.containsKey('type')
                            ? docData['type']
                            : 'Unknown Type';
                        String documentUrl = docData != null && docData.containsKey('url')
                            ? docData['url']
                            : 'Unknown URL';

                        return AppUtils.showFavDocuments(
                          onTap: () {
                            Document document = Document(
                              name: documentName,
                              type: documentType,
                              url: documentUrl,
                            );
                            openDocument(document);
                          },
                          documentName: documentName,
                          documentType: documentType,
                          documentUrl: documentUrl,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return AppUtils.sizedBox(8.0, 0.0);
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
