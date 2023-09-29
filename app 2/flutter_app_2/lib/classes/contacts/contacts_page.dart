import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';
import 'package:flutter_app_2/pages/contact_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var repository = ContactsRepository();
  var loading = false;

  var _contatos = [];

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    obterContatos();
    setState(() {
      loading = false;
    });
    super.initState();
  }

  obterContatos() async {
    setState(() {
      loading = true;
    });
    _contatos = await repository.obterContatos();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        obterContatos();
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext bc, int index) {
                var contato = _contatos[index];
                return Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ContactPage(contato: contato)));
                        },
                        title: Text(contato.contactName ?? 'null'),
                        leading: CircleAvatar(
                          child: contato.contactPhoto == 'none'
                              ? Text(contato.contactName
                                  .toString()
                                  .substring(0, 1))
                              : const Icon(Icons.person),
                        )),
                    const Divider()
                  ],
                );
              },
              itemCount: _contatos.length,
            ),
          )
        ],
      ),
    );
  }
}
