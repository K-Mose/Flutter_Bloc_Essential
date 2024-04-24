import 'package:fb_auth/blocs/signin/signin_cubit.dart';
import 'package:fb_auth/pages/signup_page.dart';
import 'package:fb_auth/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void submit() {
     setState(() {
       _autovalidateMode = AutovalidateMode.always;
     });

     final form  = _formKey.currentState;
     if (form == null || !form.validate()) return;

     form.save();
     print('email: $_email // password: $_password');

     context.read<SignInCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (BuildContext context, SignInState state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/flutter_logo.png',
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          // formkey에서 save 호출 시 실행되는 callback
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock)
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(height: 20.0,),
                        ElevatedButton(
                          onPressed: state.signInStatus == SignInStatus.submitting
                              ? null : submit,
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: Text(
                              state.signInStatus == SignInStatus.submitting
                              ? 'Loading...' : 'Sign In'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: state.signInStatus == SignInStatus.submitting
                              ? null
                              : () {
                                Navigator.of(context).pushNamed(SignUpPage.routeName);
                              },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text('Not a member? Sign Up!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
