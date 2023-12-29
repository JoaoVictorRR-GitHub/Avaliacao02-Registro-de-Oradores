import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';



// Estilo de texto personalizado.
const TextStyle styleBold = TextStyle(fontWeight: FontWeight.bold);



/*  Pagina para um orador se registrar. */
class RegistrarOrador extends StatefulWidget {
  const RegistrarOrador({super.key});

  @override
  State<RegistrarOrador> createState() => _RegistrarOradorState();
}

class _RegistrarOradorState extends State<RegistrarOrador> {

  CollectionReference infoOrador = FirebaseFirestore.instance.collection('Registro-Oradores');
  Reference fotoRef = FirebaseStorage.instance.ref();
  ImagePicker pickerFoto = ImagePicker();
  File? foto;

  // Informacoes.
  String? fotoUrl = '';
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController notaBiografica = TextEditingController();
  bool emAndamento = false; // Indica se o registro esta em andamento na base de dados.


  /*  Metodo para o orador tirar uma foto.  */
  Future tirarFoto() async {
    try {
      // Tirando a foto.
      final foto = await pickerFoto.pickImage(source: ImageSource.camera);
      if (foto == null) return;
      final file = File(foto.path);

      setState(() { this.foto = file; });
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$erro')));
    }
  }

  /*  Metodo para registrar as informacoes do orador na base de dados.  */
  Future registrarInformacoes() async {
    // Nomeando a foto.
    String fotoNome = "${DateTime.now().millisecondsSinceEpoch}_${nome.text.trim()}";
    Reference fotoDir = fotoRef.child('Foto-Oradores');
    Reference imgUpload = fotoDir.child(fotoNome);

    try {
      if ((foto != null) && (nome.text.isNotEmpty) && (email.text.isNotEmpty) && (senha.text.isNotEmpty) && (telefone.text.isNotEmpty) && (notaBiografica.text.isNotEmpty)) {
        var info = await infoOrador.where('email', isEqualTo: email.text).get();

        // Verifica se o email nao existe na base de dados.
        if (info.size == 0) {
          // Transfere a foto para a base de dados.
          await imgUpload.putFile(File(foto!.path));
          fotoUrl = await imgUpload.getDownloadURL();

          // Registrando o orador na base de dados.
          infoOrador.add({
            'foto_url': fotoUrl,
            'nome': nome.text,
            'email': email.text,
            'senha': senha.text,
            'telefone': telefone.text,
            'nota_biografica': notaBiografica.text,
          });

          // Mensagem.
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text('Operação Concluída!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              content: const Text('As informações do orador foram registradas com sucesso na base de dados.', textAlign: TextAlign.justify),
              actions: [
                TextButton(
                  onPressed: () { Navigator.pop(context); },
                  child: const Text('CONFIRMAR', style: styleBold),
                ),
              ],
            );
          });

          // Limpando os campos.
          setState(() {
            foto = null;
            fotoUrl = '';
            nome.text = "";
            email.text = "";
            senha.text = "";
            telefone.text = "";
            notaBiografica.text = "";
            emAndamento = false; // Reseta a variavel.
          });
        }
        else {
          setState(() { emAndamento = false; });  // Indica que as informacoes nao foram registradas ainda.
          // Mensagem.
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('O email já se encontra cadastrado em nossa base de dados. Por favor informe outro email.')));
          return const Center(child: CircularProgressIndicator(value: 1));
        }
      }
      else {
        setState(() { emAndamento = false; });  // Indica que as informacoes nao foram registradas ainda.
        // Mensagem.
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Os campos não podem estar vazios.')));
        return const Center(child: CircularProgressIndicator(value: 1));
      }
    } catch (erro) {
      setState(() { emAndamento = false; });  // Indica que as informacoes nao foram registradas ainda.
      //Mensagem.
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('Erro ao Concluir Operação!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: Text('Ocorreu um erro ao tentar registrar as informações do orador na base de dados. $erro', textAlign: TextAlign.justify,),
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
        title: const Text('REGISTRO DE ORADOR', style: styleBold),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  color: Colors.white70,
                  child: foto != null ? Image.file(foto!) : const Icon(Icons.account_circle, color: Colors.blueGrey),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent, minimumSize: const Size(95, 30)),
                onPressed: (){
                  tirarFoto();
                },
                child: const Icon(Icons.linked_camera, size: 15),
              ),
            ],
          ),
          TextField(
            controller: nome,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Nome'),
            style: styleBold,
          ),
          TextField(
            controller: email,
            maxLength: 250,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            style: styleBold,
          ),
          TextField(
            controller: senha,
            obscureText: true,
            maxLength: 8,
            decoration: const InputDecoration(labelText: 'Senha'),
            style: styleBold,
          ),
          TextField(
            controller: telefone,
            maxLength: 25,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Telefone'),
            style: styleBold,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: TextField(
              controller: notaBiografica,
              maxLength: 500,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Nota Biográfica',
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
            onPressed: (){
              // Verifica se algum registro ja esta em andamento.
              if (emAndamento == false) {
                setState(() { emAndamento = true; }); // Muda o estado da variavel.
                registrarInformacoes();
              }
              else {  // Mensagem.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('As informações estão em processo de registro. Aguarde alguns instantes...')));
              }
            },
            child: const Text('SALVAR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}