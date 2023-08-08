// import docx_template

// def generateWordDocument(text):
//     template = docx_template.DocxTemplate("template.docx")
//     context = {"text": text}
//     template.render(context)
//     template.save("generated_doc.docx")

// if __name__ == "__main__":
//     text = "This is some text that will be exported to a Microsoft Word document."
//     generateWordDocument(text)


// import 'dart:io';

// import 'package:docx_template/docx_template.dart';

// Future<Uint8List> generateWordDocument(String text) async {
//   final template = await DocxTemplate.fromBytes('assets/files/generated.docx');
//   template.setValue('text', text);

//   final bytes = await template.save();

//   return bytes as Uint8List;
// }