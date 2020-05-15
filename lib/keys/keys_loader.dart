
import 'package:virtual_mall/keys/keys_model.dart';
class KeysLoader {
  final String secretPath;

  KeysLoader({this.secretPath});

  Keys load() =>
    Keys(appKey: "CRAQzrsSIAhqWQjCfZXm");

}