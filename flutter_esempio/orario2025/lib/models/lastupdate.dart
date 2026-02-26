
class LastUpdate {
  String lastUpdate;
  String appVersion;
  String appBuild;

  LastUpdate({required this.lastUpdate,required this.appVersion,required this.appBuild});

  factory LastUpdate.fromJson(dynamic json){
    return LastUpdate(
        lastUpdate: "${json['last_update']}",
        appVersion: "${json['version_app']}",
        appBuild: "${json['version_build']}"
    );
  }

  Map toJson() => {
    "last_update": lastUpdate,
  };
}