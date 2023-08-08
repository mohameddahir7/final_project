import 'package:flutter/material.dart';

class Slide {
  String text;

  Slide({this.text = ''});
}

class PowerPointPackage {
  List<Slide> slides = [];

  void addSlide(Slide slide) {
    slides.add(slide);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PresentationScreen(),
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  _PresentationScreenState createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  PowerPointPackage powerPointPackage = PowerPointPackage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PowerPoint Package Example'),
      ),
      body: ListView.builder(
        itemCount: powerPointPackage.slides.length,
        itemBuilder: (context, index) {
          return SlideWidget(slide: powerPointPackage.slides[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            powerPointPackage.addSlide(Slide(text: 'New Slide'));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final Slide slide;

  SlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Text(
        slide.text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
