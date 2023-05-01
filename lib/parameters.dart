import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe

void main() {
  runApp(const MyParameters());
}

class MyParameters extends StatelessWidget {
  const MyParameters({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyParametersPage(title: "Paramètres");
    /*return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'RobotoSerif',
          primaryColor: const Color.fromRGBO(61, 110, 201, 1.0),
        ),
        home: const MyParametersPage(
          title: "Paramètres",
        ));*/
  }
}

class MyParametersPage extends StatefulWidget {
  const MyParametersPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyParametersPage> createState() => _MyParametersPageState();
}

class MyListTile extends StatelessWidget {
  const MyListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.settings,
        color: Color.fromRGBO(16, 43, 64, 1),
      ),
      title: const Text(
        'Paramètres du compte',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        // Ajoutez le code pour traiter l'option 1 ici.
      },
    );
  }
}

class _MyParametersPageState extends State<MyParametersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
        backgroundColor: const Color.fromRGBO(61, 110, 201, 1.0),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 15.0),
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                'Pseudo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          'Pseudo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0,
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Padding(
                            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            child: TextField(
                              style: TextStyle(
                                color: Color.fromRGBO(16, 43, 64, 1),
                              ),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Nouveau pseudo',
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                hintText: 'Entrer votre nouveau pseudo',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Confirmer',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(
              indent: 80,
              height: 15,
              thickness: 0.7,
              color: Color.fromRGBO(16, 43, 64, 0.4),
            ),
            ListTile(
              leading: const Icon(
                Icons.email,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0,
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Padding(
                            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            child: TextField(
                              style: TextStyle(
                                color: Color.fromRGBO(16, 43, 64, 1),
                              ),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                //border: OutlineInputBorder(),
                                labelText: 'Nouvel email',
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                hintText: 'Entrer votre nouvel email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Confirmer',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(
              indent: 80,
              height: 15,
              thickness: 0.7,
              color: Color.fromRGBO(16, 43, 64, 0.4),
            ),
            ListTile(
              leading: const Icon(
                Icons.password,
                color: Color.fromRGBO(16, 43, 64, 1),
              ),
              title: const Text(
                'Mot de passe',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          'Mot de passe',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0,
                            color: Color.fromRGBO(61, 110, 201, 1.0),
                          ),
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Padding(
                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 15),
                              child: TextField(
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.password,
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  //border: OutlineInputBorder(),
                                  labelText: 'Actuel mot de passe',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  hintText: 'Entrer votre mot de passe',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 15),
                              child: TextField(
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.password,
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  //border: OutlineInputBorder(),
                                  labelText: 'Nouveau mot de passe',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  hintText: 'Entrer votre nouveau mot de passe',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 30),
                              child: TextField(
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 43, 64, 1),
                                ),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.password,
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  //border: OutlineInputBorder(),
                                  labelText: 'Confirmer mot de passe',
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(16, 43, 64, 1),
                                  ),
                                  hintText:
                                      'Confirmer votre nouveau mot de passe',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Confirmer',
                            style: TextStyle(
                              color: Color.fromRGBO(61, 110, 201, 1.0),
                            ),
                          ),
                          onPressed: () {
                            // code à exécuter lorsque l'utilisateur clique sur le bouton Rechercher
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(
              indent: 80,
              height: 15,
              thickness: 0.7,
              color: Color.fromRGBO(16, 43, 64, 0.4),
            ),
            const ListTile(),

            // Ajoutez autant d'options que nécessaire...
          ],
        ),
      ),
    );
  }
}
