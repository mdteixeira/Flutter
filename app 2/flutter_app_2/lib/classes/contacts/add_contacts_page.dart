import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';
import 'package:flutter_app_2/classes/image/image_helper.dart';
import 'package:image_cropper/image_cropper.dart';

final imageHelper = ImageHelper();

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

  File? image;

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
                                title: const Text('Galeria'),
                                leading: const Icon(Icons.photo_library),
                                onTap: () async {
                                  final file = await ImageHelper().pickImage();
                                  if (file != null) {
                                    final croppedFile = await imageHelper.crop(
                                      file: file,
                                      cropStyle: CropStyle.circle,
                                    );
                                    if (croppedFile != null) {
                                      setState(() {
                                        image = File(croppedFile.path);
                                      });
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      radius: 60,
                      foregroundImage: image != null ? FileImage(image!) : null,
                    ),
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
                              contactPhoto: image?.path ?? 'none',
                              contactNumber: numberController.text));
                          setState(() {
                            loading = false;
                            Navigator.pop(context);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Contato criado.')));
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
