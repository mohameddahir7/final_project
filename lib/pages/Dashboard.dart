// import 'package:flutter/material.dart';
// import '../Utils/app_colors.dart';
// import '../Utils/app_utils.dart';

// ///new code for my widget

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({Key? key}) : super(key: key);

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   TextEditingController search = TextEditingController();
//   int? isCheckTile;
//   int? checkFor;

//   // bool isTap=false;

//   // List<bool>? ispressed;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppUtils.sizedBox(80.0, 0.0),
//             AppUtils.searchTextField(
//               textInputAction: TextInputAction.done,
//               controller: search,
//               widget: Image.asset('assets/IconButton.png'),
//             ),
//             AppUtils.sizedBox(20.0, 0.0),
//             AppUtils.simpleText(
//               text: "All Documents",
//               style: const TextStyle(
//                   fontSize: 28,
//                   color: AppColors.blackColor,
//                   fontWeight: FontWeight.bold),
//             ),
//             AppUtils.sizedBox(20.0, 0.0),
//             Flexible(
//               child: ListView.separated(
//                 itemCount: 12,
//                 // shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     onTap: () {
//                       setState(() {
//                         isCheckTile = null;
//                       });
//                     },
//                     // contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
//                     visualDensity:
//                         const VisualDensity(horizontal: 0, vertical: -2),
//                     tileColor: isCheckTile == index
//                         ? Colors.black.withOpacity(0.4)
//                         : AppColors.greyWhiteColor,
//                     minVerticalPadding: 0.0,
//                     contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 0.0, vertical: 0.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     leading: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Image.asset('assets/Microsoft Word.png'),
//                         ),
//                       ],
//                     ),
//                     title: AppUtils.simpleText(
//                       text: "Math Formula",
//                       style: const TextStyle(),
//                     ),
//                     subtitle: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         isCheckTile == index
//                             ? AppUtils.sizedBox(0.0, 0.0)
//                             : AppUtils.simpleText(
//                                 text: "2.3 mb, .Xixs",
//                                 style: const TextStyle(),
//                               ),
//                         AppUtils.sizedBox(0.0, 4.0),
//                         AppUtils.simpleText(
//                           text: "/download/documents",
//                           style: const TextStyle(color: AppColors.blueColor),
//                         ),
//                       ],
//                     ),
//                     trailing: InkWell(
//                       onTap: () {
//                         setState(() {
//                           isCheckTile = index;
//                         });
//                       },
//                       child: isCheckTile == index
//                           ? Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.delete,
//                                   color: AppColors.blueColor,
//                                 ),
//                                 AppUtils.sizedBox(0.0, 6.0),
//                                 const Icon(
//                                   Icons.download,
//                                   color: AppColors.blueColor,
//                                 ),
//                                 AppUtils.sizedBox(0.0, 6.0),
//                                 const Icon(
//                                   Icons.share,
//                                   color: AppColors.blueColor,
//                                 ),
//                                 AppUtils.sizedBox(0.0, 6.0),
//                                 const Icon(
//                                   Icons.star_border,
//                                   color: AppColors.blueColor,
//                                 ),
//                                 AppUtils.sizedBox(0.0, 8.0),
//                               ],
//                             )
//                           : Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Image.asset('assets/three_dot.png'),
//                             ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return AppUtils.sizedBox(12.0, 0.0);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Fisrt
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import 'package:share/share.dart';

class Document {
  final String name;
  final String type;
  final String url;
  bool isFavorite;

  Document({
    required this.name,
    required this.type,
    required this.url,
    this.isFavorite = false,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController search = TextEditingController();
  int? isCheckTile;
  List<Document> documents = [];
  List<Document> filteredDocuments = [];

  @override
  void initState() {
    super.initState();
    // Load documents from Firestore
    loadDocuments();
  }

  void favoriteDocument(Document document) {
    setState(() {
      document.isFavorite = !document.isFavorite;
      updateFavoriteStatus(document);
    });
  }

  void updateFavoriteStatus(Document document) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    FirebaseFirestore.instance
        .collection('documents')
        .doc(user.uid)
        .collection('files')
        .doc(document.name)
        .update({'isFavorite': document.isFavorite}).then((value) {
      print('Favorite status updated successfully.');
    }).catchError((error) {
      print('Failed to update favorite status: $error');
    });
  }

  void loadDocuments() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('documents')
        .doc(user.uid)
        .collection('files')
        .get();

    List<Document> loadedDocuments = querySnapshot.docs.map((doc) {
      String name = doc.get('name');
      String type = doc.get('type');
      String url = doc.get('url');
      return Document(name: name, type: type, url: url);
    }).toList();

    setState(() {
      documents = loadedDocuments;
      filteredDocuments = List.from(documents);
    });
  }

