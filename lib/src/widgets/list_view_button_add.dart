import 'package:flutter/material.dart';

class ListViewButtonAdd extends StatelessWidget {
  final VoidCallback? onPressed;
  const ListViewButtonAdd({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_ic_call_sharp),
      onPressed: onPressed,
    );
  }
}
