import 'package:cloud_firestore/cloud_firestore.dart';

class PartyModel {
  String? description;
  String? name;
  String? pictureLink;
  String? hostEmail;
  DateTime? rsvp;
  DateTime? when;
  String? where;
  String? id;
  List<String>? tags;

  String getCurrentUserEmail() {
    return "stevenBoss@gmail.com";
  }

  PartyModel(
    this.description,
    this.name,
    this.pictureLink,
    this.hostEmail,
    this.rsvp,
    this.when,
    this.where,
    this.tags, {
    this.id = '',
  });

  PartyModel.fromMap(Map<String, dynamic> map) {
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

  PartyModel.fromQueryDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    description = doc['description'] as String;
    name = doc['name'] as String;
    pictureLink = doc['pictureLink'] as String;
    hostEmail = doc['hostEmail'] as String;
    rsvp = DateTime.tryParse(doc['rsvp'] as String);
    when = DateTime.tryParse(doc['when'] as String);
    where = doc['where'] as String;
    tags = (doc['tags'] as String).split(",");
    id = doc.id;
  }

  @override
  String toString() {
    return 'name:$name\n' +
        "hostEmail:$hostEmail\n" +
        "description:$description\n" +
        'where:$where';
  }
}
