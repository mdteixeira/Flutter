import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import '../../model/characters_model.dart';

class MarvelRepository {
  Future<CharactersModel> getCharacters() async {
    var dio = Dio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = '479ba15d06963f0030d07c4154d4ad26';
    var privateKey = 'bf2f2dafaf7d403cbff745878918080c7d0c84b8';
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query = "&ts=$ts&apikey=$publicKey&hash=$hash";
    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    var charactersModel = CharactersModel.fromJson(result.data);
    return charactersModel;
  }

  _generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
