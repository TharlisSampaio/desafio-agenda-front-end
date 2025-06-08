import 'package:desafio_agenda_front_end/src/pages/agenda_list_page.dart';
import 'package:desafio_agenda_front_end/src/provider/agenda_provider.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_api.dart';
import 'package:desafio_agenda_front_end/src/services/agenda_service.dart';
import 'package:desafio_agenda_front_end/src/widgets/agenda_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgendaProvider(AgendaService(AgendaApi())),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AgendaService>(create: (_) => AgendaService(AgendaApi())),
      ],
      child: Center(
        child: MaterialApp(
          title: 'Agenda',
          theme: ThemeData(
            primaryColor: Colors.lightBlue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const AgendaListPage(),
            '/agenda-form': (context) => const AgendaForm(),
          },
        ),
      ),
    );
  }
}
