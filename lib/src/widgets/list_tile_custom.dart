import 'package:desafio_agenda_front_end/src/widgets/list_view_phone.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_subtitle.dart';
import 'package:desafio_agenda_front_end/src/widgets/list_view_title.dart';
import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? trailing;
  final GestureTapCallback? onTap;

  const ListTileCustom({super.key, this.title, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ListViewTitle(title),
      subtitle: ListViewSubtitle(subtitle),
      trailing: ListViewPhone(trailing),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      leading: Icon(Icons.person, color: Colors.black54),
      onTap: onTap,
    );
  }
}
