import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/viacep_model.dart';
import 'package:flutter_estudos/repositories/via_cep_repo.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController();
  var viaCEP = ViaCEPModel();
  var viaCEPrepository = ViaCepRepository();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text(
              'Insira um CEP',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              maxLength: 8,
              onChanged: (String value) async {
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viaCEP = await viaCEPrepository.consultarCEP(cep);
                }
                loading = false;
                setState(() {});
              },
              controller: cepController,
            ),
            const SizedBox(
              height: 50,
            ),
            Visibility(
                visible: loading, child: const CircularProgressIndicator()),
            Visibility(
                visible: !loading,
                child: Column(
                  children: [
                    Text(
                      viaCEP.logradouro ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${viaCEP.localidade ?? ''} ${viaCEP.uf ?? ''}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
