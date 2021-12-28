// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'River.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RiverAdapter extends TypeAdapter<River> {
  @override
  final int typeId = 0;

  @override
  River read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return River()
      ..Bacino = fields[0] as String
      ..Comune = fields[1] as String
      ..Corso_Acqua = fields[2] as String
      ..Localita = fields[3] as String
      ..Massimo24H = fields[4] as String
      ..Ora_Rif = fields[5] as String
      ..Ora_Loc = fields[6] as String
      ..Provincia = fields[7] as String
      ..Valore_ora_rif = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, River obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.Bacino)
      ..writeByte(1)
      ..write(obj.Comune)
      ..writeByte(2)
      ..write(obj.Corso_Acqua)
      ..writeByte(3)
      ..write(obj.Localita)
      ..writeByte(4)
      ..write(obj.Massimo24H)
      ..writeByte(5)
      ..write(obj.Ora_Rif)
      ..writeByte(6)
      ..write(obj.Ora_Loc)
      ..writeByte(7)
      ..write(obj.Provincia)
      ..writeByte(8)
      ..write(obj.Valore_ora_rif);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RiverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
