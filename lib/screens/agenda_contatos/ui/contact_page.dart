import 'dart:io';

import "package:flutter/material.dart";

import 'package:image_picker/image_picker.dart';
import 'package:super_app/screens/agenda_contatos/ui/agendacontato.dart';
import 'package:super_app/screens/agenda_contatos/ui/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage({Key? key, this.contact}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editedContact;
  bool _userEdited = false;

  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _phoneControler = TextEditingController();

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());
      _nameControler.text = _editedContact!.name!;
      _emailControler.text = _editedContact!.email!;
      _phoneControler.text = _editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(_editedContact!.name ?? "Criar Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedContact!.name != null &&
                _editedContact!.name!.isNotEmpty &&
                _editedContact!.email!.isNotEmpty &&
                _editedContact!.phone!.isNotEmpty) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact!.img != null
                          ? FileImage(File(_editedContact!.img!))
                          : const AssetImage("assets/images/contato.png")
                              as ImageProvider,
                    ),
                  ),
                ),
                onTap: () {
                  ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) {
                      return;
                    }
                    setState(() {
                      _editedContact!.img = file.path;
                    });
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                    onPressed: () {
                      ImagePicker()
                          .pickImage(source: ImageSource.gallery)
                          .then((file) {
                        if (file == null) {
                          return;
                        }
                        setState(() {
                          _editedContact!.img = file.path;
                        });
                      });
                    },
                    child: const Icon(
                      Icons.image_search,
                      size: 35,
                      color: Colors.red,
                    ), //const Text('Galeria'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                    onPressed: () {
                      ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((file) {
                        if (file == null) {
                          return;
                        }
                        setState(() {
                          _editedContact!.img = file.path;
                        });
                      });
                    },
                    child: const Icon(
                      Icons.camera_alt,
                      size: 35,
                      color: Colors.red,
                    ),
                    //const Text('Camera'),
                  ),
                ],
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                    color: Colors.white, //font color
                    backgroundColor: Colors.transparent,
                    fontStyle: FontStyle.normal),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Nome",
                  //fillColor: Colors.white,
                  //filled: true,
                ),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact!.name = text;
                  });
                },
                controller: _nameControler,
                focusNode: _nameFocus,
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                    color: Colors.white, //font color
                    backgroundColor: Colors.transparent,
                    fontStyle: FontStyle.normal),
                decoration: const InputDecoration(labelText: "E-mail"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.email = text;
                },
                controller: _emailControler,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                style: const TextStyle(
                    fontSize: 20,
                    height: 2,
                    color: Colors.white, //font color
                    backgroundColor: Colors.transparent,
                    fontStyle: FontStyle.normal),
                decoration: const InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.phone = text;
                },
                controller: _phoneControler,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Descartar alterações?"),
              content: const Text("Se sair, as alterações serão perdidas!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    //Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SplashScreenHomeAgendaContatos()));
                  },
                  child: const Text("Sim"),
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
