import '../models/agenda.dart';
import '../services/agenda_api.dart';

class AgendaService {
  final AgendaApi _agendaApi;

  AgendaService(this._agendaApi);

  Future<Agenda> getAgenda(String id) async{
    return await _agendaApi.getAgendaById(id);
  }

  Future<List<Agenda>> getAllAgendas() async{
    return await _agendaApi.getAllAgendas();
  }

  Future<Agenda> addAgenda(Agenda agenda) async{
    return await _agendaApi.createAgenda(agenda);
  }

  Future<Agenda> updateAgenda(Agenda agenda) async{
    return await _agendaApi.updateAgenda(agenda);
  }

  Future<void> deleteAgenda(String id) async{
    _agendaApi.deleteAgenda(id);
  }
}