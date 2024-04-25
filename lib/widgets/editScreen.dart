import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../models/employees.dart';
import 'listScreen.dart';

class EditScreen extends StatefulWidget {
  EditScreen({
    super.key,
    required this.name,
    required this.position,
    required this.department,
    required this.phone,
    required this.index,
    required this.salary,
    // required String urImage,
  });
  final String name;
  final String position;
  final String department;
  final String phone;
  final int index;
  final String salary;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  // String? _profile;

  // getImage() async {
  //   final image =
  //       await ImagePicker.platform.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _profile = image!.path;
  //   });
  // }

  @override
  void initState() {
    _nameController.text = widget.name;
    _positionController.text = widget.position;
    _departmentController.text = widget.department;
    _phoneController.text = widget.phone;
    _salaryController.text = widget.salary;
    // _profile = widget.urImage;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    _salaryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const ListScreen()));
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'EDIT EMBLOYEE DETAILS !',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              final valid = _formKey.currentState!.validate();
              final data = EmployeeModel(
                name: _nameController.text,
                position: _positionController.text,
                department: _departmentController.text,
                phone: _phoneController.text,
                salary: _salaryController.text,
                // urImage: _profile,
              );

              Hive.box<EmployeeModel>('employeedb').putAt(widget.index, data);
              if (valid &&
                  data.name!.isNotEmpty &&
                  data.position!.isNotEmpty &&
                  data.department!.isNotEmpty &&
                  data.phone!.isNotEmpty &&
                  data.salary!.isNotEmpty) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListScreen()));
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(' Employee Details Updated'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            icon: const Icon(Icons.upgrade_sharp),
            label: const Text(
              'UPDATE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 14,
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter name';
                      }
                      if (value.length < 3) {
                        return 'Name must be include 3 letter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 20,
                    controller: _positionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Position'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter position';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 14,
                    controller: _departmentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Department'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter department';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Phone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Phone';
                      }
                      if (value.length <= 9) {
                        return 'please enter valid number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _salaryController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Salary'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Salary';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Image.file(File(_profile!))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // getImage();
        },
        child: const Icon(
          Icons.camera,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
