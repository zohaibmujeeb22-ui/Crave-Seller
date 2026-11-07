import 'package:crave_seller/core/auth_service.dart/auth_service.dart';
import 'package:crave_seller/core/auth_service.dart/database_service.dart';
import 'package:crave_seller/core/constants/app_constants.dart';
import 'package:crave_seller/features/auth/screens/login_screen.dart';
import 'package:crave_seller/providers/auth_provider.dart';
import 'package:crave_seller/providers/onboarding_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.supabaseAnonKey,
  );

  runApp(const CraveSellerApp());
}

class CraveSellerApp extends StatelessWidget {
  const CraveSellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final databaseService = DatabaseService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CraveAuthProvider(
            authService: authService,
            dbService: databaseService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(dbService: databaseService),
        ),
      ],
      child: MaterialApp(
        title: 'Crave Seller',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
