import 'package:hive/hive.dart';

part 'River.g.dart';

@HiveType(typeId: 0)
class River extends HiveObject{
  @HiveField(0)
  String Bacino;

  @HiveField(1)
  String Comune;

  @HiveField( 2)
  String Corso_Acqua;

  @HiveField(3)
  String Localita;

  @HiveField(4)
  String Massimo24H;

  @HiveField(5)
  String Ora_Rif;

  @HiveField(6)
  String Ora_Loc;

  @HiveField(7)
  String Provincia;

  @HiveField(8)
  String Valore_ora_rif;

}