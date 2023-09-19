import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrasilFields extends StatefulWidget {
  const BrasilFields({super.key});

  @override
  State<BrasilFields> createState() => _BrasilFieldsState();
}

class _BrasilFieldsState extends State<BrasilFields> {
  @override
  Widget build(BuildContext context) {
    var controllerCEP = TextEditingController();
    var controllerCPF = TextEditingController();
    var controllerDinheiro = TextEditingController();
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('CEP'),
                TextFormField(
                  controller: controllerCEP,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('CPF'),
                TextFormField(
                  controller: controllerCPF,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Dinheiro'),
                TextFormField(
                  controller: controllerDinheiro,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
            child: TextButton(
                onPressed: () {
                  print(CPFValidator.isValid(controllerCPF.text));
                },
                child: Text('Salvar')))
      ],
    );
  }
}
