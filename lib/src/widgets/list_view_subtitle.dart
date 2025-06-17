import 'package:flutter/material.dart';

class ListViewSubtitle extends StatelessWidget {
  final String? subtitle;
  const ListViewSubtitle(this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle.toString(),
      style: TextStyle(fontSize: 14),
    );
  }
}
