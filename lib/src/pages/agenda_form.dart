import 'package:desafio_agenda_front_end/src/models/agenda.dart';
import 'package:desafio_agenda_front_end/src/provider/agenda_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaForm extends StatefulWidget {
  const AgendaForm({super.key});

  @override
  State<AgendaForm> createState() => _AgendaFormState();
}

class _AgendaFormState extends State<AgendaForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool isButtonEnabled = false;

  void _loadFormData(Agenda agenda) {
    _formData['id'] = agenda.id;
    _formData['nome'] = agenda.nome;
    _formData['sobrenome'] = agenda.sobrenome;
    _formData['telefone'] = agenda.telefone;
  }

  @override
  Widget build(BuildContext context) {
    final AgendaProvider agendaProvider = Provider.of(context);
    final route = ModalRoute.of(context)?.settings.arguments;
    if (route != null) {
      final agenda = route as Agenda;
      _loadFormData(agenda);
    }
    if (_formData['id'] != null) {
      isButtonEnabled = true;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Formulario de Agenda'),
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black54,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [],
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(18),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData['nome'],
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _formData['nome'] = value;
                  },
                ),
                SizedBox(height: 18,),
                TextFormField(
                  initialValue: _formData['sobrenome'],
                  decoration: InputDecoration(
                    labelText: 'Sobrenome',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _formData['sobrenome'] = value;
                  },
                ),
                SizedBox(height: 18,),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _formData['telefone'] = value;
                  },
                ),
                SizedBox(height: 18,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          _form.currentState?.save();
                          agendaProvider.addAgenda(
                            Agenda(
                              nome: _formData['nome'],
                              sobrenome: _formData['sobrenome'],
                              telefone: _formData['telefone']
                            )
                          );
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('Salvar'),
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.black87),
                          overlayColor: WidgetStatePropertyAll(Colors.green.shade400),
                        ),
                      )
                    ),
                    OutlinedButton(
                      onPressed: isButtonEnabled ? () {
                        agendaProvider.deleteAgenda(_formData['id'].toString());
                        Navigator.of(context).pop();
                      } : null,
                      child: const Text('Excluir',),
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(Colors.red.shade400),
                        foregroundColor: WidgetStatePropertyAll(Colors.black87),
                        
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
