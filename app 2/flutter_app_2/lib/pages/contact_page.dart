import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.contato});

  final Contato contato;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var repository = ContactsRepository();
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contato"),
        actions: [
          MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: const Text('Apagar contato'),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await repository.apagar(widget.contato.objectId);
                  setState(() {
                    loading = true;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return TextButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: const Icon(Icons.more_vert),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 60,
            child: widget.contato.contactPhoto == 'none'
                ? Text(
                    widget.contato.contactName.toString().substring(0, 1),
                    style: const TextStyle(fontSize: 45),
                  )
                : const Icon(Icons.person),
          ),
          Column(
            children: [
              const SizedBox(height: 15),
              Text(
                widget.contato.contactName ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text('Telefone: ${widget.contato.contactNumber ?? ''}'),
            ],
          )
        ],
      ),
    );
  }
}
