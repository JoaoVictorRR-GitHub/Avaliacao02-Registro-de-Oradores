import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widgets_personalizados.dart';
import 'pagina_registro.dart';
import 'pagina_login.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}


/*  Pagina inicial do evento. */
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BEM VINDO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const CustomPainel(icone: Icons.account_balance_sharp, descricao: 'IPT EVENT'), // Painel personalizado.
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text("Registre-se agora como um orador do evento.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrarOrador()));
            },
            child: const Text('REGISTRAR-SE', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text("Ou realize login para conhecer outros oradores.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Entrar()));
            },
            child: const Text('ENTRAR', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}