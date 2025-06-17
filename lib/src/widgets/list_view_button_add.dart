import 'package:desafio_agenda_front_end/src/routes/routes.dart';
import 'package:flutter/material.dart';

class ListViewButtonAdd extends StatelessWidget {
  const ListViewButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_ic_call_sharp),
      onPressed: () {
        Navigator.pushNamed(context, Routes.AGENDA_FORM);
      },
    );
  }
}
