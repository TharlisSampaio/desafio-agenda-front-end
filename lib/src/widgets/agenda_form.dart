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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulario de Agenda'),
          backgroundColor: Colors.lightBlue,
          actions: [
            IconButton(
              icon: Icon(Icons.cancel),
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.green,
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _form.currentState?.save();
                  if (_formData['id'] == null) {
                    agendaProvider.addAgenda(
                      Agenda(
                        nome: _formData['nome'],
                        sobrenome: _formData['sobrenome'],
                        telefone: _formData['telefone'],
                      ),
                    );
                  } else {
                    agendaProvider.updateAgenda(
                      Agenda(
                        id: _formData['id'],
                        nome: _formData['nome'],
                        sobrenome: _formData['sobrenome'],
                        telefone: _formData['telefone'],
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData['nome'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => {_formData['nome'] = value},
                ),
                TextFormField(
                  initialValue: _formData['sobrenome'],
                  decoration: InputDecoration(labelText: 'Sobrenome'),
                  onSaved: (value) => {_formData['sobrenome'] = value},
                ),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'insira um telefone';
                    }
                  },
                  onSaved: (value) => {_formData['telefone'] = value},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
