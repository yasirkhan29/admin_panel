import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final String clickabletext;
  final Widget page;
  const MyTextButton({
    Key? key,
    this.title = '',
    required this.clickabletext,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
            child: Text(
              clickabletext,
              style: TextStyle(fontSize: 16),
            )),
      ],
    );
  }
}
