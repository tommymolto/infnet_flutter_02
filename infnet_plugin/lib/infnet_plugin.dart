
import 'dart:async';

import 'package:flutter/services.dart';

class InfnetPlugin {
  final String parametro;
  InfnetPlugin({ required this.parametro});
  static const MethodChannel _channel = MethodChannel('infnet_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  Future<String?> get parametroPassado async {
    final String? _parametroPassado = await _channel.invokeMethod('getParametroPassado', {
      'nome': parametro
    });
    return _parametroPassado;
  }

}
