import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';
import 'package:flutter_app_2/classes/contacts/contacts_repository.dart';
import 'package:flutter_app_2/classes/image/image_helper.dart';
import 'package:image_cropper/image_cropper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.contato});

  final Contato contato;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var repository = ContactsRepository();
  var loading = false;

  var editing = false;

  var nomeController = TextEditingController();
  var numberController = TextEditingController();

  File? image;

  final imageHelper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    image = File(widget.contato.contactPhoto!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contato"),
        actions: [
          MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: const Text('Editar contato'),
                onPressed: () {
                  setState(() {
                    editing = true;
                    nomeController.text = widget.contato.contactName ?? '';
                    numberController.text = widget.contato.contactNumber ?? '';
                  });
                },
              ),
              MenuItemButton(
                child: const Text('Apagar contato'),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  repository.apagar(widget.contato.objectId);
                  setState(() {
                    loading = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contato apagado.')));
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
          editing
              ? Column(
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
                                            leading:
                                                const Icon(Icons.photo_library),
                                            onTap: () async {
                                              final file = await ImageHelper()
                                                  .pickImage();
                                              if (file != null) {
                                                final croppedFile =
                                                    await imageHelper.crop(
                                                  file: file,
                                                  cropStyle: CropStyle.circle,
                                                );
                                                if (croppedFile != null) {
                                                  setState(() {
                                                    image =
                                                        File(croppedFile.path);
                                                    widget.contato
                                                            .contactPhoto =
                                                        image?.path;
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
                            child: CircleAvatar(
                                radius: 60,
                                foregroundImage:
                                    image != null ? FileImage(image!) : null,
                                child: Text(widget.contato.contactName
                                    .toString()
                                    .substring(0, 1)))),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          const Text('Nome'),
                          TextFormField(
                            controller: nomeController,
                          ),
                          const SizedBox(height: 30),
                          const Text('Telefone'),
                          TextFormField(controller: numberController),
                          const SizedBox(height: 30),
                          Center(
                            child: loading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      widget.contato.contactName =
                                          nomeController.text;
                                      widget.contato.contactNumber =
                                          numberController.text;
                                      await repository.editar(widget.contato);
                                      setState(() {
                                        loading = false;
                                        editing = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Contato editado.')));
                                    },
                                    child: const Text('Salvar alterações')),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        foregroundImage: FileImage(image!),
                        child: Text(
                          widget.contato.contactName.toString().substring(0, 1),
                          style: const TextStyle(fontSize: 45),
                        )),
                    const SizedBox(height: 15),
                    Text(
                      widget.contato.contactName ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text('Telefone: ${widget.contato.contactNumber ?? ''}'),
                  ],
                )
        ],
      ),
    );
  }
}
