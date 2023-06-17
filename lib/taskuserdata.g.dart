// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskuserdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskUserDataAdapter extends TypeAdapter<TaskUserData> {
  @override
  final int typeId = 12;

  @override
  TaskUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskUserData(
      lastUpdated: fields[5] as String,
      tasks: (fields[4] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskUserData obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.tasks)
      ..writeByte(5)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
