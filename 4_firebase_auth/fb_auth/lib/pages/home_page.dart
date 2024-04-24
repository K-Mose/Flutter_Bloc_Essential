import 'package:fb_auth/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fb_auth/blocs/auth/auth_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                backgroundColor: Colors.lightBlue,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthEventSignoutRequest());
                    },
                    icon: const Icon(Icons.exit_to_app)
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfilePage.routeName);
                    },
                    icon: const Icon(Icons.account_circle)
                  ),
                ],
              ),
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/bloc_logo_full.png'),
                    const SizedBox(height: 20.0,),
                    const Text(
                      'Bloc is an awesome\nstate management library\nfor flutter!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
