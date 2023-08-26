import 'package:flutter/material.dart';
import 'package:flutter_estudos/service/random_number_generator_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var randomNumber = 0;
  var clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu app!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Foi clicado $clicks vezes.",
            style: GoogleFonts.poppins(fontSize: 20),
          )),
          Center(
              child: Text(
            randomNumber.toString(),
            style: GoogleFonts.poppins(fontSize: 48),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            clicks = clicks + 1;
            randomNumber =
                RandomNumberGeneratorService.generateRandomNumber(100);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
