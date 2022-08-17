import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
    /* Future uploadFile() async {
      PlatformFile? pickedFile;
      UploadTask? uploadTask;
      final path =
          'files/${pickedFile!.name + DateTime.now().millisecondsSinceEpoch.toString()}';
      final file = File(pickedFile.path!);
      //child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      data['imgUrl'] = urlDownload;
      if (kDebugMode) {
        print('#####Dowload Link: => $urlDownload');
      }
      setState(() {
        uploadTask = null;
      });
    } */

    if (imgFile != null) {
      //uploadFile();
      //StorageUploadTask
      //UploadTask task = FirebaseStorage.instance.ref().child(user.uid + DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
      /*      PlatformFile? pickedFile;
      UploadTask? uploadTask; */

      // upload
/* 
      PlatformFile? pickedFile;
      UploadTask? uploadTask;
      final path =
          'files/${pickedFile!.name + DateTime.now().millisecondsSinceEpoch.toString()}';
      final file = File(pickedFile.path!);
      //child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      data['imgUrl'] = urlDownload;
      if (kDebugMode) {
        print('#####Dowload Link: => $urlDownload');
      }
      setState(() {
        uploadTask = null;
      }); */
      // upload

    }

    //if (text != null) data['text'] = text;
    data['text'] = text;

    FirebaseFirestore.instance.collection('messages').add(data);
  }

  void _loginUser() async {
    final User? user = await _getUser();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Faça seu login e Tente novamente!',
            textAlign: TextAlign.center),
        backgroundColor: Colors.red,
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
            _currentUser != null
                ? 'Olá, ${_currentUser?.displayName} - Online'
                : 'Chat-App - Offline',
          ),
          leading: _currentUser == null
              ? IconButton(
                  icon: const Icon(Icons.assignment_ind),
                  tooltip: 'Fazer login com o Google',
                  onPressed: () {
                    _loginUser();
                  },
                )
              : Container(),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            _currentUser != null
                ? IconButton(
                    icon: const Icon(Icons.logout_outlined), //exit_to_app
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      googleSignIn.signOut();
                      //_scaffoldKey.currentState.showSnackBar(SnackBar(
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você saiu da conta Google!',
                            textAlign: TextAlign.center),
                      ));
                    },
                  )
                : Container()
          ],
        ),
        body: Container(
          //color: Colors.yellow[100],
          decoration: BoxDecoration(
            color: Colors.blue[100],
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: const ExactAssetImage('assets/images/chat.png'),
            ),
          ),
          child: Column(
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
      ),
    );
  }
}
