import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:uzir/colors/color.dart';
import 'package:uzir/services/utis.dart';
import 'package:uzir/views/login_screen.dart';
import 'package:uzir/views/post_details.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final dataredferance =
      FirebaseDatabase.instance.ref('Blog').child('posts details');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, PostDetails.id);
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Utils().Toast_message("LogOut", Colors.green);
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: size.height * .07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search Title here',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                ),
              ),
              Expanded(
                child: FirebaseAnimatedList(
                    query: dataredferance,
                    itemBuilder: (context, snapshot, animation, index) {
                      String title = snapshot.child('Title').value.toString();
                      String id = snapshot.child('id').value.toString();
                      if (searchController.text.isEmpty) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(
                                                child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: MyColors.Color_Orange),
                                            )),
                                            content:
                                                Text('Are you sure to delete'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cencele')),
                                              TextButton(
                                                  onPressed: () {
                                                    dataredferance
                                                        .child(id)
                                                        .remove();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: size.height * .25,
                                    width: size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'images/images.jpg',
                                        image: snapshot
                                            .child('Image')
                                            .value
                                            .toString(),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snapshot
                                            .child('Title')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot
                                            .child('Description')
                                            .value
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (title.toLowerCase().contains(
                          searchController.text.toLowerCase().toString())) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * .25,
                                  width: size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images.jpg',
                                      image: snapshot
                                          .child('Image')
                                          .value
                                          .toString(),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snapshot
                                            .child('Title')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot
                                            .child('Description')
                                            .value
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Text('No Post Avaible');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
