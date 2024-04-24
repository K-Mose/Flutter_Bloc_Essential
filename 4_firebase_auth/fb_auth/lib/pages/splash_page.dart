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
        if (state.authStatus == AuthStatus.unauthenticated) {
          /*
          pushNamedAndRemoveUntil은 false를 반환할 때 까지 라우팅 스택에서 화면 제거
          route.settings.name :
          ModalRoute.of(context)!.settings.name : 현재 화면의 라우팅
           */
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInPage.routeName,
            (route) {
              print('route.settings.name: ${route.settings.name}');
              print('ModalRoute: ${ModalRoute.of(context)!.settings.name}');
              return route.settings.name == ModalRoute.of(context)!.settings.name
                  ? true : false;
            },
          );
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
