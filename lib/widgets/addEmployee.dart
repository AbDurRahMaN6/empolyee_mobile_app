import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

import '../models/employees.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  String? name;
  String? position;
  String? department;
  String? phone;
  String? salary;

  double taxRate = 0.1;
  double insuranceAmount = 100;

  Future<void> getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid && _image!.isNotEmpty) {
      Hive.box<EmployeeModel>('employeedb').add(EmployeeModel(
          name: name,
          position: position,
          department: department,
          phone: phone,
          urImage: _image,
          salary: salary));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('New Employee Details Added'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  double _calculateNetSalary() {
    double grossSalary = double.parse(salary ?? '0');
    double deductions = (grossSalary * taxRate) + insuranceAmount;
    double netSalary = grossSalary - deductions;
    return netSalary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'ADD EMPLOYEE DETAILS',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  submitData();
                },
                icon: const Icon(Icons.save_sharp),
                label: const Text(
                  'SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ]),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter name';
                    }
                    if (value.length < 5) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Position'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter position';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      position = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Department'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter name';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      department = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Phone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter phone';
                    }
                    if (value.length <= 9) {
                      return 'please enter valid number';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Salary'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter salary';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      salary = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Net Salary: \$${_calculateNetSalary()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 40,
                ),
                _image == null
                    ? Container(
                        height: 380,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        )),
                        child: const Center(
                          child: Text(
                            'Please Upload an Image ! ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      )
                    : Image.file(File(_image!))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
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
