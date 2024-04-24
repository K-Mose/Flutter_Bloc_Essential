import 'package:fb_auth/blocs/signin/signin_cubit.dart';
import 'package:fb_auth/blocs/signup/signup_cubit.dart';
import 'package:fb_auth/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();
  String? _name, _email, _password;

  void signup() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form  = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();
    print('name: $_name // email: $_email // password: $_password');

    context.read<SignUpCubit>().signup(name: _name!, email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.signupStatus == SignUpStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (BuildContext context, SignUpState state) {
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
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.email)
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name required';
                            }
                            if (value.trim().length < 2) {
                              return 'name must be at least 2 characters long';
                            }
                            return null;
                          },
                          // formkey에서 save 호출 시 실행되는 callback
                          onSaved: (String? value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(height: 10.0),
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
                          controller: _passwordController,
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
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock)
                          ),
                          validator: (String? value) {
                            if (_passwordController.text != value) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(height: 20.0,),
                        ElevatedButton(
                          onPressed: state.signupStatus == SignUpStatus.submitting
                              ? null : signup,
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          child: Text(
                              state.signupStatus == SignUpStatus.submitting
                                  ? 'Loading...' : 'Sign Up'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: state.signupStatus == SignUpStatus.submitting
                              ? null
                              : () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text('Already a member? Sign in'),
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
