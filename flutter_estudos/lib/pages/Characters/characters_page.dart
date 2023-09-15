import 'package:flutter/material.dart';
import 'package:flutter_estudos/model/characters_model.dart';
import 'package:flutter_estudos/repositories/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();
  int offset = 0;

  var loading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    marvelRepository = MarvelRepository();
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    if (loading) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        loading = true;
      });
      offset = offset + characters.data!.count!;

      var tempList = await marvelRepository.getCharacters(offset);

      characters.data!.results!.addAll(tempList.data!.results!);
      loading = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Heróis da Marvel')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null ||
                        characters.data!.results == null)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          !loading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          carregarDados();
                        },
                        child: const Text('Carregar mais itens')),
                    Text(
                        '${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}'),
                  ],
                )
              : const LinearProgressIndicator()
        ],
      ),
    ));
  }
}