  Future<void> shareDocument(Document document) async {
    if (document.url.isNotEmpty) {
      try {
        // Get the file path of the document
        String filePath = await _getFilePath(document.url);

        // Share the file
        List<String> filePaths = [filePath];
        await Share.shareFiles(filePaths);
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to share the document.'),
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
        print('Failed to share document: $error');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Cannot share a document that is not uploaded to the cloud.',
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

  Future<String> _getFilePath(String url) async {
    final storageReference = FirebaseStorage.instance.ref().child(url);

    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}');

    try {
      await storageReference.writeToFile(tempFile);
      return tempFile.path;
    } catch (error) {
      throw Exception('Failed to download document: $error');
    }
  }

  void downloadDocument(Document document) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    try {
      var dir = (await DownloadsPath.downloadsDirectory())?.path ??
          "Downloads path doesn't exist";
      if (dir != null) {
        String savename = document.name + "." + document.type;
        String savePath = dir + "/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(document.url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
            }
          });
          print("File is saved to download folder.");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('File Download'),
                content: const Text('File downloaded successfully.'),
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
          // showAlertDialog(BuildContext context) {
          //   // set up the button
          //   Widget okButton = ElevatedButton(
          //     child: Text("OK"),
          //     onPressed: () {},
          //   );
          //   // set up the AlertDialog
          //   AlertDialog alert = AlertDialog(
          //     title: Text("File Download"),
          //     content: Text("Your file has been downloaded on downloads directory."),
          //     actions: [
          //       okButton,
          //     ],
          //   );
          //   // show the dialog
          //   showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return alert;
          //     },
          //   );
          // }
        } on DioError catch (e) {
          print(e.message);
          print('download error');
        }
      }
    } catch (e) {
      print("No permission to read and write.");
    }
  }

  void deleteDocument(Document document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Are you sure you want to delete ${document.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                if (user == null) {
                  print('User is not logged in.');
                  return;
                }

                FirebaseFirestore.instance
                    .collection('documents')
                    .doc(user.uid)
                    .collection('files')
                    .doc(document.name)
                    .delete()
                    .then((value) {
                  setState(() {
                    documents.remove(document);
                    filteredDocuments.remove(document);
                  });
                }).catchError((error) {
                  print('Failed to delete document: $error');
                });

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void filterDocuments(String query) {
    setState(() {
      filteredDocuments = documents
          .where((document) =>
              document.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> refreshDocuments() async {
    setState(() {
      documents = [];
      filteredDocuments = [];
    });

    // Reload documents from Firestore
    loadDocuments();
  }

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

  Image getDocumentImage(String type) {
    switch (type) {
      case 'doc':
      case 'docx':
        return Image.asset('assets/Microsoft Word.png');
      case 'xls':
      case 'xlsx':
        return Image.asset('assets/Excel.jpeg');
      case 'ppt':
      case 'pptx':
        return Image.asset('assets/PowerPiont.jpeg');
      case 'pdf':
        return Image.asset('assets/Pdf.jpeg');
      default:
        return Image.asset('assets/Pdf.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppUtils.sizedBox(80.0, 0.0),
            AppUtils.searchTextField(
              textInputAction: TextInputAction.done,
              controller: search,
              widget: Image.asset('assets/IconButton.png'),
              onChanged: (query) {},
            ),
            AppUtils.sizedBox(20.0, 0.0),
            AppUtils.simpleText(
              text: "All Documents",
              style: const TextStyle(
                  fontSize: 28,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold),
            ),
            AppUtils.sizedBox(20.0, 0.0),
            Flexible(
              child: ListView.separated(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  Document document = filteredDocuments[index];
                  return ListTile(
                    onTap: () {
                      setState(() {
                        isCheckTile = null;
                      });
                    },
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -2),
                    tileColor: isCheckTile == index
                        ? Colors.black.withOpacity(0.4)
                        : Colors.grey[300],
                    minVerticalPadding: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: getDocumentImage(document.type),
                        ),
                      ],
                    ),
                    title: Text(
                      document.name,
                      style: const TextStyle(),
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isCheckTile == index
                            ? const SizedBox(width: 0.0, height: 0.0)
                            : Text(
                                document.type,
                                style: const TextStyle(),
                              ),
                        const SizedBox(width: 0.0, height: 4.0),
                        Text(
                          document.url,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () {
                        setState(() {
                          isCheckTile = index;
                        });
                      },
                      child: isCheckTile == index
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Call the deleteDocument function here
                                    deleteDocument(document);
                                  },
                                ),
                                const SizedBox(width: 0.0, height: 6.0),
                                IconButton(
                                  icon: const Icon(Icons.download,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Call the downloadDocument function here
                                    downloadDocument(document);
                                  },
                                ),
                                const SizedBox(width: 0.0, height: 6.0),
                                IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Call the shareDocument function here
                                    shareDocument(document);
                                  },
                                ),
                                const SizedBox(width: 0.0, height: 8.0),
                                IconButton(
                                  icon: const Icon(Icons.star_border,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Call the favoriteDocument function here
                                    favoriteDocument(document);
                                  },
                                ),
                                const SizedBox(width: 0.0, height: 8.0),
                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset('assets/three_dot.png'),
                            ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// // End

