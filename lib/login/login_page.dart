import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:vildi1/cubit/auth_cubit.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  // final VoidCallback showRegisterPage;
  const LoginPage({
    super.key,

    // required this.showRegisterPage
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      // Handle errors.
      // So if an error happens, tell the user what went wrong.
      if (state.status == AuthStatus.error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor:
                  Colors.black, // Set the background color to black
              title: const Text(
                "username or password is not in the system ... try again or create an account.",
                style: TextStyle(
                    color: Colors.white), // Set the text color to white
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color:
                            Colors.red), // Set the button text color to white
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }, builder: (context, state) {
      switch (state.status) {
        case AuthStatus.loading:
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        case AuthStatus.unknown:
          return _buildLoginPage();
        case AuthStatus.authenticated:
          return const MyHomePage(
            title: '',
          );
        default:
      }
      return _buildLoginPage();
    });
  }

  Widget _buildLoginPage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: [Colors.green, Colors.black],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // backgroundColor: Color.fromARGB(255, 23, 6, 41),
        // ignore: prefer_const_literals_to_create_immutables
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                    '/Users/nickcamson/vildi1/lib/assets/vildi_white_see_thru.png'),
              ),
              Opacity(
                opacity: .9,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: const [
                      Divider(
                        color: Colors.white,
                        endIndent: 130,
                        indent: 130,
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Connecting your items to the people who value them",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(.5),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  // user name
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 166, 162, 162)),
                      ),
                      cursorColor: Colors.blue,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //pass text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(.5),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  // user name
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 166, 162, 162)),
                      ),
                      cursorColor: Colors.blue,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Forgot Password?'),
                        content: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final FirebaseAuth _auth =
                                    FirebaseAuth.instance;
                                await _auth.sendPasswordResetEmail(
                                    email: _emailController.text.trim());
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password reset email sent'),
                                  ),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Send Email'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      )
                    ],
                  ),
                ),
              ),

              //signin button

              GestureDetector(
                onTap: () {
                  final email = _emailController.text.trim();
                  final pass = _passwordController.text;
                  context
                      .read<AuthCubit>()
                      .signIn(email: email, password: pass);
                },
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.transparent
                        .withOpacity(.5), // Set the color to transparent
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.white), // Add a white border
                  ),
                  child: const Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white, // Set the text color to white
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // This needs to incorporate your signIn method
              Padding(
                padding: const EdgeInsets.all(25),
                child: GestureDetector(
                  onTap: () {
                    final email = _emailController.text.trim();
                    final pass = _passwordController.text;
                    context
                        .read<AuthCubit>()
                        .signIn(email: 'justin@vildi.com', password: '123456');
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.transparent
                          .withOpacity(.5), // Set the color to transparent
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.white), // Add a white border
                    ),
                    child: const Center(
                      child: Text(
                        'Create An Account',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
