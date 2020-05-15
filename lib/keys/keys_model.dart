class Keys {
  final String appKey;
  Keys({this.appKey = ""});
  factory Keys.fromJson(Map<String, dynamic> jsonMap) {
    return new Keys(appKey: jsonMap["app_key"]);
  }
}