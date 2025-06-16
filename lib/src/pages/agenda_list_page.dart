import 'package:desafio_agenda_front_end/src/provider/agenda_provider.dart';
import 'package:desafio_agenda_front_end/src/routes/routes.dart';
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
          IconButton(
            icon: Icon(Icons.add_ic_call_sharp),
            onPressed: () {
              Navigator.pushNamed(context, Routes.AGENDA_FORM);
            },
          )
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
                title: Text(
                  agendaProvider.agenda[index].nome.toString(),
                  style: TextStyle(fontSize: 16),
                  ),
                subtitle: Text(
                  agendaProvider.agenda[index].sobrenome.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Text(
                  agendaProvider.agenda[index].telefone.toString(),
                  style: TextStyle(fontSize: 14),
                ),
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
