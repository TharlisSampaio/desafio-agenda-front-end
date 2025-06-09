import 'package:desafio_agenda_front_end/src/models/agenda.dart';
import 'package:desafio_agenda_front_end/src/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgendaApi {
  final String _baseUrl = AppConstants.BASE_API_URL;

  // async: diz que a função pode conter operações que não vão ser 
  // executadas de forma imediata.

  // await: espera a conclusão de um async


  // Recuperar todas as Agendas (JSON -> List<Object Dart>)
  Future <List<Agenda>> getAllAgendas() async{
    final response = await http.get(Uri.parse('$_baseUrl/agenda'));

    if(response.statusCode == 200){
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Agenda.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as tarefas');
    }
  }

  // Recuperar uma Agenda atraves do id (JSON -> Object Dart)
  Future<Agenda> getAgendaById(String id) async{
    final response = await http.get(
      Uri.parse('$_baseUrl/agenda/$id')
    );

    if(response.statusCode == 200){
      return Agenda.fromJson(json.decode(response.body));
    } else{
      throw Exception('O id=$id não existe no servidor');
    }
  }

  // Cria uma nova Agenda (Object Dart -> JSON)
  Future<Agenda> createAgenda(Agenda agendaToCreate) async{
    final response = await http.post(
      Uri.parse('$_baseUrl/agenda'),
      headers: {'Content-type': 'application/json'},
      body: json.encode(agendaToCreate.toJson())
    );

    if(response.statusCode == 201){
      return Agenda.fromJson(json.decode(response.body));
    } else{
      throw Exception('Não foi possivel criar agenda'); 
    }
  }

  // Atualiza uma Agenda passando o id (Object Dart -> JSON)
  Future<Agenda> updateAgenda(Agenda agendaToUpdate) async{
    final response = await http.put(
      Uri.parse('$_baseUrl/agenda/${agendaToUpdate.id}'),
      headers: {'Content-type': 'application/json'},
      body: json.encode(agendaToUpdate.toJson())
    );

    if(response.statusCode == 200){
      return Agenda.fromJson(json.decode(response.body));
    } else{
      throw Exception('Não foi possível atualizar a agenda');
    }
  }

  // Deleta uma Agenda ao passa um id
  Future<void> deleteAgenda(String id) async{
    final response = await http.delete(
      Uri.parse('$_baseUrl/agenda/$id')
    );

    if(response.statusCode != 204){
      throw Exception('Falha em deletar agenda');
    }
  }
}