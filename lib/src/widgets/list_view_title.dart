import 'package:flutter/material.dart';

class ListViewTitle extends StatelessWidget {
  final String? title;
  const ListViewTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      style: TextStyle(
        fontSize: 16,)
    );
  }
}
