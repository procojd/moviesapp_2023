// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddAdapter extends TypeAdapter<Add> {
  @override
  final int typeId = 0;

  @override
  Add read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Add(
      title: fields[0] as String?,
      overview: fields[1] as String?,
      backdrop: fields[2] as String?,
      poster: fields[3] as String?,
      rating: fields[4] as String?,
      releasedate: fields[5] as String?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Add obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.overview)
      ..writeByte(2)
      ..write(obj.backdrop)
      ..writeByte(3)
      ..write(obj.poster)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.releasedate)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
