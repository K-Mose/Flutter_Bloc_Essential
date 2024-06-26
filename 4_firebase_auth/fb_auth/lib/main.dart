import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth/blocs/auth/auth_bloc.dart';
import 'package:fb_auth/blocs/profile/profile_cubit.dart';
import 'package:fb_auth/blocs/signin/signin_cubit.dart';
import 'package:fb_auth/blocs/signup/signup_cubit.dart';
import 'package:fb_auth/pages/home_page.dart';
import 'package:fb_auth/pages/profile_page.dart';
import 'package:fb_auth/pages/signin_page.dart';
import 'package:fb_auth/pages/signup_page.dart';
import 'package:fb_auth/pages/splash_page.dart';
import 'package:fb_auth/repositories/auth_repository.dart';
import 'package:fb_auth/repositories/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance
          ),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>()
            ),
          ),
          BlocProvider<SignInCubit>(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>()
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>()
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>()
            ),
          ),
        ],
        child: MaterialApp(
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
            ProfilePage.routeName : (context) => const ProfilePage(),
          },
        ),
      ),
    );
  }
}