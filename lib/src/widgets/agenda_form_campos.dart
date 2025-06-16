import 'package:flutter/material.dart';

class AgendaFormCampos extends StatelessWidget {
  Map<String, dynamic> _formData = {};

  AgendaFormCampos(this._formData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: _formData['nome'],
          decoration: InputDecoration(labelText: 'Nome'),
          onSaved: (value) {
            _formData['nome'] = value;
          },
        ),
        TextFormField(
          initialValue: _formData['sobrenome'],
          decoration: InputDecoration(labelText: 'Sobrenome'),
        ),
        TextFormField(
          initialValue: _formData['telefone'],
          decoration: InputDecoration(labelText: 'Telefone'),
        ),
      ],
    );
  }
}
