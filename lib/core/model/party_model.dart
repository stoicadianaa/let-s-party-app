class PartyModel {
  String? description;
  String? name;
  String? pictureLink;
  String? hostEmail;
  DateTime? rsvp;
  DateTime? when;
  String? where;
  List<String>? tags;

  String getCurrentUserEmail() {
    return "stevenBoss@gmail.com";
  }

  PartyModel(this.description, this.name, this.pictureLink, this.hostEmail,
      this.rsvp, this.when, this.where, this.tags);

  PartyModel.fromMap(Map<String,dynamic> map) {
    description = map["description"] as String;
    hostEmail = map["hostEmail"] as String;
    name = map["name"] as String;
    pictureLink = map["pictureLink"] as String;
    rsvp = DateTime.parse(map["rsvp"] as String);
    tags = (map["tags"] as String).split(',');
    when = DateTime.parse(map["when"] as String);
    where = map["where"] as String;
  }

  bool isHostedByCurrentUser() {
    if (hostEmail == getCurrentUserEmail()) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'name:$name\n' +
           "hostEmail:$hostEmail\n" +
           "description:$description\n" +
           'where:$where';
  }
}