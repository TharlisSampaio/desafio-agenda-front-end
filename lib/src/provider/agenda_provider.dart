import 'package:flutter/material.dart';
import '../services/agenda_service.dart';
import '../models/agenda.dart';

class AgendaProvider extends ChangeNotifier{
  final AgendaService _agendaService;
  List<Agenda> _agendas = [];
  bool _isLoading = false;
  String? _errorMessage;

  AgendaProvider(this._agendaService);

  List<Agenda> get agenda => _agendas;
  bool get isLoading => _isLoading;
  String? get errorMessage  => _errorMessage;

  Future<void> loadAgendas() async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _agendas = await _agendaService.getAllAgendas();
    } catch (e){
      _errorMessage = 'Erro ao carregar as agenda: ${e.toString()}';
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAgenda(Agenda agenda) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      final newAgenda = await _agendaService.addAgenda(agenda);
      _agendas.add(newAgenda);
    } catch (e){
      _errorMessage = 'Erro em criar agenda: ${e.toString()}';
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAgenda(Agenda agenda) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _agendas.remove(agenda);
      final newAgenda = await _agendaService.updateAgenda(agenda);
      _agendas.add(newAgenda);
    } catch (e){
      _errorMessage = 'Erro em atualizar Agenda ${e.toString()}';
    } finally{
      _isLoading = false;
      loadAgendas();
    }
  }

  Future<void> deleteAgenda(String id) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      await _agendaService.deleteAgenda(id);
      _agendas.removeWhere((agenda) => agenda.id.toString() == id);
    } catch (e){
      _errorMessage = 'Erro ao deletar agenda: ${e.toString()}';
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}