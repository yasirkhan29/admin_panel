import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uzir/colors/color.dart';
import 'package:uzir/components/buttons.dart';
import 'package:uzir/components/textform.dart';
import 'package:uzir/services/utis.dart';

class Forgetpassword extends StatefulWidget {
  static String id = 'ForgetPassword';
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
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
                    child: Text('Reset Password',
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
                        SizedBox(height: size.height * .1),
                      ],
                    )),
                MyButtons(
                    loading: loading,
                    title: 'Forget',
                    VoidCallback: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _auth
                            .sendPasswordResetEmail(
                                email: emailcontroller.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils()
                              .Toast_message('Cehck your email', Colors.green);
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().Toast_message(error.toString(), Colors.red);
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
