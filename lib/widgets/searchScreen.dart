import 'package:empolyee_app/widgets/showDetails.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/employees.dart';

class DataSearch extends SearchDelegate<EmployeeModel> {
  final employeeBox = Hive.box<EmployeeModel>('employeedb');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = employeeBox.values
        .where((employeeModel) =>
            employeeModel.position!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return result.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search_off,
                size: 80,
              ),
              Text(
                'No results found !',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ))
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ShowDetails(
                        name: result[index].name!,
                        position: result[index].position!,
                        department: result[index].department!,
                        phone: result[index].phone!,
                        salary: result[index].salary!,
                        // urimage: result[index].urImage!
                      ),
                    ),
                  );
                },
                title: Text(result[index].name!),
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = employeeBox.values
        .where((employeeModel) =>
            employeeModel.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestion[index].name!),
            onTap: () {
              query = suggestion[index].name!;
              showResults(context);
              final result = employeeBox.values
                  .where((employeeModel) => employeeModel.name!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
              ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ShowDetails(
                              name: result[index].name!,
                              position: result[index].position!,
                              department: result[index].department!,
                              phone: result[index].phone!,
                              salary: result[index].salary!,
                              // urimage: result[index].urImage!
                            ),
                          ),
                        );
                      },
                      title: Text(result[index].name!),
                    );
                  });
            },
          );
        });
  }
}
