import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyATKcRlqSwMlfwawF7ZdiJTVZP_5aSUB9U',
      appId: '1:387467499478:web:5ac653ccf801a54122b677',
      messagingSenderId: '387467499478',
      projectId: 'crave-seller',
      authDomain: 'crave-seller.firebaseapp.com',
      storageBucket: 'crave-seller.firebasestorage.app',
      measurementId: 'G-BCRDVB29TY',
    ),
  );

  runApp(const CraveSellerApp());
}

class CraveSellerApp extends StatelessWidget {
  const CraveSellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crave Seller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const Scaffold(body: Center(child: Text('Crave Seller'))),
    );
  }
}
