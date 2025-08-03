import 'package:flutter/material.dart';

class ButtomOutlinedDeletar extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  const ButtomOutlinedDeletar({super.key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.red.shade400),
        foregroundColor: WidgetStatePropertyAll(Colors.black87),
      ),
      child: Text(title ?? ''),
    );
  }
}
