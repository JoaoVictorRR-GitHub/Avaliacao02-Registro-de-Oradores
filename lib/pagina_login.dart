import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets_personalizados.dart';
import 'lista_oradores.dart';



// Estilo de texto personalizado.
const TextStyle styleBold = TextStyle(fontWeight: FontWeight.bold);



/*  Pagina para um orador efetuar login.  */
class Entrar extends StatefulWidget {
  const Entrar({super.key});

  @override
  State<Entrar> createState() => _EntrarState();
}

class _EntrarState extends State<Entrar> {

  CollectionReference infoOrador = FirebaseFirestore.instance.collection('Registro-Oradores');
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool loginEfetuado = false; // Indica se o login foi efetuado com sucesso.


  /*  Metodo para efetuar o login do orador.  */
  Future efetuarLogin() async {
    try {
      if ((email.text.isNotEmpty) && (senha.text.isNotEmpty)) {
        // Verifica o email e a senha na base de dados.
        var info = await infoOrador.where('email', isEqualTo: email.text).where('senha', isEqualTo: senha.text).get();

        // CASO 01: Login encontrado.
        if (info.size == 1){
          // Limpando os campos.
          setState(() {
            email.text = "";
            senha.text = "";
            loginEfetuado = true; // Indica que o login foi efetuado com sucesso.
          });
          // Abre a janela com a lista de oradores cadastrados.
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const ListarOradores()));  // Abre a pagina.
        }
        // CASO 02: Login errado.
        else {  // Mensagem.
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confira se o email e a senha estão corretos.')));
          return const Center(child: CircularProgressIndicator(value: 1));
        }
      }
      else {
        // CASO 03: Campos vazios.
        setState(() { loginEfetuado = false; });  // Indica que o login nao foi efetuado.
        // Mensagem.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Os campos não podem estar vazios.')));
        return const Center(child: CircularProgressIndicator(value: 1));
      }
    } catch (erro) {
      // CASO 04: Falha durante o login.
      setState(() { loginEfetuado = false; });  // Indica que o login nao foi efetuado.
      // Mensagem.
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('Erro ao Realizar Login!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: Text('Ocorreu um erro ao tentar realizar o login. $erro'),
          actions: [
            TextButton(
              onPressed: (){ Navigator.pop(context); },
              child: const Text('OK', style: styleBold),
            ),
          ],
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN', style: styleBold),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: CustomPainel(icone: Icons.login_rounded, descricao: 'LOGIN'),  // Painel personalizado.
          ),
          TextField(
            controller: email,
            maxLength: 250,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            style: styleBold,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: TextField(
              controller: senha,
              obscureText: true,
              maxLength: 8,
              decoration: const InputDecoration(labelText: 'Senha'),
              style: styleBold,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
            onPressed: (){
              efetuarLogin();
              // Verifica se o login ja foi efetuado.
              if (loginEfetuado) {  // Mensagem.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A página sera aberta em instantes. Aguarde...')));
              }
            },
            child: const Text('ENTRAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}