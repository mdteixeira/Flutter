import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/add_contacts_page.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';

class AddContactsFAB extends StatefulWidget {
  const AddContactsFAB({super.key});

  @override
  State<AddContactsFAB> createState() => _AddContactsFABState();
}

class _AddContactsFABState extends State<AddContactsFAB> {
  var repository = ContactsRepository();

  var contato = Contato();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const AddContactsPage())));
      },
      child: const Icon(Icons.add),
    );
  }
}
