import 'package:desafio_agenda_front_end/src/controller/agenda_controller.dart';
import 'package:desafio_agenda_front_end/src/pages/agenda_form.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_api.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_service.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_tile_custom.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_button_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgendaListPage extends StatefulWidget {
  const AgendaListPage({super.key});

  @override
  State<AgendaListPage> createState() => _AgendaListPageState();
}

class _AgendaListPageState extends State<AgendaListPage> {
  final AgendaController _controller = Get.put(
    AgendaController(AgendaService(AgendaApi())),
  );

  @override
  void initState() {
    super.initState();
    // Carrega as tarefas quando a página é inicializada
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<AgendaProvider>(context, listen: false).loadAgendas();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agenda'),
        backgroundColor: Colors.indigo,
        actions: [
          ListViewButtonAdd(
            onPressed: () => Get.to(AgendaForm(controller: _controller)),
          ),
        ],
      ),
      body: _controller.obx(
        (state) => ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final agenda = state?[index];
            return ListTileCustom(
              title: agenda?.nome,
              subtitle: agenda?.sobrenome,
              trailing: agenda?.telefone,
              onTap: () {
                Get.to(AgendaForm(agenda: agenda, controller: _controller));
              },
            );
          },
          padding: EdgeInsets.all(12),
          itemCount: state?.length,
        ),
        onLoading: Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
