import 'dart:io';

import 'package:super_app/screens/chat_online/chat_message.dart';
import 'package:super_app/screens/chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<User?> _getUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

//      final AuthResult authResult =
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //final FirebaseUser user = authResult.user;
      final User user = authResult.user!;
      return user;
    } catch (error) {
      return null;
    }
  }

  void _sendMessage({String? text, File? imgFile}) async {
    final User? user = await _getUser();

    if (user == null) {
//      _scaffoldKey.currentState.showSnackBar(SnackBar(
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível fazer o login. Tente novamente!'),
        backgroundColor: Colors.red,
        //duration: Duration(seconds: 3),
      ));
    }

    Map<String, dynamic> data = {
      "uid": user!.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoURL,
      "time": Timestamp.now(),
    };

    if (imgFile != null) {
      //StorageUploadTask
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);
      setState(() {
        _isLoading = true;
      });
      if (kDebugMode) {
        print("####PRINT UploadTask => $task");
      }
      /* FirebaseStorage task = FirebaseStorage.instance;
      Reference ref = task
          .ref()
          .child(user.uid + DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(File(imgFile.path));
      setState(() {
        _isLoading = true;
      });
      String imageUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print("####PRINT UploadTask ImageUrl=> $imageUrl");
      } */
      //
//StorageTaksSnapshot
      //TaskSnapshot taskSnapshot = task.snapshot;
      TaskSnapshot taskSnapshot = task.snapshot;
      final url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
      if (kDebugMode) {
        print("####PRINT TaskSnapshot => $url");
      }
      setState(() {
        _isLoading = false;
      });
      /* UploadTask task = FirebaseStorage.instance
          .ref()
          .child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imgFile);

      setState(() {
        _isLoading = true;
      });

      TaskSnapshot taskSnapshot = (task.snapshot.state) as TaskSnapshot;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
      if (kDebugMode) {
        print("####PRINT TaskSnapshot => $url");
      } */
      //String imageUrl = url;
      /*    if (kDebugMode) {
        print("####PRINT UploadTask ImageUrl=> $imageUrl");
      } */

      //upload and get download url
/*   Reference ref = FirebaseStorage.instance.ref().child(user.uid + DateTime.now().millisecondsSinceEpoch.toString());//generate a unique name
  await ref.putFile(File(imgFile.path));//you need to add path here  
  final imageUrl = await ref.getDownloadURL();
  data['imgUrl'] = imageUrl;
if (kDebugMode) {
        print("####PRINT UploadTask ImageUrl=> $imageUrl");
      }
      //upload final
           setState(() {
        _isLoading = false;
      }); */
    }

    //if (text != null) data['text'] = text;
    data['text'] = text;

    FirebaseFirestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text(
            _currentUser != null
                ? 'Olá, ${_currentUser?.displayName}'
                : 'Chat App - Você está Offline',
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            _currentUser != null
                ? IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      googleSignIn.signOut();
                      //_scaffoldKey.currentState.showSnackBar(SnackBar(
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você saiu com sucesso!'),
                      ));
                    },
                  )
                : Container()
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data!.docs.reversed.toList();

                      return ListView.builder(
                          itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return ChatMessage(
                              documents[index].data() as Map<String, dynamic>,
                              documents[index].data() == _currentUser?.uid,
                            );
                          });
                  }
                },
              ),
            ),
            _isLoading ? const LinearProgressIndicator() : Container(),
            TextComposer(_sendMessage),
          ],
        ),
      ),
    );
  }
}



//return uploadingData('productName', 'productPrice', 'imageUrl');
/*   FirebaseFirestore.instance
      .collection("rooms")
      .doc("roomA")
      .collection("messages")
      .doc("message1"); */
//  FirebaseFirestore.instance.collection("col").doc("doc");

/* uploadingData(
    String productName, String productPrice, String imageUrl) async {
  await FirebaseFirestore.instance.collection("products").add({
    'productName': 'produto1',
    'productPrice': '10',
    'imageUrl': 'produto.jpg'
  });
} */