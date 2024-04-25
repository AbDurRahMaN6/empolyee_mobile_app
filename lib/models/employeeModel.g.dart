import 'package:empolyee_app/models/employees.dart';
import 'package:hive/hive.dart';

class EmployeeModelAdapter extends TypeAdapter<EmployeeModel> {
  @override
  final int typeId = 0;

  @override
  EmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeModel(
      name: fields[0] as String?,
      position: fields[1] as String?,
      department: fields[2] as String?,
      phone: fields[3] as String?,
      salary: fields[4] as String?,
      // urImage: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.salary);
    // ..writeByte(5)
    // ..write(obj.urImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
