import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnviromentConfig{
  final movieApiKey = const String.fromEnvironment("movieAppKey");
}

final enviromenConfigProvider = Provider<EnviromentConfig>((ref){
  return EnviromentConfig();
});