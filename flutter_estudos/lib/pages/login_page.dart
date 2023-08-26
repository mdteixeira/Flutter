import 'package:flutter/material.dart';
import 'package:flutter_estudos/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // child: ConstrainedBox(
          //   constraints: BoxConstraints(
          //     maxHeight: MediaQuery.of(context).size.height,
          //   ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              // const Row(
              // children: [
              // Expanded(child: Container()),
              // const Expanded(
              // flex: 7,
              // child:
              const Icon(Icons.person, size: 150),
              // child: Image.network(
              //     'https://raw.githubusercontent.com/mdteixeira/mdteixeira.github.io/4c88e5c94f7f62e7a7a5fc09f6fb0d308b74661c/images/logo/logo-long.png',
              //     width: 350),
              // ),
              // Expanded(child: Container()),
              // ],
              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 36,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 36,
                child: TextField(
                  obscureText: isObscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      child: Icon(isObscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: 'Senha',
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if (emailController.text.trim() == "em" &&
                              passwordController.text.trim() == '123') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Login efetuado com sucesso!")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Erro ao efetuar Login.")));
                          }
                        },
                        child: const Text(
                          'Entrar',
                        )),
                  )),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Entrar',
                        )),
                  )),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
