import 'package:desafio_agenda_front_end/src/controller/agenda_controller.dart';
import 'package:desafio_agenda_front_end/src/models/agenda.dart';
import 'package:desafio_agenda_front_end/src/pages/agenda_list_page.dart';
import 'package:desafio_agenda_front_end/src/widgets/buttom_outlined_deletar.dart';
import 'package:desafio_agenda_front_end/src/widgets/buttom_outlined_salvar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgendaForm extends StatefulWidget {
  final Agenda? agenda;
  final AgendaController controller;
  const AgendaForm({super.key, this.agenda, required this.controller});

  @override
  State<AgendaForm> createState() => _AgendaFormState();
}

class _AgendaFormState extends State<AgendaForm> {
  // final AgendaController _controller = Get.put(AgendaController(AgendaService(AgendaApi())));

  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool isButtonEnabled = false;

  void _loadFormData(Agenda agenda) {
    _formData['id'] = agenda.id;
    _formData['nome'] = agenda.nome;
    _formData['sobrenome'] = agenda.sobrenome;
    _formData['telefone'] = agenda.telefone;
  }

  void _onSave() {
    if (_form.currentState!.validate()) {
      _form.currentState?.save();
      if (_formData['id'] == null) {
        widget.controller.createdAgenda(
          Agenda(
            nome: _formData['nome'],
            sobrenome: _formData['sobrenome'],
            telefone: _formData['telefone'],
          ),
        );
      } else {
        widget.controller.updateAgenda(
          Agenda(
            id: _formData['id'],
            nome: _formData['nome'],
            sobrenome: _formData['sobrenome'],
            telefone: _formData['telefone'],
          ),
        );
      }
      Get.to(AgendaListPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.agenda != null) {
      print('aqui meu chapa: ${widget.agenda}');
      _loadFormData(widget.agenda!);
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
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    _formData['nome'] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um nome.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
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
                SizedBox(height: 18),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    _formData['telefone'] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o telefone.';
                    }
                    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                    if (digitsOnly.length < 10 || digitsOnly.length > 11) {
                      // Considerando 10 ou 11 dígitos (com DDD)
                      return 'O telefone deve ter 10 ou 11 dígitos.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ButtomOutlinedSalvar(
                        title: "Salvar",
                        onPressed: () {
                          _onSave();
                        },
                      ),
                    ),
                    ButtomOutlinedDeletar(
                      title: 'Excluir',
                      onPressed: isButtonEnabled
                          ? () {
                              widget.controller.deleteAgenda(
                                _formData['id'].toString(),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
