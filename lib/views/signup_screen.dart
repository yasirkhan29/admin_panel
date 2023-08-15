import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uzir/colors/color.dart';
import 'package:uzir/components/buttons.dart';
import 'package:uzir/components/textbuttons.dart';
import 'package:uzir/components/textform.dart';
import 'package:uzir/services/utis.dart';
import 'package:uzir/views/login_screen.dart';

class SignUPScreen extends StatefulWidget {
  static String id = 'SignUP';
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('Register',
                        style: TextStyle(
                            color: MyColors.Color_Orange,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: size.height * .17),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        MyTextFormFields(
                            FormController: emailcontroller,
                            hint_text: 'email',
                            Prefix_Icon: Icon(Icons.email_outlined),
                            condation: '@gmail.com',
                            retunt_text: 'Enter a valid Email'),
                        SizedBox(height: size.height * .05),
                        MyTextFormFields(
                            hide_text: true,
                            FormController: passwordcontroller,
                            hint_text: 'Password',
                            Prefix_Icon: Icon(Icons.lock_clock_outlined),
                            condation: '',
                            retunt_text:
                                'Password Should be atleat 6 character'),
                        SizedBox(height: size.height * .1),
                      ],
                    )),
                MyButtons(
                    loading: loading,
                    title: 'SignUp',
                    VoidCallback: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text.toString(),
                                password: passwordcontroller.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().Toast_message(
                              'Account created Successfully', Colors.green);
                          Timer(Duration(seconds: 1), () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().Toast_message(error.toString(), Colors.red);
                        });
                      }
                    }),
                MyTextButton(
                    title: 'Alrrady have an account?',
                    clickabletext: 'Login',
                    page: LoginScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
