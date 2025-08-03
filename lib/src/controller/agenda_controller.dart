import 'package:desafio_agenda_front_end/src/models/agenda.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_service.dart';
import 'package:get/get.dart';

class AgendaController extends GetxController with StateMixin<List<Agenda>>{
  final AgendaService _agendaService;

  AgendaController(this._agendaService);

  final _agendas = <Agenda>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllAgendas();
  }

  void _ordenar() {
    _agendas.sort((a, b) => a.nome!.toLowerCase().compareTo(a.nome!.toLowerCase()));
  }

  void getAllAgendas() async {
    try {
      _agendas.assignAll(await _agendaService.getAllAgendas());
      change(_agendas, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error('Não foi possivel carrgar as agendas'));
    }
  }

  void createdAgenda(Agenda agenda) async {
    try {
      var newAgenda = await _agendaService.addAgenda(agenda);
      _agendas.add(newAgenda);
      _ordenar();
      _agendas.refresh();
      change(_agendas, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error('Failed in created Aganda'));
    }
  }

  void updateAgenda(Agenda agenda) async {
    try {
      _agendas.removeWhere((element) => element.id.toString() == agenda.id.toString());
       var newAgenda = await _agendaService.updateAgenda(agenda);
      _agendas.add(newAgenda);
      _agendas.refresh();
      _ordenar();
      change(_agendas, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error('Failed in update Agenda'));
    }
  }
  void deleteAgenda(String id) async {
    try {
      _agendaService.deleteAgenda(id);
      _agendas.removeWhere((agenda) => agenda.id.toString() == id);
      _ordenar();
      _agendas.refresh();
      change(_agendas, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error('Failed in delete Aganda'));
    }
  }
}