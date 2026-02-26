import 'package:flutter/material.dart';

class Comandi {
  String _cmd;

  Comandi(this._cmd);

  String cmdParams() => "?cmd=$_cmd";
}
