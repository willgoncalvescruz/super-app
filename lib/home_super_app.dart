import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:super_app/screens/agenda_contatos/ui/agendacontato.dart';
import 'package:super_app/screens/buscadorgifs.dart';
import 'package:super_app/screens/chat_online/chat_online.dart';
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
        '/SplashScreenHomeAgendaContatos': (context) =>
            const SplashScreenHomeAgendaContatos(),
        '/SplashScreenHomeChatOnline': (context) =>
            const SplashScreenHomeChatOnline(),
        '/TesteResponsivo': (context) => const TesteResponsivo(),
      },
    );
  }
}

class SecondCategory extends StatelessWidget {
  const SecondCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}

class FeatureTestItem {
  final String featureName;
  final String group;
  final String route;
  final String logoApp;

  FeatureTestItem(this.featureName, this.group, this.route, this.logoApp);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<FeatureTestItem> _elements = [
    FeatureTestItem('App-Calculo de Imc', '1', '/SplashScreenHomeImc',
        'assets/images/imc.png'),
    FeatureTestItem('App-Conversor de Moedas', '2',
        '/SplashScreenHomeConversor', 'assets/images/conversor.png'),
    FeatureTestItem('App-Lista de Tarefas', '3', '/SplashScreenListaTarefas',
        'assets/images/lista.png'),
    FeatureTestItem('App-Buscador de Gifs', '4', '/SplashScreenBuscadorGIFs',
        'assets/images/gif.png'),
    FeatureTestItem('App-Agenda de Contatos', '5',
        '/SplashScreenHomeAgendaContatos', 'assets/images/contato.png'),
    FeatureTestItem('App-Chat Online', '6', '/SplashScreenHomeChatOnline',
        'assets/images/chatonline.png'),
    FeatureTestItem('App-Teste Responsividade', '7', '/TesteResponsivo',
        'assets/images/apps.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super-App"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: GroupedListView<FeatureTestItem, String>(
          elements: _elements,
          groupBy: (element) => element.group,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1.featureName.compareTo(item2.featureName),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: false,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (context, element) {
            return Card(
              color: Colors.orange[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(width: 3, color: Colors.red),
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
          element.logoApp,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Text(
                      element.featureName,
                      style: const TextStyle(fontSize: 16),
                    ),
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
