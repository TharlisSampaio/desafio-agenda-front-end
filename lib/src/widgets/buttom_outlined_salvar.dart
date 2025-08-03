import 'package:flutter/material.dart';

class ButtomOutlinedSalvar extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;


  const ButtomOutlinedSalvar({super.key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black87),
        overlayColor: WidgetStatePropertyAll(Colors.green.shade400),
      ),
      child: Text(title ?? ''),
    );
  }
}
