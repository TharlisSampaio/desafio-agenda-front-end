import 'package:flutter/material.dart';

class ListViewPhone extends StatelessWidget {
  final String? phone;
  const ListViewPhone(this.phone, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      phone.toString(),
      style: TextStyle(fontSize: 14),
    );
  }
}
