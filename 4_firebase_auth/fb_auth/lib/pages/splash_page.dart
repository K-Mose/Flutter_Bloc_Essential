import 'package:fb_auth/blocs/auth/auth_bloc.dart';
import 'package:fb_auth/pages/home_page.dart';
import 'package:fb_auth/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        print('listener:: $state');
        await Future.delayed(const Duration(milliseconds: 1200));
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.pushNamed(context, SignInPage.routeName);
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
