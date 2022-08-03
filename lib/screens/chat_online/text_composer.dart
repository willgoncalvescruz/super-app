import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(this.sendMessage, {Key? key}) : super(key: key);

  final Function({String? text, File? imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _controller = TextEditingController();

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          /* IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile = await ImagePicker()
                  .pickImage(source: ImageSource.camera)
                  .then((imgFile) {
                if (imgFile == null) return;
              }) as File;
              widget.sendMessage(imgFile: imgFile);
              /*  await openCamera();
              widget.sendMessage(imgFile: pickedFile); */
            },
          ), */
          Expanded(
            child: TextField(
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
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

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
