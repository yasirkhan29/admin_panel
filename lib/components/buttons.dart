import 'package:flutter/material.dart';

import '../colors/color.dart';

class MyButtons extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback;
  MyButtons(
      {Key? key,
      required this.title,
      required this.VoidCallback,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          VoidCallback();
          FocusScope.of(context).unfocus();
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: MyColors.Color_blue,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: loading
                    ? CircularProgressIndicator(color: MyColors.Color_white)
                    : Text(title,
                        style: TextStyle(
                            color: MyColors.Color_white, fontSize: 20)))));
  }
}
