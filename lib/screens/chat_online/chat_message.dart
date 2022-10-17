import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
    // Key? key,
    this.data,
    this.mine,
  ); /*  : super(key: key) */

  final Map<String, dynamic> data;
  late bool mine;
  late String usuario;

  bool changeFavorito = true;

/*   var collection = FirebaseFirestore.instance.collection('collection');
collection 
    .doc('foo_id') // <-- Doc ID where data should be updated.
    .update(newData); */

  @override
  Widget build(BuildContext context) {
    /*     thisWillAffectTheState() {
    affectedByStateChange = const Icon(Icons.thumb_up, color: Colors.blue);
  }

  thisWillAlsoAffectTheState() {
    affectedByStateChange = const Icon(Icons.favorite, color: Colors.red);
  } */

    //data['isLiked'] = changeFavorito;

    String isMe = data['uid'];
    if (isMe != "Xz36mzuQOIUVfDbUWjKuLFALD9G2") {
      mine = true;
    }

    Timestamp firebaseTimestamp = data['time'];
    var date = firebaseTimestamp.toDate();
    var dataFirestore = DateFormat('dd/MM, hh:mm a').format(date);

    return mine == true
        ? Container(
            margin: const EdgeInsets.only(
              left: 60,
            ),
            child: Card(
                elevation: 3,
                color: Colors.indigo[100],
                shadowColor: Colors.black,
                margin: const EdgeInsets.all(5),
                shape: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    borderSide:
                        BorderSide(color: Colors.indigo[900]!, width: 0.3)),
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 0, left: 10),
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            data['senderPhotoUrl'],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // quando envio imagem firebase cai somente no texto abaixo
                            data['imgUrl'] != null
                                ? Image.network(
                                    data['imgUrl'],
                                    width: 150,
                                  )
                                : Text(
                                    data['text'] ??
                                        "", //se for nulo data['imgUrl'], se não data['text']
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    dataFirestore,
                                    style: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  data['senderName'],
                                  style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      /*  MaterialButton(
                        onPressed: () {},
                        color: Colors.green,
                        textColor: Colors.black,
                        child: Icon(
                          Icons.check_rounded,
                          size: 20,
                        ),
                        padding: EdgeInsets.all(1),
                        shape: CircleBorder(),
                      ), */
                      IconButton(
                        icon: data['isLiked']
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        //check_circle_rounded // check_circle_outline_rounded
                        iconSize: 15.0,
                        color: data['isLiked'] ? Colors.red : Colors.grey,
                        onPressed: () {
                          /*   setState() {
                            data['isLiked'].index = changeFavorito;
                          } */
                          /*                   setState(() {
      changeFavorito = !changeFavorito;
    }); */
                          if (kDebugMode) {
                            print(changeFavorito);
                          }
                        },
                      ),
                    ]))),
          )
        : Container(
            margin: const EdgeInsets.only(
              right: 60,
            ),
            child: Card(
                elevation: 3,
                color: Colors.white70,
                shadowColor: Colors.black,
                margin: const EdgeInsets.all(5),
                shape: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    borderSide:
                        BorderSide(color: Colors.indigo[900]!, width: 0.3)),
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 10, left: 0),
                    child: Row(children: <Widget>[
                      IconButton(
                        icon: data['isLiked']
                            ? const Icon(Icons.favorite_border)
                            : const Icon(Icons.favorite),
                        //check_circle_rounded // check_circle_outline_rounded
                        iconSize: 15.0,
                        color: /* data['isLiked'] ? Colors.grey : */ Colors.red,
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // quando envio imagem firebase cai somente no texto abaixo
                            data['imgUrl'] != null
                                ? Image.network(
                                    data['imgUrl'],
                                    width: 150,
                                  )
                                : Text(
                                    data['text'] ??
                                        "", //se for nulo data['imgUrl'], se não data['text']
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 16),
                                  ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data['senderName'],
                                  style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    dataFirestore,
                                    style: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            data['senderPhotoUrl'],
                          ),
                        ),
                      ),
                    ]))),
          );
  }
}
