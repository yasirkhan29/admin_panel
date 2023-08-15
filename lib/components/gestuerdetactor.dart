import 'package:flutter/material.dart';

class MyGesterDector extends StatelessWidget {
  final String title;
  final icone;
  final VoidCallback;
  const MyGesterDector(
      {Key? key,
      required this.title,
      required this.icone,
      required this.VoidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        VoidCallback();
        Navigator.pop(context);
      },
      child: ListTile(
        title: Text(title),
        leading: icone,
      ),
    );
  }
}
