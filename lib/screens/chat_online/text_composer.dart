import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';

//ja fiz seleção da imagem na paste e upload no firebase
//pendente para terminar
// incluir data['imgUrl'] = url;
// _isLoading = false;
//incluir imagem no "widget.sendMessage(imgFile: imgFile)"";

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMessage, {Key? key}) : super(key: key);

  final Function({String? text, File? imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();
  //selectFileCamera and UploadFirebase
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path =
        'files/${pickedFile!.name + DateTime.now().millisecondsSinceEpoch.toString()}';
    final file = File(pickedFile!.path!);
    //child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    //data['imgUrl'] = urlDownload;
    if (kDebugMode) {
      print('#####Dowload Link: => $urlDownload');
    }
    setState(() {
      uploadTask = null;
    });
  }

/*   Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  } */
  //end selectedFileCamera

  bool _isComposing = false;

/*   get _currentUser => User;
  get googleSignIn => GoogleSignIn; */

  //get pickedFile => openCamera();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var teste = _getUserMensagem.toString();
/*     if (kDebugMode) {
      print("#### teste => $teste");
    } */
/*     var material = const Material();
    Color c1 = const Color(0x00ffffff); */

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 15),
            child: IconButton(
              icon: const Icon(Icons.photo, size: 45),
              onPressed: () async {
                //selectFileInit
                final imgFile = await FilePicker.platform.pickFiles();
                if (imgFile == null) return;
                setState(() {
                  pickedFile = imgFile.files.first;
                });
                //selectFileEnd
                uploadFile();
                //widget.sendMessage(imgFile: imgFile);
              },
            ),
          ),
          /* IconButton(
            icon: const Icon(Icons.photo_camera), //
            onPressed: () async {
              //buildProgress();
              /* final File imgFile = await ImagePicker()
                  .pickImage(source: ImageSource.camera)
                  .then((imgFile) {
                if (imgFile == null) return;
              }) as File; 
              widget.sendMessage(imgFile: imgFile);*/

              /*  await openCamera();
              widget.sendMessage(imgFile: pickedFile); */
            },
          ), */
          Expanded(
            child: /* TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'Enviar uma Mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
            ), */
                Padding(
              padding: const EdgeInsets.only(right: 5, top: 5, bottom: 10),
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: false,
                style: TextStyle(fontSize: 16.0, color: Colors.indigo[900]!),
                controller: _controller,
                decoration: InputDecoration(
                  fillColor: Colors.white24,
                  filled: true,
                  /* prefixIcon: Icon(
                    Icons.message_outlined,
                    color: Colors.indigo[900]!,
                  ), */
                  /* suffixIcon: Icon(
                    Icons.message_outlined,
                    color: Colors.indigo[900]!,
                  ), */
                  hintText: ('Enviar mensagem'),
                  contentPadding: const EdgeInsets.all(17),
                  suffixStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo[900]!),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo[900]!),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo[900]!),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  widget.sendMessage(text: text);
                  //if (pickedFile != null) Center(child: Text(pickedFile!.name));
                  _reset();
                },
              ),
            ),
            //)
            /* Column(
              children: [
                if (teste != null) ...[
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enviar uma Mensagem'),
                    onChanged: (text) {
                      setState(() {
                        _isComposing = text.isNotEmpty;
                      });
                    },
                    onSubmitted: (text) {
                      widget.sendMessage(text: text);
                      _reset();
                    },
                  ),
                ] else if (teste == null) ...[
                  const TextField(
                    enabled: false,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Faça Login para Enviar uma Mensagem'),
                  ),
                ],
              ],
            ), */
          ),
          /* IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () async {
              final File imgFile = await ImagePicker()
                  .pickImage(source: ImageSource.gallery)
                  .then((imgFile) {
                if (imgFile == null) return;
              }) as File;
              widget.sendMessage(imgFile: imgFile);
              /*  await openCamera();
              widget.sendMessage(imgFile: pickedFile); */
            },
          ), */

          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: ClipOval(
              child: Material(
                color: Colors.indigo[900],
                child: InkWell(
                  splashColor: Colors.white54,
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: _isComposing
                          ? () {
                              widget.sendMessage(text: _controller.text);
                              _reset();
                            }
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /* IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          ), */
        ],
      ),
    );
  }
}

//Widget buildProgress() => StreamBuilder<TaskSnapshot>(
Widget buildProgress(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                    child: Text(
                  '${(100 * progress).roundToDouble()}%',
                  style: const TextStyle(color: Colors.white, fontSize: 5),
                ))
              ],
            ));
      } else {
        return const SizedBox(height: 50);
      }
    });

/* Future<XFile?> openCamera() async {
/*   File _image;
  final picker = ImagePicker(); */

  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  //print('PickedFile: ${pickedFile.toString()}');
  if (pickedFile == null) {
    return null;
  }
  return pickedFile;
/*     setState(() {
      _image = File(pickedFile.path); // Exception occurred here
    }); */
  /*    if (_image != null) {
      return _image;
    } */
} */
