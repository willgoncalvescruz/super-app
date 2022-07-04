import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
//import 'package:super_app/screens/agenda_contatos/ui/agendacontato.dart';
//import 'package:super_app/screens/agenda_contatos/ui/agendacontato.dart';
import 'package:super_app/screens/buscadorgifs.dart';
import 'package:super_app/screens/conversor.dart';
import 'package:super_app/screens/imc.dart';
import 'package:super_app/screens/lista.dart';
import 'package:super_app/screens/testeresponsivo.dart';

class HomeSuperApps extends StatelessWidget {
  const HomeSuperApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperApps',
      //theme: ThemeGenerator.themeDataGenerator,
      routes: {
        '/': (context) => const MyHomePage(),
        '/SplashScreenHomeImc': (context) => const SplashScreenHomeImc(),
        '/SplashScreenHomeConversor': (context) =>
            const SplashScreenHomeConversor(),
        '/SplashScreenListaTarefas': (context) =>
            const SplashScreenListaTarefas(),
        '/SplashScreenBuscadorGIFs': (context) =>
            const SplashScreenBuscadorGIFs(),
        /* '/SplashScreenHomeAgendaContatos': (context) =>
            const SplashScreenHomeAgendaContatos(), */
        '/TesteResponsivo': (context) => const TesteResponsivo(),
      },
    );
  }
}

class SecondCategory extends StatelessWidget {
  const SecondCategory({Key? key}) : super(key: key);

  //const SecondCategory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}

class FeatureTestItem {
  final String featureName;
  final String group;
  final String route;

  FeatureTestItem(this.featureName, this.group, this.route);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: prefer_final_fields
  List<FeatureTestItem> _elements = [
    FeatureTestItem('App-Imc', '1', '/SplashScreenHomeImc'),
    FeatureTestItem('App-Conversor', '2', '/SplashScreenHomeConversor'),
    FeatureTestItem('App-Lista', '3', '/SplashScreenListaTarefas'),
    FeatureTestItem('App-Gifs', '4', '/SplashScreenBuscadorGIFs'),
    FeatureTestItem(
        'App-Agenda-Contatos', '5', '/SplashScreenHomeAgendaContatos'),
    FeatureTestItem('Teste-Responviso', '6', '/TesteResponsivo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home - SuperApps"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: GroupedListView<FeatureTestItem, String>(
        elements: _elements,
        groupBy: (element) => element.group,
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1.featureName.compareTo(item2.featureName),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: false,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (context, element) {
          return Card(
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(width: 2, color: Colors.black12),
            ),
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, element.route);
              },
              //elevation: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                height: 150.0,
                child: generateDummyCardContent(element),
              ),
            ),
          );
        },
      ),
    );
  }

  Row generateDummyCardContent(FeatureTestItem element) {
    var imageSize = 100.0;
    var newRow1 = SizedBox(
      height: imageSize,
      width: imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize / 2),
        child: Image.asset(
          "assets/images/apps.png",
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );

    var newRow2 = Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      element.featureName,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    element.route,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Row(
      children: <Widget>[
        newRow1,
        const SizedBox(
          width: 10,
        ),
        newRow2,
      ],
    );
  }
}
