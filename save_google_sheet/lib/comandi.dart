
class Comandi {
  final String _cmd;

  Comandi(this._cmd);

  String cmdParams() => "?cmd=$_cmd";
}
