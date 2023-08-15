import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uzir/colors/color.dart';
import 'package:uzir/components/buttons.dart';
import 'package:uzir/components/gestuerdetactor.dart';
import 'package:uzir/components/textform.dart';
import 'package:uzir/services/upload_to_firebase.dart';
import 'package:uzir/services/utis.dart';

class PostDetails extends StatefulWidget {
  static String id = 'PostDetails';
  PostDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Future getimagegallery() async {
    final pickedfile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        print('pick image');
      }
    });
  }

  Future getimagegcamera() async {
    final pickedfile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        print('pick image');
      }
    });
  }

  File? _image;
  final picker = ImagePicker();
  bool loading = false;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final databaseref = FirebaseDatabase.instance.ref('post data');
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('post'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: size.height * .25,
                              width: size.width * .2,
                              child: Column(
                                children: [
                                  MyGesterDector(
                                      title: 'Gallery',
                                      icone: Icon(Icons.browse_gallery),
                                      VoidCallback: () {
                                        getimagegallery();
                                      }),
                                  MyGesterDector(
                                      title: 'Camera',
                                      icone: Icon(Icons.camera),
                                      VoidCallback: () {
                                        getimagegcamera();
                                      }),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: size.height * .25,
                    decoration: BoxDecoration(
                      color: MyColors.Color_grey,
                    ),
                    child: Center(
                        child: _image != null
                            ? ClipRect(
                                child: Image.file(
                                  _image!.absolute,
                                  height: size.height * .25,
                                  width: size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : Icon(
                                Icons.image_outlined,
                                size: 60,
                              )),
                  ),
                ),
                SizedBox(height: size.height * .1),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        MyTextFormFields(
                            FormController: titlecontroller,
                            hint_text: 'Title of post',
                            Prefix_Icon: Icon(Icons.title_outlined),
                            condation: '',
                            retunt_text: 'enter atleat 6 digits'),
                        SizedBox(height: size.height * .03),
                        MyTextFormFields(
                            MaxLines: 4,
                            FormController: descriptioncontroller,
                            hint_text: '\nDescription',
                            Prefix_Icon: Icon(
                              Icons.description_outlined,
                              size: 30,
                            ),
                            condation: '',
                            retunt_text: 'enter atleat 6 digits'),
                        SizedBox(height: size.height * .1),
                      ],
                    )),
                MyButtons(
                    loading: loading,
                    title: 'Post',
                    VoidCallback: () async {
                      setState(() {
                        loading = true;
                      });
                      UploadDataFirebase()
                          .UploadDataFireStore(
                              _image!.absolute,
                              titlecontroller.text.toString(),
                              descriptioncontroller.text.toString())
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utils().Toast_message('Uploded', Colors.green);
                        Timer(Duration(milliseconds: 900), () {
                          Navigator.pop(context);
                        });
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        Utils().Toast_message(error.toString(), Colors.red);
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
