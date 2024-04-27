import 'package:hive_flutter/adapters.dart';

import 'package:empolyee_app/models/employeeModel.g.dart';

@HiveType(typeId: 0)
class EmployeeModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? position;
  @HiveField(2)
  String? department;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? salary;
  @HiveField(5)
  String? urImage;

  EmployeeModel(
      {required this.name,
      required this.position,
      required this.department,
      required this.phone,
      required this.salary,
      required this.urImage});

  double calculateNetSalary(double taxRate, double insuranceAmount) {
    double grossSalary = double.parse(salary!);
    double deductions = (grossSalary * taxRate) + insuranceAmount;
    double netSalary = grossSalary - deductions;
    return netSalary;
  }
}
