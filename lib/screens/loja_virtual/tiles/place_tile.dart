import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const PlaceTile(this.snapshot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot["title"],
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  snapshot["address"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    "Ver no Mapa",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  /*  textColor: Colors.blue,
                  padding: EdgeInsets.zero, */
                  onPressed: () async {
                    /*                    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.google.com/maps/search/?api=1&query=${snapshot["lat"]},${snapshot["long"]}', path: 'headers/');
         */ /* String urlMap = "https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},${snapshot["long"]}";
                    launchUrl(urlMap); */
                    //Future<void> _launchUrl() async {
                    final Uri url = Uri.parse(
                        "https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},"
                        "${snapshot["long"]}");
                    if (!await launchUrl(url)) {
                      throw 'Could not launch $url';
                    }
                    //  }
                    /*          launch(
                        "https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},"
                        "${snapshot["long"]}"); */
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    "Ligar",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  /*     textColor: Colors.blue,
                  padding: EdgeInsets.zero, */
                  onPressed: () {
                    launch("tel:${snapshot["phone"]}");
                    canLaunchUrl(Uri(
                            scheme: 'tel:${snapshot["phone"]}', path: '123'))
                        .then((bool result) {
                      /*   setState(() {
        _hasCallSupport = result;
      }); */
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
