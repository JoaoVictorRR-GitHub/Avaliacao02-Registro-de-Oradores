import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pagina_informacoes.dart';


/*  Pagina para exibir uma lista com
*   os oradores cadastrados no evento.  */
class ListarOradores extends StatefulWidget {
  const ListarOradores({super.key});

  @override
  State<ListarOradores> createState() => _ListarOradoresState();
}

class _ListarOradoresState extends State<ListarOradores> {

  CollectionReference infoOradores = FirebaseFirestore.instance.collection('Registro-Oradores');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORADORES CADASTRADOS', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: StreamBuilder(
          stream: infoOradores.orderBy('nome').snapshots(), // Lista ordenada pelo campo nome.
          builder: (context, snap){
            if(snap.hasData){
              return ListView.builder(
                itemCount: snap.data!.docs.length,
                itemBuilder: (context, index){
                  DocumentSnapshot informacoes = snap.data!.docs[index];
                  return GestureDetector(
                    onTap: (){
                      // Abre a pagina que exibe as informacoes do orador.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExibirInformacoes(info: informacoes)));
                    },
                    child: Dismissible(
                      key: ValueKey(snap.data!.docs.elementAt(index)),
                      confirmDismiss: (confirmar) {
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text('Confirmação', style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold)),
                            content: const Text('Tem certeza que deseja deletar o registro desse orador.\n'
                                '\nTodos as informações serão deletadas da base de dados.', textAlign: TextAlign.justify),
                            actions: [
                              TextButton(
                                onPressed: (){ Navigator.pop(context, true); },
                                child: const Text('CONFIRMAR', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold)),
                              ),
                              TextButton(
                                onPressed: (){ Navigator.pop(context, false); },
                                child: const Text('CANCELAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          );
                        });
                      },
                      background: Container(
                        color: Colors.amberAccent,
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: const Icon(Icons.delete_forever_sharp, color: Colors.red, size: 50),
                      ),
                      secondaryBackground: Container(
                        color: Colors.amberAccent,
                        padding: const EdgeInsets.only(right: 15),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete_forever_sharp, color: Colors.red, size: 50),
                      ),
                      onDismissed: (direcao) {
                        infoOradores.doc(informacoes.id).delete();  // Deleta o registro do orador ao deslizar o card para algum lado.
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('O registro do orador foi deletado com sucesso.')));
                      },
                      child: Card(
                        color: Colors.black12,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          title: Text(informacoes['nome'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          leading: Image.network(informacoes['foto_url']),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(value: 1),
              );
            }},
        ),
      ),
    );
  }
}