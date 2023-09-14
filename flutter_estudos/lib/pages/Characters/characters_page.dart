import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/characters_model.dart';
import 'package:flutter_estudos/repositories/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();

  @override
  void initState() {
    marvelRepository = MarvelRepository();
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    characters = await marvelRepository.getCharacters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Heróis da Marvel')),
      body: Container(
        child: ListView.builder(
            itemCount:
                (characters.data == null || characters.data!.results == null)
                    ? 0
                    : characters.data!.results!.length,
            itemBuilder: (_, int index) {
              var character = characters.data!.results![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            '${character.thumbnail!.path!}.${character.thumbnail!.extension!}',
                            width: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    character.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(character.description!),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    ));
  }
}
