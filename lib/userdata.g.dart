// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 14;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      name: fields[0] as String,
      currentTasks: (fields[1] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      completedTasks: (fields[2] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      outdatedTasks: (fields[3] as List)
          .map((dynamic e) => (e as List).cast<dynamic>())
          .toList(),
      progress: (fields[4] as Map).cast<String, int>(),
      lastUpdated: fields[5] as String,
      currentProgress: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.currentTasks)
      ..writeByte(2)
      ..write(obj.completedTasks)
      ..writeByte(3)
      ..write(obj.outdatedTasks)
      ..writeByte(4)
      ..write(obj.progress)
      ..writeByte(5)
      ..write(obj.lastUpdated)
      ..writeByte(6)
      ..write(obj.currentProgress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
