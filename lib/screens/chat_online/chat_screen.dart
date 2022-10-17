import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_app/screens/chat_online/chat_message.dart';
import 'package:super_app/screens/chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User? currentUser;
  bool _isLoading = false;

  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;
  bool uploading = false;
  double total = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  Future<User?> _getUser() async {
    if (currentUser != null) {
      return currentUser;
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

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = authResult.user!;
      return user;
    } catch (error) {
      return null;
    }
  }

  void _sendMessage({String? text, isLiked, XFile? imgFile}) async {
    final User? user = await _getUser();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faça seu login e Tente novamente!',
            textAlign: TextAlign.center),
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

    //###################################################################//
    if (imgFile != null) {
      XFile? file = await getImage();
      if (file != null) {
        UploadTask task = await upload(file.path);

        task.snapshotEvents.listen(
          (TaskSnapshot snapshot) async {
            if (snapshot.state == TaskState.running) {
              setState(() {
                _isLoading = true;
                total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
              });
            } else if (snapshot.state == TaskState.success) {
              final photoRef = snapshot.ref;
              arquivos.add(await photoRef.getDownloadURL());
              refs.add(photoRef);
              String url = await photoRef.getDownloadURL();
              //não deu certo passar o data aqui pois não chega imgUrl do firestore no chat.
              data['imgUrl'] = url;
              //String urlDownload = url;
              if (kDebugMode) {
                print(/* '#### data[\'imgUrl\'] = url =>  */ data['imgUrl']);
                //data['imgUrl'] = url;
              }
              setState(() => _isLoading = false);
            }
          },
        );
      }
      //data['imgUrl'] = url;
/*       if (kDebugMode) {
        print(urlDownload);
      } */

/*       data['imgUrl'] = url;
      if (kDebugMode) {
        print("INICIO - data['imgUrl']");
        print(data['imgUrl']);
        print("FIM - data['imgUrl']");
      } */
    }
    if (text != null) data['text'] = text;
    data['isLiked'] = false;
    /*    imgFile != null
        ? data['imgUrl'] = "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA11Er3V.img?w=82&h=82&q=120&m=6&f=png&u=t"
        : data['text'] = text; */
/*     imgFile != null
        ? data['imgUrl'] = //url
            "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA11Er3V.img?w=82&h=82&q=120&m=6&f=png&u=t" //chumbado trocar por "ulr"
        : data['text'] = text;
    data['isLiked'] = isLiked; */
/*     data['imgUrl'] =
        "https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA11Er3V.img?w=82&h=82&q=120&m=6&f=png&u=t"; */

    //data['text'] = text;
    FirebaseFirestore.instance.collection('messages').add(data);
    //###################################################################//

    /*       //StorageUploadTask
    //UploadTask task = FirebaseStorage.instance.ref().child(user.uid + DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
      setState(() {
        _isLoading = true;
      });

     //TaskSnapshot taskSnapshot = task.snapshot;
      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;

      setState(() {
        _isLoading = false;
      }); */
  }

  void _loginUser() async {
    final User? user = await _getUser();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faça seu login e Tente novamente!',
            textAlign: TextAlign.center),
        backgroundColor: Colors.orange,
        //duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Login realizado com sucesso!', textAlign: TextAlign.center),
        //backgroundColor: Colors.grey,
        //duration: Duration(seconds: 3),
      ));
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text(
            currentUser != null
                ? 'Olá, ${currentUser?.displayName} - Online'
                : 'Chat-App - Offline',
          ),
          leading: currentUser == null
              ? IconButton(
                  icon: const Icon(Icons.assignment_ind),
                  tooltip: 'Fazer login com o Google',
                  onPressed: () {
                    _loginUser();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  tooltip: 'Fazer logout', //exit_to_app
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    googleSignIn.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Você saiu da conta Google!',
                          textAlign: TextAlign.center),
                    ));
                  },
                ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            currentUser != null
                ? IconButton(
                    icon: const Icon(Icons.wifi_rounded),
                    tooltip: 'Você está Online',
                    onPressed: () {})
                : IconButton(
                    icon: const Icon(Icons.wifi_off_rounded),
                    tooltip: 'Você está Offline',
                    onPressed: () {}),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: const ExactAssetImage('assets/images/chat.png'),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                      350,
                      50.0,
                    ),
                    bottomRight: Radius.elliptical(
                      350,
                      50.0,
                    ),
                  ),
                ),
              ),
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
                                documents[index].data() == currentUser?.uid,
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
      ),
    );
  }
}

/* class Todo {
  final String title;
  const Todo(this.title);
}

final todos = List.generate(
  5,
  (i) => Todo(
    'Todo $i',
  ),
);
 */
Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (kDebugMode) {
    print('#### 1 getImage => $image');
  }
  return image;
}

Future<UploadTask> upload(String path) async {
  File file = File(path);
  PlatformFile? pickedFile;
  try {
    String ref =
        'files/img-${DateTime.now().millisecondsSinceEpoch.toString()}.jpeg';
    /* String ref =
        'files/img-${pickedFile!.name + DateTime.now().millisecondsSinceEpoch.toString()}.png';
 */
    final storageRef = FirebaseStorage.instance.ref();
    if (kDebugMode) {
      print('#### 2 upload => $ref');
    }
    return storageRef.child(ref).putFile(
          file,
          SettableMetadata(
            cacheControl: "public, max-age=300",
            contentType: "image/jpg",
            customMetadata: {
              "user": "123",
            },
          ),
        );
  } on FirebaseException catch (e) {
    throw Exception('Erro no upload: ${e.code}');
  }
}
