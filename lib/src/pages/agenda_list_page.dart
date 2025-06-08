import 'package:desafio_agenda_front_end/src/provider/agenda_provider.dart';
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
        title: Text('Agenda'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.add_sharp),
            color: Colors.black54,
            onPressed: () {
              Navigator.pushNamed(context, '/agenda-form');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<AgendaProvider>(
          builder: (context, agendaProvider, child) {
            if (agendaProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (agendaProvider.errorMessage != null) {
              return Center(
                child: Text(
                  agendaProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (agendaProvider.agenda.isEmpty) {
              return Center(child: Text('Nenhuma tarefa encontrada.'));
            }
            return ListView.builder(
              itemCount: agendaProvider.agenda.length,
              itemBuilder: (context, index) {
                final agenda = agendaProvider.agenda[index];
                return Center(
                  child: Card(
                    color: const Color.fromARGB(255, 238, 234, 234),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('${agenda.nome} ${agenda.sobrenome}'),
                          subtitle: Text('${agenda.telefone}'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit_sharp,
                                color: Colors.green[300],
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/agenda-form', arguments: agenda);
                                print('Botão de editar');
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_sharp,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                agendaProvider.deleteAgenda(agenda.id.toString());
                                print('Botão de deletar');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
