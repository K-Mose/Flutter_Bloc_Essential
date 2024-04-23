import 'package:fb_auth/pages/home_page.dart';
import 'package:fb_auth/pages/signin_page.dart';
import 'package:fb_auth/pages/signup_page.dart';
import 'package:fb_auth/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebas Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        SignUpPage.routeName : (context) => const SignUpPage(),
        SignInPage.routeName : (context) => const SignInPage(),
        HomePage.routeName : (context) => const HomePage(),
      },
    );
  }
}