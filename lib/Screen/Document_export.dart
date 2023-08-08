import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'package:python_ffi/python_ffi.dart';
import 'package:http/http.dart' as http;

class RecognizePage extends StatefulWidget {
  final String? path;

  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  TextEditingController controller = TextEditingController();
  String _selectedFormat = '.docx';

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recognized Page"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.cloud),
                    title: const Text('Upload to Firestore'),
                    onTap: () {
                      _showUploadDialog();
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.save),
                    title: const Text('Save to Local Storage'),
                    onTap: () {
                      _showSaveDialog();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: _isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: TextField(
                maxLines: MediaQuery.of(context).size.height.toInt(),
                controller: controller,
                decoration: const InputDecoration(hintText: "Text goes here..."),
              ),
            ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    setState(() {
      _isBusy = true;
    });

    final RecognizedText recognisedText = await textRecognizer.processImage(image);
    controller.text = recognisedText.text;

    setState(() {
      _isBusy = false;
    });

    await textRecognizer.close();
  }

  Future<void> exportDocumentToFirestore(String documentName, Uint8List fileData, String userId) async {
    final storageReference = FirebaseStorage.instance.ref().child('documents/$userId/${documentName}$_selectedFormat');
    final uploadTask = storageReference.putData(fileData);

    final TaskSnapshot taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Store document info in Firestore
    await FirebaseFirestore.instance.collection('documents').doc(userId).collection('files').doc('$documentName$_selectedFormat').set({
      'name': documentName,
      'type': _selectedFormat,
      'url': downloadUrl,
    });
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String documentName = '';

        return AlertDialog(
          title: const Text('Upload to Firestore'),
          content: Wrap(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  labelText: 'Document Name',
                ),
                onChanged: (value) {
                  documentName = value;
                },
              ),
              DropdownButton<String>(
                value: _selectedFormat,
                items: const <String>['.docx', '.pptx', '.pdf', '.xlsx']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFormat = newValue!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final pdfData = await generatePdfDocument(controller.text);
                final excelData = await generateExcelDocument(controller.text);
                // final pptxData = await generatePptxDocument(controller.text);

                // Generate file data based on selected format
                Uint8List? fileData;
                switch (_selectedFormat) {
                  case '.pdf':
                    fileData = pdfData;
                    break;
                  case '.xlsx':
                    fileData = excelData;
                  //   break;
                  // case '.pptx':
                  //   fileData = pptxData;
                    break;
                  case '.docx':
                    fileData = await generateDocxDocument(controller.text);
                    break;
                  default:
                    fileData = await generatePdfDocument(controller.text);
                }

                // Upload file to Firestore
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await exportDocumentToFirestore(documentName, fileData!, user.uid);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File uploaded to Firestore')),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You are not signed in')),
                  );
                }
              },
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String documentName = '';

        return AlertDialog(
          title: const Text('Save to Local Storage'),
          content: Wrap(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  labelText: 'Document Name',
                ),
                onChanged: (value) {
                  documentName = value;
                },
              ),
              DropdownButton<String>(
                value: _selectedFormat,
                items: const <String>['.docx', '.pdf', '.pptx', '.xlsx']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFormat = newValue!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Generate file data based on selected format
                Uint8List? fileData;
                switch (_selectedFormat) {
                  case '.pdf':
                    fileData = await generatePdfDocument(controller.text);
                    break;
                  case '.xlsx':
                    fileData = await generateExcelDocument(controller.text);
                    break;
                  // case '.pptx':
                  //   fileData = await generatePptxDocument(controller.text);
                  //   break;
                  case '.docx':
                    fileData = await generateDocxDocument(controller.text);
                    break;
                  default:
                    fileData = await generatePdfDocument(controller.text);
                }

                // Save file to local storage
                final directory = await getTemporaryDirectory();
                final file = File('${directory.path}/$documentName$_selectedFormat');
                await file.writeAsBytes(fileData!);

                // Open file
                await OpenFile.open('${file.path}');

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Pdf
  Future<Uint8List> generatePdfDocument(String text) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Center(child: pw.Text(text))));

    final bytes = await pdf.save();
    return bytes;
  }

  // Excel
  Future<Uint8List> generateExcelDocument(String text) async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText(text);

    final bytes = workbook.saveAsStream();
    workbook.dispose();

    return bytes as Uint8List;
  }

  // // Ppt
  // static Future<Uint8List?> generatePptxDocument(String text) async {
  //   final python = Python.instance;
  //   //final python = await PythonFfi.instance.initialize();
  //   final documentGenerator = await python.importModule('document_generator');
  //   final result = await documentGenerator.callMethod('generate_pptx', [text]);

  //   if (result != null) {
  //     return result as Uint8List?;
  //   } else {
  //     debugPrint("Failed to generate PPTX document");
  //     return null;
  //   }
  // }

  // Docx
  // static Future<Uint8List?> generateDocxDocument(String text) async {
  //   final python = Python.instance;
  //   //final python = await PythonFfi.instance.initialize();
  //   final documentGenerator = await python.importModule('document_generator');
  //   final result = await documentGenerator.callMethod('generate_docx', [text]);

  //   if (result != null) {
  //     return result as Uint8List?;
  //   } else {
  //     debugPrint("Failed to generate DOCX document");
  //     return null;
  //   }
  // }




Future<Uint8List?> generateDocxDocument(String text) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/generate_docx'), // Replace with your actual server address
    body: {'text': text},
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body)['result'];
    return base64Decode(result);
  } else {
    debugPrint("Failed to generate DOCX document");
    return null;
  }
 }
 
}
