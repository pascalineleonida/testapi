import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'animation/delayanimationup.dart'; // Importe la bibliothèque pour la conversion JSON

Future<void> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    // La requête a réussi
    print(response.body); // Affiche la réponse de l'API dans la console
    // Vous pouvez traiter les données ici
  } else {
    // La requête a échoué
    print('Échec de la requête : ${response.statusCode}');
  }
}

void main() {
  runApp(const MyApp());
}


 class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users =
      []; // Déclare une liste dynamique pour stocker les utilisateurs

  @override
  void initState() {
    super.initState();
    fetchUsers();


  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(
            response.body);
        // Convertit la réponse JSON en liste d'objets Dart
      });
    } else {
      print('Échec de la requête : ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap: () {

        },
            child: Text('Utilisateurs')),
      ),
      body: SingleChildScrollView(
        child: Column(children: users.map((e) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  DelayedAnimation(delay:  users.indexOf(e)*100,
                    child: SizedBox(
                      width: 400.0,
                      height: 60.0,
                      child: Shimmer.fromColors(direction: ShimmerDirection.ttb,
                        baseColor: Colors.black,
                        highlightColor: Colors.black,
                        child:  ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(),
                          title: Text(e['name'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15)),
                          subtitle: Text(e['email']),
                        ),
                      ),
                    ),
                  ),
                ],  // Affiche l'email de l'utilisateur en tant que sous-titre
              ),
            ),
            Divider(),
          ],
        )).toList(),),
      ),
    );
  }
}
