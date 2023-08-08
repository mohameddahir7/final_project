
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import 'package:share/share.dart';
import 'package:permission_handler/permission_handler.dart';

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
  const DashboardPage({Key? key}) : super(key: key);

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
    // Load documents from Firestore and Local Storage
    loadDocuments();
    loadLocalDocuments();
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
        .update({'isFavorite': document.isFavorite})
        .then((value) {
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

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
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

  Future<void> loadLocalDocuments() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    for (Document document in documents) {
      try {
        if (document.url.isNotEmpty) {
          firebase_storage.Reference storageReference =
              firebase_storage.FirebaseStorage.instance.ref().child(document.url);
          File file = File('$tempPath/${document.name}');
          await storageReference.writeToFile(file);
        }
      } catch (error) {
        print('Failed to download document: $error');
      }
    }
  }

  Future<void> shareDocument(Document document) async {
    String tempPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempPath/${document.name}';
    // Share the file
    List<String> filePaths = [filePath];
    await Share.shareFiles(filePaths);
  }

  void downloadDocument(Document document) async {
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Document downloaded successfully.'),
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
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to download the document.'),
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
        print('Failed to download document: $error');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Cannot download a document that is not uploaded to the cloud.',
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

    // Reload documents from Firestore and Local Storage
    loadDocuments();
    loadLocalDocuments();
  }

  void openLocalDocument(Document document) async {
    String tempPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempPath/${document.name}';
    // Open the document using a file opener
    OpenFile.open(filePath);
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
              onChanged: (query) => filterDocuments(query),
            ),
            AppUtils.sizedBox(20.0, 0.0),
            AppUtils.simpleText(
              text: "All Documents",
              style: const TextStyle(
                fontSize: 28,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppUtils.sizedBox(20.0, 0.0),
            Flexible(
              child: RefreshIndicator(
                onRefresh: refreshDocuments,
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
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
                      tileColor: isCheckTile == index
                          ? Colors.black.withOpacity(0.4)
                          : Colors.grey[300],
                      minVerticalPadding: 0.0,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
                                    icon: const Icon(Icons.delete, color: Colors.blue),
                                    onPressed: () {
                                      // Call the deleteDocument function here
                                      deleteDocument(document);
                                    },
                                  ),
                                  const SizedBox(width: 0.0, height: 6.0),
                                  IconButton(
                                    icon: const Icon(Icons.download, color: Colors.blue),
                                    onPressed: () {
                                      // Call the downloadDocument function here
                                      downloadDocument(document);
                                    },
                                  ),
                                  const SizedBox(width: 0.0, height: 6.0),
                                  IconButton(
                                    icon: const Icon(Icons.share, color: Colors.blue),
                                    onPressed: () {
                                      // Call the shareDocument function here
                                      shareDocument(document);
                                    },
                                  ),
                                  const SizedBox(width: 0.0, height: 8.0),
                                  IconButton(
                                    icon: const Icon(Icons.star_border, color: Colors.blue),
                                    onPressed: () {
                                      // Call the favoriteDocument function here
                                      favoriteDocument(document);
                                    },
                                  ),
                                  const SizedBox(width: 0.0, height: 8.0),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            ),
          ],
        ),
      ),
    );
  }
}



