import 'package:flutter/material.dart';

class BottomCancelar extends StatelessWidget {
  const BottomCancelar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cancel),
      color: Colors.redAccent,
      onPressed: () {
        Navigator.of(context).pop();
        //Navigator.pushNamed(context, Routes.HOME);
      },
    );
  }
}
