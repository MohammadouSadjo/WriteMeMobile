import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:write_me/providers/typeNoteProvider.dart';

import '../../folder_contain_empty.dart';
import '../../models/type_note.dart';

class MyTypeNote extends StatelessWidget {
  final int id;
  final Type_Note typenote;

  const MyTypeNote(this.id, this.typenote, {super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<TypeNoteProvider>(
      builder: (context, typenoteProvider, child) => Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FolderContainEmpty(
                    title: typenote.intitule_type,
                    id: id,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('lib/images/logov2.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          color: const Color.fromRGBO(61, 110, 201, 1.0),
                          width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  width: 110,
                  height: 110,
                ),
                Container(
                  width: 120.0,
                  height: 30.0,
                  margin:
                      const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 35),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        typenote.intitule_type,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        DateFormat("dd MMM", 'fr_FR')
                            .format(typenote.date_creation)
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color.fromRGBO(16, 43, 64, 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
