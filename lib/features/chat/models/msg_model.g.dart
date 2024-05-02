// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msg_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MsgModelAdapter extends TypeAdapter<MsgModel> {
  @override
  final int typeId = 1;

  @override
  MsgModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MsgModel(
      userId: fields[0] as String,
      sentBy: fields[1] as String,
      msg: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MsgModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.sentBy)
      ..writeByte(2)
      ..write(obj.msg)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MsgModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
