import 'package:desafio_agenda_front_end/src/controller/agenda_controller.dart';
import 'package:desafio_agenda_front_end/src/pages/agenda_form.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_api.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewButtonAdd extends StatelessWidget {
  const ListViewButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final AgendaController _controller = Get.put(
    AgendaController(AgendaService(AgendaApi())),
  );
    return IconButton(
      icon: Icon(Icons.add_ic_call_sharp),
      onPressed: () {
        Get.to(AgendaForm(controller: _controller));
      },
    );
  }
}
