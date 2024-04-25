// import 'dart:io';

// import 'package:empolyee_app/widgets/addEmployee.dart';
// import 'package:empolyee_app/widgets/searchScreen.dart';
// import 'package:empolyee_app/widgets/showDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';

// import '../models/employees.dart';
// import 'editScreen.dart';

// class ListScreen extends StatefulWidget {
//   const ListScreen({super.key});

//   @override
//   State<ListScreen> createState() => _ListScreenState();
// }

// class _ListScreenState extends State<ListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'EMPLOYEE   DETAILS',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showSearch(context: context, delegate: DataSearch());
//               },
//               icon: const Icon(Icons.search))
//         ],
//       ),
//       body: SafeArea(
//         child: ValueListenableBuilder(
//           valueListenable: Hive.box<EmployeeModel>('employeedb').listenable(),
//           builder: (context, Box<EmployeeModel> box, _) {
//             return ListView.builder(
//               itemCount: box.length,
//               itemBuilder: (ctx, i) {
//                 final data = box.getAt(i);
//                 return Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Card(
//                     child: ListTile(
//                       tileColor: Colors.black12,
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (ctx) => ShowDetails(
//                               name: data.name.toString(),
//                               position: data.position.toString(),
//                               department: data.department.toString(),
//                               phone: data.phone.toString(),
//                               salary: data.salary.toString(),
//                               profile: data.profile!),
//                         ));
//                       },
//                       title: Text(data!.name.toString()),
//                       leading: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Image.file(
//                           File(
//                             data.profile!.toString(),
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       trailing: Container(
//                         width: 70,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: IconButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pushReplacement(
//                                     MaterialPageRoute(
//                                       builder: (ctx) => EditScreen(
//                                         name: data.name.toString(),
//                                         position: data.position.toString(),
//                                         department: data.department.toString(),
//                                         phone: data.phone.toString(),
//                                         salary: data.salary.toString(),
//                                         profile: data.profile!,
//                                         index: i,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(
//                                   Icons.edit,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                       context: context,
//                                       useSafeArea: true,
//                                       builder: (context) => AlertDialog(
//                                             title: const Text(
//                                               'Delete',
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             content: const Text(
//                                               'Are you Sure ?',
//                                               style: TextStyle(
//                                                   fontSize: 25,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             actions: [
//                                               ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         Colors.white),
//                                                 onPressed: () {
//                                                   box.deleteAt(i);
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text(
//                                                   'yes',
//                                                   style: TextStyle(
//                                                       color: Colors.red),
//                                                 ),
//                                               ),
//                                               TextButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: const Text('No'))
//                                             ],
//                                           ));
//                                 },
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (ctx) => const AddEmployee()));
//         },
//         label: const Text('+ Add Employee'),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:empolyee_app/widgets/searchScreen.dart';
import 'package:empolyee_app/widgets/showDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/employees.dart';
import 'addEmployee.dart';
import 'editScreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EMPLOYEE   RECORD',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<EmployeeModel>('employeedb').listenable(),
          builder: (context, Box<EmployeeModel> box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, i) {
                final data = box.getAt(i);
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.black12,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ShowDetails(
                            name: data.name.toString(),
                            position: data.position.toString(),
                            department: data.department.toString(),
                            phone: data.phone.toString(),
                            salary: data.salary.toString(),
                            // urimage: data.urImage!
                          ),
                        ));
                      },
                      title: Text(data!.name.toString()),
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // child: Image.file(
                        //   File(
                        //     data.urImage!.toString(),
                        //   ),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      trailing: Container(
                        width: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => EditScreen(
                                        name: data.name.toString(),
                                        position: data.position.toString(),
                                        department: data.department.toString(),
                                        phone: data.phone.toString(),
                                        salary: data.salary.toString(),
                                        // urImage: data.urImage!,
                                        index: i,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                              'Are you Sure ?',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  box.deleteAt(i);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'yes',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No'))
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AddEmployee()));
        },
        label: const Text('+ Add Employee'),
      ),
    );
  }
}
