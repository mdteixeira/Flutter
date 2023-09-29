import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  var repository = ContactsRepository();

  var contato = Contato();

  var nomeController = TextEditingController();
  var numberController = TextEditingController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar novo contato'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    showDragHandle: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          Column(
                            children: [
                              ListTile(
                                title: const Text('Câmera'),
                                leading: const Icon(Icons.photo_camera),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Galeria'),
                                onTap: () {},
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  child: contato.contactPhoto == 'none'
                      ? Text(
                          nomeController.text.substring(0, 1),
                          style: const TextStyle(fontSize: 45),
                        )
                      : const Icon(
                          Icons.person_add,
                          size: 50,
                        ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Nome'),
                  controller: nomeController,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Telefone'),
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 30,
                ),
                loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (nomeController.text == '' &&
                              numberController.text == '') {}
                          setState(() {
                            loading = true;
                          });
                          await repository.salvarContato(Contato(
                              contactName: nomeController.text,
                              contactPhoto: 'none',
                              contactNumber: numberController.text));
                          setState(() {
                            loading = false;
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Criar Contato"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
