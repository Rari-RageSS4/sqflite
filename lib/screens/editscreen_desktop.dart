import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_db/db/functions/db_functions.dart';
import 'package:sqflite_db/screens/profilescreen_desktop.dart';
import '../../../db/model/data_model.dart';

class EditscreenDesktop extends StatefulWidget {
  final StudentModel data;
  final int index;
  const EditscreenDesktop({super.key, required this.data, required this.index});

  @override
  State<EditscreenDesktop> createState() => _EditscreenDesktopState();
}

class _EditscreenDesktopState extends State<EditscreenDesktop> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String _picture = '';

  @override
  void initState() {
    _nameController.text = widget.data.name.toString();
    _ageController.text = widget.data.age.toString();
    _placeController.text = widget.data.branch.toString();
    _phoneController.text = widget.data.phoneNumber.toString();
    //_picture = widget.data.imagePath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(255, 169, 63, 255),
        title: const Text('Edit details',
        style: TextStyle(
            color: Colors.white,
            fontSize: 28
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              imageProfile(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width<=1100? 180: 380, vertical: 21 ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Full name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter full name';
                        } else if (value.length < 3) {
                          return 'Name must be at least 3 character';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your age';
                        } else if (value.length > 2) {
                          return 'Enter a valid age';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _placeController,
                      decoration: const InputDecoration(
                        hintText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your place';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Phone number';
                          } else if (value.length != 10) {
                            return 'Enter a valid phone number';
                          } else {
                            return null;
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateButton();
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update Student'))
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> updateButton() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final branch = _placeController.text.trim();
    final phone = _phoneController.text.trim();
   // final image = _picture;

    if (name.isEmpty ||
        age.isEmpty ||
        branch.isEmpty ||
        phone.isEmpty) {
      return;
    } else {
      final studentData = StudentModel(
        id: widget.index,
        name: name,
        age: age,
        branch: branch,
        phoneNumber: phone,
       // imagePath: image,
      );
      DBFunctions.instance.updateStudent(studentData: studentData);
      DBFunctions.instance.getAllStudents();
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilescreenDesktop(
            data: studentData,
            index: widget.index,
          ),
        ),
      );
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose your photo',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.gallery, context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: () {
                    acceptImage(ImageSource.camera, context);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'))
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: FileImage(File(_picture)),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ))
        ],
      ),
    );
  }

Future<void>  acceptImage(ImageSource source, context) async {
    final receiveImage = await _picker.pickImage(source: source);
    if (receiveImage == null) {
      return;
    } else {
      final pictureFile = File(receiveImage.path);
      setState(() {
        _picture = pictureFile.path;
      });
      Navigator.of(context).pop();
    }
  }
}