import 'package:desafio_agenda_front_end/src/provider/agenda_provider.dart';
import 'package:desafio_agenda_front_end/src/routes/routes.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_button_add.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_phone.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_subtitle.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaListPage extends StatefulWidget {
  const AgendaListPage({super.key});

  @override
  State<AgendaListPage> createState() => _AgendaListPageState();
}

class _AgendaListPageState extends State<AgendaListPage> {
  void initState() {
    super.initState();
    // Carrega as tarefas quando a página é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgendaProvider>(context, listen: false).loadAgendas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agenda'),
        backgroundColor: Colors.indigo,
        actions: [
          ListViewButtonAdd()
        ],
      ),
      body: Consumer<AgendaProvider>(
        builder: (context, agendaProvider, child) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                leading: Icon(Icons.person, color: Colors.black54,),
                title: ListViewTitle(agendaProvider.agenda[index].nome),
                subtitle: ListViewSubtitle(agendaProvider.agenda[index].sobrenome),
                trailing: ListViewPhone(agendaProvider.agenda[index].telefone),
                onTap: () {
                  Navigator.pushNamed(context, Routes.AGENDA_FORM, arguments: agendaProvider.agenda[index]);
                },
              );
            },
            padding: EdgeInsets.all(12),
            separatorBuilder: (_, _) => Divider(),
            itemCount: agendaProvider.agenda.length,
          );
        },
      ),
    );
  }
}
