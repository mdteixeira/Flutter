import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app_2/classes/contacts/contacts_model.dart';

class ContactsRepository {
  obterContatos() async {
    var dio = Dio();

    dio.options.headers['X-Parse-Application-Id'] =
        'j2oRFY9clTOPj1fMjmmtLtsFjlOicjcvZeVxjAyL';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'xHTJ7QqQQK2F8gxsalw59CJOBAKP5FuJfGgUP3mM';
    dio.options.headers['Content-Type'] = 'application/json';

    var response =
        await dio.get('https://parseapi.back4app.com/classes/contact');

    var contatos = [];
    var json = jsonDecode(response.toString());
    var items = json['results'];
    for (var item in items) {
      var contato = Contato.fromJson(item);
      contatos.add(contato);
    }
    return contatos;
  }

  salvarContato(Contato contato) async {
    var dio = Dio();

    dio.options.headers['X-Parse-Application-Id'] =
        'j2oRFY9clTOPj1fMjmmtLtsFjlOicjcvZeVxjAyL';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'xHTJ7QqQQK2F8gxsalw59CJOBAKP5FuJfGgUP3mM';
    dio.options.headers['Content-Type'] = 'application/json';

    var response =
        await dio.post('https://parseapi.back4app.com/classes/contact', data: {
      'contactName': contato.contactName,
      'contactNumber': contato.contactNumber,
      'contactPhoto': contato.contactPhoto
    });
    if (response.statusCode == 201) {
      print('sucesso');
    } else {
      print(response.statusCode);
    }
  }

  apagar(String? objectId) async {
    var dio = Dio();

    dio.options.headers['X-Parse-Application-Id'] =
        'j2oRFY9clTOPj1fMjmmtLtsFjlOicjcvZeVxjAyL';
    dio.options.headers['X-Parse-REST-API-Key'] =
        'xHTJ7QqQQK2F8gxsalw59CJOBAKP5FuJfGgUP3mM';
    dio.options.headers['Content-Type'] = 'application/json';

    var response = await dio
        .delete('https://parseapi.back4app.com/classes/contact/$objectId');

    if (response.statusCode == 200) {
      print('apagou com sucesso');
    }
  }
}
