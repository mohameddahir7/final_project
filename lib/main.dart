import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vistual_scanning/pages/home.dart';
// import 'pages/Splash.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      home: const Home(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Connection',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyWidget(),
//     );
//   }
// }

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   bool isFirebaseConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     initializeFirebase().then((value) {
//       setState(() {
//         isFirebaseConnected = value;
//       });
//     });
//   }

//   Future<bool> initializeFirebase() async {
//     try {
//       await Firebase.initializeApp();
//       return true;
//     } catch (e) {
//       print('Failed to initialize Firebase: $e');
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Text(
//               isFirebaseConnected
//                   ? 'Firebase is connected'
//                   : 'Firebase is not connected',
//               style: const TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }