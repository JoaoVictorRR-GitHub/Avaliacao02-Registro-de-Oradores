import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



// Estilo de texto personalizado.
const TextStyle styleBold = TextStyle(fontWeight: FontWeight.bold);



/*  Pagina para exibir as
    informacoes de um orador. */
class ExibirInformacoes extends StatefulWidget {
  const ExibirInformacoes({super.key, required this.info});
  final DocumentSnapshot info;

  @override
  State<ExibirInformacoes> createState() => _ExibirInformacoesState();
}

class _ExibirInformacoesState extends State<ExibirInformacoes> {

  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController nota_biografica = TextEditingController();

  /*  Metodo para inserir as
      informacaoes nos campos.  */
  void inserirInfo() {
    setState(() {
      nome.text = widget.info['nome'];
      email.text = widget.info['email'];
      telefone.text = widget.info['telefone'];
      nota_biografica.text = widget.info['nota_biografica'];
    });
  }


  @override
  Widget build(BuildContext context) {
    inserirInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFORMAÇÕES DO ORADOR:', style: styleBold),
        backgroundColor: Colors.black12,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Card(
                    color: Colors.white70,
                    child: Image.network(widget.info['foto_url']),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            readOnly: true,
            controller: nome,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Nome'),
            style: styleBold,
          ),
          TextField(
            readOnly: true,
            controller: email,
            maxLength: 250,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            style: styleBold,
          ),
          TextField(
            readOnly: true,
            controller: telefone,
            maxLength: 25,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Telefone'),
            style: styleBold,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: TextField(
              readOnly: true,
              controller: nota_biografica,
              maxLength: 500,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Nota Biográfica',
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}