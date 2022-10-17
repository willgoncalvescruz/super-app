import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_app/screens/chat_online/chat_screen.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMessage, {Key? key}) : super(key: key);

  final Function({String? text, bool isLiked, XFile? imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();
  //selectFileCamera and UploadFirebase
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  //get urlDownload => uploadFile();

  final FirebaseStorage storage = FirebaseStorage.instance;

  List<Reference> refs = [];
  List<String> arquivos = [];

  /* Future uploadFile() async {
    final path =
        'files/img-${pickedFile!.name + DateTime.now().millisecondsSinceEpoch.toString()}.png';
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
  } */

  bool _isComposing = false;

  //get pickedFile => openCamera();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var inputDecorationEnviarMensagem = InputDecoration(
      fillColor: Colors.white24,
      filled: true,
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
    );
    var clipOvalSendMessage = ClipOval(
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
    );
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          SendImageWidget(widget: widget),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5, top: 5, bottom: 10),
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: false,
                style: TextStyle(fontSize: 16.0, color: Colors.indigo[900]!),
                controller: _controller,
                decoration: inputDecorationEnviarMensagem,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  widget.sendMessage(text: text);
                  //widget.sendMessage(text: imgFile;
                  //if (pickedFile != null) Center(child: Text(pickedFile!.name));
                  _reset();
                },
              ),
            ),
            //)
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: clipOvalSendMessage,
          ),
        ],
      ),
    );
  }
}

class SendImageWidget extends StatelessWidget {
  const SendImageWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TextComposer widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: IconButton(
        icon: const Icon(Icons.photo, size: 45),
        onPressed: () async {
          /* ////
          final imgFile = await FilePicker.platform.pickFiles();
          if (imgFile == null) return;
          setState(() {
            pickedFile = imgFile.files.first;
          });
          uploadFile();
          widget.sendMessage(imgFile: imgFile as XFile);
          //// */

          final ImagePicker picker = ImagePicker();
          XFile? imgFile = await picker.pickImage(source: ImageSource.gallery);
          if (kDebugMode) {
            print('#### imgFile RECUPERADA => $imgFile');
          }
          if (imgFile == null) return;
          widget.sendMessage(imgFile: imgFile);
        },
      ),
    );
  }
}

Widget buildProgress(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        return SizedBox(
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white,
                  color: Colors.blue,
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
