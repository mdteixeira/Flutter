import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 251, 229),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Icon(
                Icons.person,
                size: 125,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                color: Colors.amber.shade100,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 36,
                alignment: Alignment.center,
                child: const Text("Insira seu email"),
              ),
              Container(
                width: double.infinity,
                color: Colors.amber.shade100,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 36,
                alignment: Alignment.center,
                child: const Text("Insira sua senha"),
              ),
              Container(
                  width: double.infinity,
                  color: Colors.amber.shade400,
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  "Cadastro",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
